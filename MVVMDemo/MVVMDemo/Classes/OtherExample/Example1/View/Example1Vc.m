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
#import "UIView+Events.h"
#import "SUIUtils.h"
#import "FirstViewModel.h"
#import "NSObject+XYProperties.h"
#import "XYMediator.h"
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
    
    /// 设置firstView的事件处理者代理为viewManager  (代理的方式)
    [self.firstView xy_viewWithViewManager:self.viewManager];
    /// 设置firstView的事件处理者block  (block的方式)
    self.firstView.viewEventsBlock = [self.viewManager xy_viewManagerWithViewEventBlockOfInfos:@{@"view": self.firstView}];
    /// viewModel和viewManager之间通过代理方式交互
    self.viewManager.viewMangerDelegate = self.viewModel;
    self.viewModel.viewModelDelegate = self.viewManager;
    
    /// viewModel和viewManager之间通过block方式交互
    self.viewManager.viewModelInfosBlock = [self.viewModel xy_viewModelWithViewMangerBlockOfInfos:@{@"info": @"viewManager"}];
    
    /// 中介者传值
    XYMediator *mediator = [XYMediator mediatorWithViewModel:self.viewModel viewManager:self.viewManager];
    self.viewManager.xy_mediator = mediator;
    self.viewModel.xy_mediator = mediator;
    
    self.viewManager.xy_viewMangerInfos = @{@"xxxx": @"11111"};
    [self.viewManager xy_notify];
    NSLog(@"%@", self.viewModel.xy_viewModelInfos);
    
    self.viewModel.xy_viewModelInfos = @{@"ooooo": @"2222222"};
    [self.viewModel xy_notify];
    NSLog(@"%@", self.viewManager.xy_viewMangerInfos);
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
    [self.firstView xy_configViewWithViewModel:self.viewModel];
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
