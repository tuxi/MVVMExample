//
//  Example3VC.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "Example3VC.h"

@interface Example3VC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Example3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.title = @"Example3VC";
    
}

@end
