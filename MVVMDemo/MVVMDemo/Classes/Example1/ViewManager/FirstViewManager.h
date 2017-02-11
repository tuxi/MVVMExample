//
//  FirstViewManager.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/9.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYViewManagerProtocol.h"
#import "XYViewProtocol.h"
#import "XYViewModelProtocol.h"

@interface FirstViewManager : NSObject<XYViewManagerProtocol, XYViewProtocol, XYViewModelProtocol>

@end
