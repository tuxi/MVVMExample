//
//  ThirdTableViewModel.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "ThirdTableViewModel.h"
#import "UITableViewCell+XYConfigure.h"
#import "ThirdTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ThirdDynamicItem.h"

static NSString *const myCellIdentifier = @"ThirdTableViewCell";

@interface ThirdTableViewModel ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ThirdTableViewModel

#pragma mark - public
- (void)prepareTableView:(UITableView *)tableView {
    tableView.delegate = self;
    tableView.dataSource = self;
    [ThirdTableViewCell xy_registerTableViewCell:tableView nibIdentifier:myCellIdentifier];
}

- (void)getDataSourceBlock:(NSArray *(^)())dataSource completion:(void (^)())completion {
    if (dataSource) {
        
        // 将模型数据添加到数组中
        [self.dataSource addObjectsFromArray:dataSource()];
        if (completion) {
            completion();
        }
        
    }
}

- (void)removeAllObjctFromDataSource {
    if (self.dataSource.count) {
        [self.dataSource removeAllObjects];
    }
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier forIndexPath:indexPath];
    [cell xy_config:cell model:[self itemAtIndexPath:indexPath] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 使用这个有其他bug
//    return [tableView fd_heightForCellWithIdentifier:myCellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
//        [cell xy_config:cell model:[self itemAtIndexPath:indexPath] indexPath:indexPath];
//    }];
    
    return [(ThirdDynamicItem *)[self itemAtIndexPath:indexPath] cellHeight];;
}

#pragma mark - lazy
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

#pragma mark - private

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataSource[indexPath.row];
}

@end
