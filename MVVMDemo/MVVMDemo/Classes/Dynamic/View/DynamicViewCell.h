//
//  DynamicViewCell.h
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "UITableViewCell+XYConfigure.h"
#import "XYCollectionViewModelProtocol.h"

@class DynamicPicContentViewModel;

@interface DynamicViewCell : UITableViewCell

@end

@interface DynamicPicContentView : UICollectionView
{
@public
    DynamicPicContentViewModel *_viewModel;
}
@end

@interface DynamicPicContentViewModel : NSObject <XYCollectionViewModelProtocol>

@end

@interface DynamicPicContentViewCell : UICollectionViewCell

@end
