//
//  DynamicViewCell.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/11.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "DynamicViewCell.h"
#import "UIImageView+WebCache.h"
#import "DynamicItem.h"
#import "UIView+Events.h"
#import "XYImageViewer.h"
#import "UICollectionViewCell+XYConfigure.h"

#define SIZE_GLOAB_MARGIN 10
#define SIZE_CELL_BOTTOM_LINE 5
#define SIZE_CELL_SMALL_LINE 0.5
#define SIZE_PicContentHeight 80.0

@interface DynamicViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet DynamicPicContentView *picContentView;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picContentViewConstranitH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentContentConstrH;
@property (weak, nonatomic) IBOutlet UIView *commentContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentContentConstranitB;
@property (weak, nonatomic) IBOutlet UIButton *publishTime;
@property (weak, nonatomic) IBOutlet UIButton *commentNum;
@property (weak, nonatomic) IBOutlet UIButton *shareNum;
@property (weak, nonatomic) IBOutlet UIButton *likeNum;

@end
@implementation DynamicViewCell {
    DynamicItem *_item;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


/// 通过模型，更新子控件
- (void)xy_configCellByModel:(id)model indexPath:(NSIndexPath *)indexPath {
    
    @autoreleasepool {
        DynamicItem *item = (DynamicItem *)model;
        _item = item;
        [_iconView sd_setImageWithURL:[NSURL URLWithString:item.content.face]];
        _nameLabel.text = item.content.name;
        _postLabel.text = item.content.post;
        _text_label.text = item.content.text;
        
        [_publishTime setTitle:item.content.time forState:UIControlStateNormal];
        [_commentNum setTitle:item.content.cnum forState:UIControlStateNormal];
        [_likeNum setTitle:item.content.znum forState:UIControlStateNormal];
        [_shareNum setTitle:item.content.snum forState:UIControlStateNormal];
        
        if (item.content.image.count) {
            _picContentViewConstranitH.constant = [self calculatePicContentHeight:item indexPath:indexPath];
        } else {
            _picContentViewConstranitH.constant = 0.0;
        }
        [_picContentView->_viewModel getDataSourceBlock:^id{
            return item.content.image;
        } completion:^{
            [_picContentView reloadData];
        }];
        _commentContentConstrH.constant = [self calculateCommentContentH:item];
        
        if (!item.cellHeight) {
            /// 强制布局
            [self.contentView layoutIfNeeded];
            item.cellHeight = [self xy_getCellHeightWithModel:item indexPath:nil];
        }
    }
    
}

/// 计算cell的高度
- (CGFloat)xy_getCellHeightWithModel:(id)model indexPath:(NSIndexPath *)indexPath {
    DynamicItem *item = (DynamicItem *)model;
    CGFloat cellHeight = CGRectGetMaxY(_picContentView.frame);
    
    if (item.content.image.count == 0) {
        // 没有图片时，不必再添加间距了，因为xib约束之间已经添加了10的间距，其他也是相同
        cellHeight += CGRectGetHeight(_toolView.frame);
    } else {
        cellHeight += SIZE_GLOAB_MARGIN + CGRectGetHeight(_toolView.frame);
    }
    
    if (item.content.comments.count == 0) {
        cellHeight += SIZE_CELL_SMALL_LINE + SIZE_CELL_BOTTOM_LINE;
    } else {
        cellHeight += SIZE_GLOAB_MARGIN + CGRectGetHeight(_commentContentView.frame) + SIZE_CELL_SMALL_LINE + SIZE_CELL_BOTTOM_LINE;
    }
    
    
    return cellHeight;
}


#pragma mark - private


/// 计算picContent的高度
- (CGFloat)calculatePicContentHeight:(DynamicItem *)item indexPath:(NSIndexPath *)indexPath {
    
    return SIZE_PicContentHeight;
    
//    CGFloat picH = 0.0;
//    if (item.content.image.count) {
//
//        /// 计算picContentView的高度
//        
//        CGFloat x = 0;
//        CGFloat y = 0;
//        CGFloat padding = 5;
//        CGFloat w = 0;
//        CGFloat h = 0;
//        NSInteger columns = 0; // 总列数
//
//        if (item.content.image.count == 1) {
//            columns = 1;
//        }
//        
//        if (item.content.image.count >= 2 && item.content.image.count <= 4) {
//            columns = 2;
//        }
//        
//        if (item.content.image.count > 4) {
//            columns = 3;
//        }
//    
//        
//        CGFloat picContentW = [UIScreen mainScreen].bounds.size.width - SIZE_GLOAB_MARGIN * 2;
//        w = (picContentW - (columns - 1)*padding) / columns;
//        h = w;
//        
//        /// 计算总行数，小数向上取整
//        CGFloat rowsF = (item.content.image.count * 1.0) / columns;
//        NSInteger rows = ceil(rowsF);
//
//        _picContentView.hidden = NO;
//        picH = rows*w + (rows-1)*padding;
//        
//    } else {
//        _picContentView.hidden = YES;
//        picH = 0;
//    }
//    return picH;

}

/// 计算评论的高度
- (CGFloat)calculateCommentContentH:(DynamicItem *)item {
    CGFloat commentContentH = 0;
    if (item.content.comments.count == 0) {
        commentContentH = 0;
        _commentContentView.hidden = YES;
    } else {
        commentContentH = 100;
        _commentContentView.hidden = NO;
    }
    return commentContentH;
}

- (void)dealloc {
    
}

@end

@implementation DynamicPicContentView {
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    
    [[self viewModel] prepareCollectionView:self];
}



- (DynamicPicContentViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [DynamicPicContentViewModel new];
    }
    return _viewModel;
}

