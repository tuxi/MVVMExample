//
//  SecondTableView_ViewModel.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "SecondTableView_ViewModel.h"
#import "UITableViewCell+XYConfigure.h"
#import "UITableView+FDTemplateLayoutCell.h"

static NSString * const SecondCellIdentifier = @"SecondTableViewCell";

@interface SecondTableView_ViewModel ()

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation SecondTableView_ViewModel

#pragma mark - public
- (void)prepareTableView:(UITableView *)tableView {
    tableView.delegate = self;
    tableView.dataSource = self;
    /// 注册cell
    [UITableViewCell xy_registerTableViewCell:tableView nibIdentifier:SecondCellIdentifier];
}

- (void)getDataSourceBlock:(id (^)())dataSource completion:(void (^)())completion {
    if (dataSource) {
        self.dataList = dataSource();
        if (completion) {
            completion();
        }
    }
}


#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id item = self.dataList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SecondCellIdentifier forIndexPath:indexPath];
    [cell xy_configCellByModel:item indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = self.dataList[indexPath.row];
    
    return [tableView fd_heightForCellWithIdentifier:SecondCellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell xy_configCellByModel:item indexPath:indexPath];
    }];
}

#pragma mark - lazy 
- (NSArray *)dataList {
    if (_dataList == nil) {
        _dataList = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataList;
}

@end
