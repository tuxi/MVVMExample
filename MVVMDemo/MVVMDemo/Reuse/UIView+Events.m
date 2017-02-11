//
//  UIView+Events.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "UIView+Events.h"
#import <objc/runtime.h>

@implementation UIView (Events)

- (id<XYViewProtocol>)viewDelete {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setViewDelete:(id<XYViewProtocol>)viewDelete {
    objc_setAssociatedObject(self, @selector(viewDelete), viewDelete, OBJC_ASSOCIATION_ASSIGN);
}

- (ViewEventsBlock)viewEventsBlock {
    return objc_getAssociatedObject(self, @selector(viewEventsBlock));
}

- (void)setViewEventsBlock:(ViewEventsBlock)viewEventsBlock {
    return objc_setAssociatedObject(self, @selector(viewEventsBlock), viewEventsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)xy_viewWithViewManager:(id<XYViewProtocol>)viewManager {
    if (viewManager) {
        self.viewDelete = viewManager;
    }
}

@end
