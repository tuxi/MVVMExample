//
//  UITableView+NoDataPlaceholderExtend.m
//  MVVMDemo
//
//  Created by Ossey on 2017/5/30.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "UITableView+NoDataPlaceholderExtend.h"
#import <objc/runtime.h>

@interface UITableView () 

@end

@implementation UITableView (NoDataPlaceholderExtend)


#pragma mark - <NoDataPlaceholderDataSource>

- (NSAttributedString *)titleAttributedStringForNoDataPlaceholder:(UIScrollView *)scrollView {
    
    NSString *text = @"没有数据";
    UIFont *font = [UIFont boldSystemFontOfSize:18.0];
    UIColor *textColor = [UIColor redColor];
    
    NSMutableDictionary *attributeDict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentCenter;
    
    [attributeDict setObject:font forKey:NSFontAttributeName];
    [attributeDict setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributeDict setObject:style forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributeDict];
    
    return attributedString;
    
}

- (NSAttributedString *)detailAttributedStringForNoDataPlaceholder:(UIScrollView *)scrollView {
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributeDict = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentCenter;
    
    text = @"快去获取女神的动态吧~~~~~~~~~~~~~~~~~~~~";
    font = [UIFont systemFontOfSize:16.0];
    textColor = [UIColor greenColor];
    style.lineSpacing = 4.0;
    [attributeDict setObject:font forKey:NSFontAttributeName];
    [attributeDict setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributeDict setObject:style forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributeDict];
    
    return attributedString;
    
}

- (NSAttributedString *)reloadbuttonTitleAttributedStringForNoDataPlaceholder:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *text = @"加载";
    UIFont *font = [UIFont systemFontOfSize:15.0];
    UIColor *textColor = [UIColor blackColor];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}



- (UIImage *)imageForNoDataPlaceholder:(UIScrollView *)scrollView {
    if (self.loading) {
        return [UIImage imageNamed:@"loading_imgBlue_78x78" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    } else {
        
        UIImage *image = [UIImage imageNamed:@"Warning_64px"];
        return image;
    }
}

- (UIColor *)reloadButtonBackgroundColorForNoDataPlaceholder:(UIScrollView *)scrollView {
    return [UIColor orangeColor];
}

- (CGFloat)contentOffsetYForNoDataPlaceholder:(UIScrollView *)scrollView {
    return 0;
}

- (CGFloat)contentSubviewsVerticalSpaceFoNoDataPlaceholder:(UIScrollView *)scrollView {
    return 30;
}


#pragma mark - <NoDataPlaceholderDelegate>

- (void)noDataPlaceholder:(UIScrollView *)scrollView didTapOnContentView:(nonnull UITapGestureRecognizer *)tap {
    if (self.reloadButtonClickBlock) {
        self.reloadButtonClickBlock();
    }
}

- (void)noDataPlaceholder:(UIScrollView *)scrollView didClickReloadButton:(UIButton *)button {
    
    if (self.reloadButtonClickBlock) {
        self.reloadButtonClickBlock();
    }
    
}


- (BOOL)noDataPlaceholderShouldAnimateImageView:(UIScrollView *)scrollView {
    return self.loading;
}

- (CAAnimation *)imageAnimationForNoDataPlaceholder:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}


- (UIView *)customViewForNoDataPlaceholder:(UIScrollView *)scrollview {
    if (self.isLoading) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        return activityView;
    }else {
        return nil;
    }
}

- (BOOL)noDataPlaceholderShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

#pragma mark - set \ get 

- (void)setLoading:(BOOL)loading {
    
    [super setLoading:loading];
    
    self.noDataPlaceholderDataSource = self;
    self.noDataPlaceholderDelegate = self;
    [self reloadNoDataView];
    
}

- (BOOL)isLoading {
    return [super isLoading];
}

- (void (^)())reloadButtonClickBlock {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setReloadButtonClickBlock:(void (^)())reloadButtonClickBlock {
    objc_setAssociatedObject(self, @selector(reloadButtonClickBlock), reloadButtonClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
