//
//  DynamicTableViewModel.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "DynamicTableViewModel.h"
#import "UITableViewCell+XYConfigure.h"
#import "DynamicViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DynamicItem.h"

static NSString *const myCellIdentifier = @"DynamicViewCell";

@interface DynamicTableViewModel ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DynamicTableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldRemoveDataSourceWhenRequestNewData = YES;
    }
    return self;
}

#pragma mark - public
- (void)prepareTableView:(UITableView *)tableView {
    tableView.delegate = self;
    tableView.dataSource = self;
    [DynamicViewCell xy_registerTableViewCell:tableView nibIdentifier:myCellIdentifier];
}

- (void)getDataSourceWithRequestType:(BOOL)isNewData dataSourceBlock:(id (^)())dataSource completion:(void (^)())completion {
    if (dataSource) {
        
        if (_shouldRemoveDataSourceWhenRequestNewData && isNewData) {
            [self removeAllObjctFromDataSource];
        }
        
        // 将模型数据添加到数组中
        NSArray *list = dataSource();
        if ([list isKindOfClass:[NSArray class]]) {
            if (!self.dataSource) {
                self.dataSource = [NSMutableArray arrayWithCapacity:0];
            }
            [self.dataSource addObjectsFromArray:list];
        }
        if (completion) {
            completion();
        }
        list = nil;
        
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
    
    DynamicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier forIndexPath:indexPath];
    [cell xy_config:cell model:[self itemAtIndexPath:indexPath] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 使用这个有其他bug
//    return [tableView fd_heightForCellWithIdentifier:myCellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
//        [cell xy_config:cell model:[self itemAtIndexPath:indexPath] indexPath:indexPath];
//    }];
    
    return [(DynamicItem *)[self itemAtIndexPath:indexPath] cellHeight];;
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

- (void)dealloc {
    [self removeAllObjctFromDataSource];
    self.dataSource = nil;
}

@end
