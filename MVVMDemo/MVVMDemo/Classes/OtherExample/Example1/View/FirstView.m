//
//  FirstView.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "FirstView.h"
#import "UIView+XYConfigure.h"
#import "FirstViewModel.h"
#import "FirstModel.h"

@interface FirstView ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end
@implementation FirstView

- (IBAction)testBtnClick:(id)sender {
    

}

- (IBAction)jumpToOtherVc:(id)sender {
    
}
- (IBAction)jumpToTopicVc:(id)sender {
   }

- (void)xy_configViewByViewModel:(id<XYViewModelProtocol>)vm {
    
    /// 得到处理好的模型数据
    [vm xy_viewModelWithModelBlcok:^(id model) {
        FirstModel *m = (FirstModel *)model;
        self.testLabel.text = m.title;
        self.testLabel.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    }];
}
//- (void):(id<XYViewModelProtocol>)viewModel {
//   
//}

@end
