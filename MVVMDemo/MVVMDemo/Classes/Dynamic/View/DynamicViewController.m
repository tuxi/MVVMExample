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
#import "UIView+XYLoading.h"
#import "XYRefreshGifHeader.h"
#import "XYRefreshFooter.h"
#import "SDImageCache.h"

@interface DynamicViewController ()
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
    
    [self.tableView reloadBlock:^{
        [weakSelf loadDataFromNetworkByPage:weakSelf.currentPage];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [XYRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf loadDataFromNetworkByPage:weakSelf.currentPage];
    }];
    
    self.tableView.loadingView.loadingImgs = self.loadingImages;
    
}

- (void)loadDataFromNetworkByPage:(NSInteger)page {
    
    [self.tableView loading];
    __weak typeof(self) weakSelf = self;
    [self.requestViewModel xy_viewModelWithConfigRequest:^(id requestItem) {
        DynamicRequestItem *item = (DynamicRequestItem *)requestItem;
        item.page = @(page);
    }
                                     progress:nil
                                      success:^(id responseObject) {
                                          
                                          [weakSelf.tableView loadFinished];
                                          
                                          if (weakSelf.currentPage == 1) {
                                              
                                              [weakSelf.tableViewModel removeAllObjctFromDataSource];
                                          }
                                          
                                          [weakSelf.tableViewModel getDataSourceBlock:^NSArray *{
                                              return responseObject;
                                          } completion:^{
                                              [weakSelf.tableView reloadData];
                                              [weakSelf.tableView.mj_header endRefreshing];
                                              [weakSelf.tableView.mj_footer endRefreshing];
                                          }];
                                          
                                      } failure:^(NSError *error) {
                                          if (weakSelf.currentPage > 1) {
                                              weakSelf.currentPage--;
                                          }
                                          [weakSelf.tableView loadFailure];
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

- (NSMutableArray<UIImage *> *)loadingImages {
    if (_loadingImages == nil) {
        _loadingImages = [NSMutableArray arrayWithCapacity:24];
        for (NSInteger i = 0; i < 24; ++i) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%ld", i+1]];
            [_loadingImages addObject:image];
        }
    }
    return _loadingImages;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.frame = self.view.bounds;
        [self.view addSubview:(_tableView = tableView)];
    }
    return _tableView;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
