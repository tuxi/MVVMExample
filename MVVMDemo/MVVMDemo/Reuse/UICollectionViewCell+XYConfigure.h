//
//  UICollectionViewCell+XYConfigure.h
//  
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYViewModelProtocol.h"

@interface UICollectionViewCell (XYConfigure)

/**
 *  从nib文件中根据重用标识符注册UICollectionViewcell
 */
+ (void)xy_registerCollect:(UICollectionView *)collect
        nibIdentifier:(NSString *)identifier;

/**
 *  从class根据重用标识符注册UICollectionViewcell
 */
+ (void)xy_registerCollect:(UICollectionView *)collect
              classIdentifier:(NSString *)identifier;

/**
 *  根据model配置UICollectionViewcell，设置UICollectionViewcell内容
 */
- (void)xy_configure:(UICollectionViewCell *)cell
        model:(id)model
        indexPath:(NSIndexPath *)indexPath;

/**
 *  根据viewModel配置UICollectionViewcell，设置UICollectionViewcell内容
 */
- (void)xy_configure:(UICollectionViewCell *)cell
        viewModel:(id<XYViewModelProtocol>)viewModel
        indexPath:(NSIndexPath *)indexPath;

/**
 *  获取自定义对象的cell高度
 */
+ (CGFloat)xy_getCellHeightWithModel:(id)model
        indexPath:(NSIndexPath *)indexPath;

@end
