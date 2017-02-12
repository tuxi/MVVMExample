//
//  XYTableViewModelProtocol.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/12.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//  此协议 制定了处理tableView的代理和数据的协议

#import <UIKit/UIKit.h>

@protocol XYTableViewModelProtocol <UITableViewDelegate, UITableViewDataSource>

@required
/// 传入一个tableView，内部设置其代理和数据源对象, 及注册cell
- (void)prepareTableView:(UITableView *)tableView;
/// 获取模型数据源
- (void)getDataSourceBlock:(id (^)())dataSource completion:(void(^)())completion;

@optional
/// 删除所有数据源
- (void)removeAllObjctFromDataSource;

/// 根据索引删除数据源中的数据
- (void)removeObjcetAtIndex:(NSInteger)index;

@end
