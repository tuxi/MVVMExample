//
//  Example1Vc.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "Example1Vc.h"
#import "FirstView.h"
#import "FirstViewManager.h"
#import "SUIUtils.h"
#import "FirstViewModel.h"
#import "NSObject+XYProperties.h"
#import "UIView+XYConfigure.h"

@interface Example1Vc ()

@property (nonatomic, weak) FirstView *firstView;
@property (nonatomic, strong) FirstViewManager *viewManager;
@property (nonatomic, strong) FirstViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation Example1Vc

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

    /// viewModel和viewManager之间通过代理方式交互
    self.viewManager.viewMangerDelegate = self.viewModel;
    self.viewModel.viewModelDelegate = self.viewManager;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 初始化控件
- (void)setupUI {
    _btn.layer.cornerRadius = 10;
    _btn.layer.masksToBounds = YES;
}



#pragma mark - Events
- (IBAction)updateModelData:(id)sender {
    
    /// 根据viewModel配置view
    [self.firstView xy_configViewByViewModel:self.viewModel];
}


#pragma mark - lazy
- (FirstView *)firstView {
    if (_firstView == nil) {
        FirstView *view = [FirstView sui_loadInstanceFromNib];
        [self.view addSubview:view];
        view.frame = CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, 200);
        _firstView = view;
    }
    return _firstView;
}

- (FirstViewManager *)viewManager {
    if (_viewManager == nil) {
        _viewManager = [FirstViewManager new];
    }
    return _viewManager;
}

- (FirstViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [FirstViewModel new];
    }
    return _viewModel;
}

@end
