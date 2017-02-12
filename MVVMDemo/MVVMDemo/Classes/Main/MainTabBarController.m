//
//  MainTabBarController.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/12.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "HomePageViewController.h"
#import "DynamicViewController.h"
#import "MessageViewController.h"
#import "MeViewController.h"



@interface MainTabBarController ()

@end

@implementation MainTabBarController

+ (void)initialize {
    if (self == [MainTabBarController class]) {
        UITabBar *tabBar = [UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        [tabBar setBackgroundImage:[UIImage xy_imageWithColor:kColor(255, 255, 255, 1.0)]];
        
        UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorTabBarItemText_Sel} forState:UIControlStateSelected];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorTabBarItemText} forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildVC:[HomePageViewController new] imageNamed:@"find_tabbar_selecte" title:@"发现"];
    [self addChildVC:[DynamicViewController new] imageNamed:@"moment_tabbar_select" title:@"动态"];
    [self addChildVC:[MessageViewController new] imageNamed:@"chat_tabbar_select" title:@"消息"];
    [self addChildVC:[MeViewController new] imageNamed:@"mine_tabbar_select" title:@"我的"];
}

- (void)addChildVC:(UIViewController *)vc imageNamed:(NSString *)name title:(NSString *)title {
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.image = [UIImage imageNamed:name].xy_originalMode;
    nav.tabBarItem.title = title;
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
