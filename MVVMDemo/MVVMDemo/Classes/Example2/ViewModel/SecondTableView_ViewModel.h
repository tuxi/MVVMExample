//
//  SecondTableView_ViewModel.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondTableView_ViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

/// 传入一个tableView，内部设置其代理和数据源为SecondTableView_ViewModel类对象
- (void)handleWithTableView:(UITableView *)tableView;

/// 获取模型数据源
- (void)getModelListBlock:(NSArray *(^)())modelList completion:(void(^)())completion;
@end
