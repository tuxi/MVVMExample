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
#import "UITableView+NoDataPlaceholderExtend.h"

@interface DynamicViewController ()
@property (nonatomic, weak)  UITableView *tableView;
@property (nonatomic, strong) DynamicTableViewModel *tableViewModel;
@property (nonatomic, strong) DynamicRequestViewModel *requestViewModel;
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
    
    // 将tableView传给TableViewModel,由其最为tableView的代理和数据源
    [self.tableViewModel prepareTableView:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [XYRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataFromNetworkByRequestType:RequestDataTypeNew];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [XYRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataFromNetworkByRequestType:RequestDataTypeMore];
    }];
    
    self.tableView.reloadButtonClickBlock = ^{
        [weakSelf loadDataFromNetworkByRequestType:RequestDataTypeNew];

    };
}


- (void)loadDataFromNetworkByRequestType:(RequestDataType)requesType {
    
    self.tableView.loading = YES;
    __weak typeof(self) weakSelf = self;
    [self.requestViewModel xy_viewModelWithConfigRequest:^(id requestItem) {
        DynamicRequestItem *item = (DynamicRequestItem *)requestItem;
        item.requestType = requesType;
    }
                                                progress:nil
                                                 success:^(id responseObject) {
                                                     
                                                     [weakSelf.tableViewModel getDataSourceWithRequestType:requesType dataSourceBlock:^id{
                                                         return responseObject;
                                                     } completion:^{
                                                         weakSelf.tableView.loading = NO;
                                                         [weakSelf.tableView reloadData];
                                                         [weakSelf.tableView.mj_header endRefreshing];
                                                         [weakSelf.tableView.mj_footer endRefreshing];
                                                     }];
                                                     
                                                 } failure:^(NSError *error) {
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