@end

@interface DynamicPicContentViewModel ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation DynamicPicContentViewModel

#pragma mark - XYCollectionViewModelProtocol

- (void)prepareCollectionView:(UICollectionView *)collectionView {
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.collectionViewLayout = [self layout];
    
    [DynamicPicContentViewCell xy_registerCollect:collectionView classIdentifier:NSStringFromClass([collectionView class])];
}

- (void)getDataSourceBlock:(id (^)())dataSource completion:(void (^)())completion {
    if (dataSource) {
        NSArray *list = dataSource();
        if ([list isKindOfClass:[NSArray class]]) {
            self.dataSource = [list mutableCopy];
        }
        if (completion) {
            completion();
        }
    }
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DynamicPicContentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([collectionView class]) forIndexPath:indexPath];
    
    [cell xy_configure:cell model:self.dataSource[indexPath.item] indexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(collectionView) weakCollectionView = collectionView;
    
//    NSIndexPath *orginIndexPath = indexPath;
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [[XYImageViewer prepareImageURLList:self.dataSource
                           pageTextList:nil
                                endView:^UIView *(NSIndexPath *indexPath) {
                                                    
                                                    // 当collectionViewCell 未显示的时候调用cellForItemAtIndexPath返回的可能为nil，这里让视图先滚动到那个cell，让其显示，再layoutIfNeeded刷新下，就可以获取到cell了，如果最终还是要显示原indexPath，可以再滚回来
                                                    
                                                    [weakCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
                                                    UICollectionViewCell *endView = [weakCollectionView cellForItemAtIndexPath:indexPath];
                                                    if (!endView) {
                                                        [weakCollectionView layoutIfNeeded];
                                                        endView = [weakCollectionView cellForItemAtIndexPath:indexPath];
                                                    }
                                                    
                                                    if(!endView) {
                                                        [weakCollectionView reloadData];
                                                        [weakCollectionView layoutIfNeeded];
                                                        endView = [weakCollectionView cellForItemAtIndexPath:indexPath];
                                                    }
                                                    
                                                    // 滚回之前的位置
//                                                    [weakCollectionView scrollToItemAtIndexPath:orginIndexPath atScrollPosition:0 animated:NO];
                                                    
                                                    return endView;
                                                }] show:cell currentIndex:indexPath.row];
}

#pragma mark - Get

- (UICollectionViewFlowLayout *)layout {
    if (_layout == nil) {
        _layout = [UICollectionViewFlowLayout new];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(SIZE_PicContentHeight, SIZE_PicContentHeight);
    }
    return _layout;
}

@end

@implementation DynamicPicContentViewCell {
    UIImageView *_imageView;
}

- (void)xy_configure:(UICollectionViewCell *)cell model:(id)model indexPath:(NSIndexPath *)indexPath {
    if (![model isKindOfClass:[NSString class]]) {
        return;
    }
    // 内存暴涨的问题出在这,未及时释放sd加载到内存中的图片
    [[self imageView] sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            // 解决图片全部加载内存中，导致内存暴涨的问题
//            [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
            [[SDWebImageManager sharedManager].imageCache clearMemory];
        }
    }];
    
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.frame = self.contentView.bounds;
    }
    return _imageView;
}


@end
