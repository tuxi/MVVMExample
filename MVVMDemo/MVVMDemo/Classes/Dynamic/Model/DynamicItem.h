//
//  DynamicItem.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThirdContentItem;
@interface DynamicItem : NSObject

@property (nonatomic, copy) NSString *subtype;
@property (nonatomic, strong) ThirdContentItem *content;

@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end

@interface ThirdContentItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *vip;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *pflag;
@property (nonatomic, copy) NSString *face;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *post;
@property (nonatomic, copy) NSString *ID;   /// 原字段为id 需处理
@property (nonatomic, strong) NSDictionary *rinfo;
@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *flag;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *znum;
@property (nonatomic, copy) NSString *anum;
@property (nonatomic, copy) NSString *contentoffset;
@property (nonatomic, copy) NSString *cnum;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *amobile;
@property (nonatomic, copy) NSString *aname;
@property (nonatomic, copy) NSString *snum;
@property (nonatomic, strong) NSArray *approval;
@property (nonatomic, strong) NSArray *comments;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
