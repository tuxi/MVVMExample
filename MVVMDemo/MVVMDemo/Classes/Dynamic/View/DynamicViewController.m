//
//  DynamicViewController.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "DynamicViewController.h"
#import "DynamicTableViewModel.h"
#import "DynamicRequestViewModel.h"
//#import "UIView+XYLoading.h"
#import "XYRefreshGifHeader.h"
#import "XYRefreshFooter.h"
#import "SDImageCache.h"
#import "UIScrollView+NoDataPlaceholder.h"

@interface DynamicViewController () <NoDataPlaceholderDataSource, NoDataPlaceholderDelegate>
@property (nonatomic, weak)  UITableView *tableView;
@property (nonatomic, strong) DynamicTableViewModel *tableViewModel;
@property (nonatomic, strong) DynamicRequestViewModel *requestViewModel;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *loadingImages;
@end

@implementation DynamicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动态";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除动态" style:0 target:self action:@selector(clearDataSource)];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}



/// 对tableView进行初始化操作
- (void)initTableView {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.currentPage = 1;
    
    // 将tableView传给TableViewModel,由其最为tableView的代理和数据源
    [self.tableViewModel prepareTableView:self.tableView];
    
    // 加载数据
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [XYRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf loadDataFromNetworkByPage:weakSelf.currentPage];
    }];
    
//    [self.tableView reloadBlock:^{
//        [weakSelf loadDataFromNetworkByPage:weakSelf.currentPage];
//    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [XYRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf loadDataFromNetworkByPage:weakSelf.currentPage];
    }];
    
//    self.tableView.loadingView.loadingImgs = self.loadingImages;
    
    self.tableView.noDataPlaceholderDataSource = self;
    self.tableView.noDataPlaceholderDelegate = self;
    
    
}


- (void)loadDataFromNetworkByPage:(NSInteger)page {
    
//    [self.tableView loading];
    self.tableView.loading = YES;
    __weak typeof(self) weakSelf = self;
    [self.requestViewModel xy_viewModelWithConfigRequest:^(id requestItem) {
        DynamicRequestItem *item = (DynamicRequestItem *)requestItem;
        item.page = @(page);
    }
                                     progress:nil
                                      success:^(id responseObject) {
                                          
//                                          [weakSelf.tableView loadFinished];
                                          
                                          if (weakSelf.currentPage == 1) {
                                              
                                              [weakSelf.tableViewModel removeAllObjctFromDataSource];
                                          }
                                          
                                          [weakSelf.tableViewModel getDataSourceBlock:^NSArray *{
                                              return responseObject;
                                          } completion:^{
                                              weakSelf.tableView.loading = NO;
                                              [weakSelf.tableView reloadData];
                                              [weakSelf.tableView.mj_header endRefreshing];
                                              [weakSelf.tableView.mj_footer endRefreshing];
                                          }];
                                          
                                      } failure:^(NSError *error) {
                                          if (weakSelf.currentPage > 1) {
                                              weakSelf.currentPage--;
                                          }
//                                          [weakSelf.tableView loadFailure];
                                          weakSelf.tableView.loading = NO;
                                          [weakSelf.tableView.mj_header endRefreshing];
                                          [weakSelf.tableView.mj_footer endRefreshing];
                                          NSLog(@"%@", error.localizedDescription);
                                      }];
}


#pragma mark - lazy
- (DynamicTableViewModel *)tableViewModel {
    if (_tableViewModel == nil) {
        _tableViewModel = [DynamicTableViewModel new];
    }
    return _tableViewModel;
}

- (DynamicRequestViewModel *)requestViewModel {
    if (_requestViewModel == nil) {
        _requestViewModel = [DynamicRequestViewModel new];
    }
    return _requestViewModel;
}

//- (NSMutableArray<UIImage *> *)loadingImages {
//    if (_loadingImages == nil) {
//        _loadingImages = [NSMutableArray arrayWithCapacity:24];
//        for (NSInteger i = 0; i < 24; ++i) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%ld", i+1]];
//            [_loadingImages addObject:image];
//        }
//    }
//    return _loadingImages;
//}

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.frame = self.view.bounds;
        [self.view addSubview:(_tableView = tableView)];
    }
    return _tableView;
}

#pragma mark - <NoDataPlaceholderDataSource>

- (NSAttributedString *)titleAttributedStringForNoDataPlaceholder:(UIScrollView *)scrollView {
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    text = @"没有数据";
    font = [UIFont boldSystemFontOfSize:18.0];
    textColor = [UIColor redColor];
    
    NSMutableDictionary *attributeDict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentCenter;
    
    [attributeDict setObject:font forKey:NSFontAttributeName];
    [attributeDict setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributeDict setObject:style forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributeDict];
    
    return attributedString;
    
}

- (NSAttributedString *)detailAttributedStringForNoDataPlaceholder:(UIScrollView *)scrollView {
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributeDict = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentCenter;
    
    text = @"快去获取女神的动态吧~~~~~~~~~~~~~~~~~~~~";
    font = [UIFont systemFontOfSize:16.0];
    textColor = [UIColor greenColor];
    style.lineSpacing = 4.0;
    [attributeDict setObject:font forKey:NSFontAttributeName];
    [attributeDict setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributeDict setObject:style forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributeDict];
    
    return attributedString;
    
}

- (NSAttributedString *)reloadbuttonTitleAttributedStringForNoDataPlaceholder:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *text = @"加载";
    UIFont *font = [UIFont systemFontOfSize:15.0];
    UIColor *textColor = [UIColor blackColor];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



- (UIImage *)imageForNoDataPlaceholder:(UIScrollView *)scrollView {
    if (self.tableView.loading) {
        return [UIImage imageNamed:@"loading_imgBlue_78x78" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    } else {
        
        UIImage *image = [UIImage imageNamed:@"Warning_64px"];
        return image;
    }
}

- (UIColor *)reloadButtonBackgroundColorForNoDataPlaceholder:(UIScrollView *)scrollView {
    return [UIColor orangeColor];
}

- (CGFloat)contentOffsetYForNoDataPlaceholder:(UIScrollView *)scrollView {
    return 0;
}

- (CGFloat)contentSubviewsVerticalSpaceFoNoDataPlaceholder:(UIScrollView *)scrollView {
    return 30;
}


#pragma mark - <NoDataPlaceholderDelegate>

- (void)noDataPlaceholder:(UIScrollView *)scrollView didTapOnContentView:(nonnull UITapGestureRecognizer *)tap {
    [self loadDataFromNetworkByPage:1];
}

- (void)noDataPlaceholder:(UIScrollView *)scrollView didClickReloadButton:(UIButton *)button {
    
    [self loadDataFromNetworkByPage:1];
    
}


- (BOOL)noDataPlaceholderShouldAnimateImageView:(UIScrollView *)scrollView {
    return self.tableView.loading;
}

- (CAAnimation *)imageAnimationForNoDataPlaceholder:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}


- (UIView *)customViewForNoDataPlaceholder:(UIScrollView *)scrollview {
    if (self.tableView.isLoading) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        return activityView;
    }else {
        return nil;
    }
}

- (BOOL)noDataPlaceholderShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

#pragma mark - Other

- (void)dealloc {
    NSLog(@"%s", __func__);
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)clearDataSource {
    [self.tableViewModel removeAllObjctFromDataSource];
    [self.tableView reloadData];
}


@end
