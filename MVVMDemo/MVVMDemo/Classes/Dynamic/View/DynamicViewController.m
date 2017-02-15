//
//  DynamicViewController.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "DynamicViewController.h"
#import "ThirdTableViewModel.h"
#import "ThirdViewModel.h"
#import "SUIUtils.h"
#import "UIView+XYLoading.h"
#import "XYRefreshGifHeader.h"
#import "XYRefreshFooter.h"
#import "ThirdRequestItem.h"

@interface DynamicViewController ()
@property (nonatomic, weak)  UITableView *tableView;
@property (nonatomic, strong) ThirdTableViewModel *tableViewModel;
@property (nonatomic, strong) ThirdViewModel *viewModel;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *loadingImages;
@end

@implementation DynamicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动态";
    [self initTableView];
}


/// 对tableView进行初始化操作
- (void)initTableView {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.currentPage = 1;
    
    // 将tableView传给TableViewModel,由其最为tableView的代理和数据源
    [self.tableViewModel prepareTableView:self.tableView];
    
    // 加载数据
    uWeakSelf
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
    [self.viewModel xy_viewModelWithConfigRequest:^(id requestItem) {
        ThirdRequestItem *item = (ThirdRequestItem *)requestItem;
        item.page = @(page);
    }
                                     progress:nil
                                      success:^(id responseObject) {
                                          
                                          [self.tableView loadFinished];
                                          
                                          if (self.currentPage == 1) {
                                              
                                              [self.tableViewModel removeAllObjctFromDataSource];
                                          }
                                          
                                          [self.tableViewModel getDataSourceBlock:^NSArray *{
                                              return responseObject;
                                          } completion:^{
                                              [self.tableView reloadData];
                                              [self.tableView.mj_header endRefreshing];
                                              [self.tableView.mj_footer endRefreshing];
                                          }];
                                          
                                      } failure:^(NSError *error) {
                                          if (self.currentPage > 1) {
                                              self.currentPage--;
                                          }
                                          [self.tableView loadFailure];
                                          [self.tableView.mj_header endRefreshing];
                                          [self.tableView.mj_footer endRefreshing];
                                          NSLog(@"%@", error.localizedDescription);
                                      }];
}


#pragma mark - lazy
- (ThirdTableViewModel *)tableViewModel {
    if (_tableViewModel == nil) {
        _tableViewModel = [ThirdTableViewModel new];
    }
    return _tableViewModel;
}

- (ThirdViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [ThirdViewModel new];
    }
    return _viewModel;
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
}

@end
