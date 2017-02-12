//
//  XYLoadingView.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XYLoadingState) {
    XYLoadingStateLoading,
    XYLoadingStateFinished,
    XYLoadingStateFailure
};

@interface XYLoadingView : UIView

/// 加载时显示的文字
@property (nonatomic, copy) NSString *loadingText;
/// 点击重新按钮加载回调
@property (nonatomic, copy) void(^reloadBlock)();
/// 当前加载状态
@property (nonatomic, assign) XYLoadingState state;
/// 正在加载时播放一组图片序列帧，显示此动画时，不显示菊花
@property (nonatomic, strong) NSArray<UIImage *> *loadingImgs;

/// 正在加载中
- (void)loading;
/// 加载完成
- (void)loadFinished;
/// 加载失败
- (void)loadFailure;


@end
