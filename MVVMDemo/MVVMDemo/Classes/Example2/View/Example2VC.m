//
//  Example2VC.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "Example2VC.h"
#import "SecondViewModel.h"
#import "SecondTableView_ViewModel.h"
#import "SUIUtils.h"
#import "XYLoadingView.h"

@interface Example2VC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SecondTableView_ViewModel *tableView_ViewModel;
@property (nonatomic, strong) SecondViewModel *vm;
@property (nonatomic, strong) XYLoadingView *loadingView;

@end

@implementation Example2VC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
}

/// 对tableView进行初始化操作
- (void)initTableView {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /// 传递tableView给tableView_ViewModel，将tableView的代理和数据源转交给tableView_ViewModel
    [self.tableView_ViewModel handleWithTableView:self.tableView];
    
    uWeakSelf
    [self.loadingView loading];
    [self.vm xy_viewModelWithProgress:nil success:^(id responseObject) {
        
        [weakSelf.loadingView loadFinished];
        /// 将数据传给tableView_ViewModel，由其内部处理
        [weakSelf.tableView_ViewModel getModelListBlock:^NSArray *{
            return responseObject;
        } completion:^{
            /// 加载完成后 刷新数据源
            [weakSelf.tableView reloadData];
        }];
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
  
        [weakSelf.loadingView loadFailure];
    }];
}



#pragma mark - lazy
- (XYLoadingView *)loadingView {
    if (_loadingView == nil) {
        
        XYLoadingView *loadingView = [XYLoadingView new];
        loadingView.frame = self.view.bounds;
        [self.view addSubview:(_loadingView = loadingView)];
        _loadingView = loadingView;
    
    }
    return _loadingView;
}

- (SecondTableView_ViewModel *)tableView_ViewModel {
    if (_tableView_ViewModel == nil) {
        _tableView_ViewModel = [SecondTableView_ViewModel new];
    }
    return _tableView_ViewModel;
}

- (SecondViewModel *)vm {
    if (_vm == nil) {
        _vm = [SecondViewModel new];
    }
    return _vm;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
