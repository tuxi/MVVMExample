//
//  XYRefreshGifHeader.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/12.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYRefreshGifHeader.h"

@implementation XYRefreshGifHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
        
        /// 正在刷新状态的图片
        NSMutableArray *pullingImgs = [NSMutableArray arrayWithCapacity:33];
        for (int i = 1; i < 34; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pulldown%d", i]];
            [pullingImgs addObject:image];
        }
        
        /// 松开可以刷新状态的图片
        NSMutableArray *refreshingImgs = [NSMutableArray arrayWithCapacity:8];
        for (int i = 1; i < 9; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pullcircle%d", i]];
            [refreshingImgs addObject:image];
        }
        
        [self setImages:refreshingImgs forState:MJRefreshStateRefreshing];
        [self setImages:pullingImgs forState:MJRefreshStatePulling];
        [self setImages:@[[UIImage imageNamed:@"pulldown1"], [UIImage imageNamed:@"pulldown2"]] forState:MJRefreshStateIdle];
        
    }
    
    return self;
}


@end
