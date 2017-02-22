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

#define SIZE_GLOAB_MARGIN 10
#define SIZE_CELL_BOTTOM_LINE 5
#define SIZE_CELL_SMALL_LINE 0.5

@interface DynamicViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIView *picContentView;
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
    
    [self initPicContentView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


/// 通过模型，更新子控件
- (void)xy_config:(UITableViewCell *)cell model:(id)model indexPath:(NSIndexPath *)indexPath {
    
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
    
    _picContentViewConstranitH.constant = [self calculatePicContentHeight:item indexPath:indexPath];
    _commentContentConstrH.constant = [self calculateCommentContentH:item];
    
    if (!item.cellHeight) {
        /// 强制布局
        [self.contentView layoutIfNeeded];
        item.cellHeight = [self xy_getCellHeightWithModel:item indexPath:nil];
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
- (void)initPicContentView {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat padding = 5;
    NSInteger rc = 3; // 行和列都是3
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - SIZE_GLOAB_MARGIN * 2 - 2 * padding) / 3;
    CGFloat h = w;
    // 一开始就给picContent创建9个imageView,不在更新模型的时候创建，那样性能会有影响
    // 最多只能发布9张图片
    for (NSInteger i = 0; i < 9; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [_picContentView addSubview:imageView];
        imageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picClick:)]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = i + 1;
        /// 每个图片所在的列数和行数
        NSInteger column = i % rc;
        NSInteger row = i / rc;
        x = (padding + w) * column;
        y = (padding + h) * row;
        
        imageView.frame = CGRectMake(x, y, w, h);
        
    }
    
}


/// 计算picContent的高度
- (CGFloat)calculatePicContentHeight:(DynamicItem *)item indexPath:(NSIndexPath *)indexPath {
    
    CGFloat picH = 0.0;
    if (item.content.image.count) {

        /// 计算picContentView的高度
        
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat padding = 5;
        CGFloat w = 0;
        CGFloat h = 0;
        NSInteger columns = 0; // 总列数

        if (item.content.image.count == 1) {
            columns = 1;
        }
        
        if (item.content.image.count >= 2 && item.content.image.count <= 4) {
            columns = 2;
        }
        
        if (item.content.image.count > 4) {
            columns = 3;
        }
    
        
        CGFloat picContentW = [UIScreen mainScreen].bounds.size.width - SIZE_GLOAB_MARGIN * 2;
        w = (picContentW - (columns - 1)*padding) / columns;
        h = w;
        
        /// 计算总行数，小数向上取整
        CGFloat rowsF = (item.content.image.count * 1.0) / columns;
//        NSLog(@"%f", rowsF);
        NSInteger rows = ceil(rowsF);
        
//        NSLog(@"%ld", rows);
        
        /// 根据图片的数量创建对应的imageView
        for (NSInteger i = 0; i < 9; ++i) {
            UIImageView *imageView = (UIImageView *)[_picContentView viewWithTag:i+1];
            
            if (i < item.content.image.count) { // 根据真实服务器返回图片的数量决定
                imageView.hidden = NO;
#warning TODO: 此处在加载图片时，App会出现间隙性闪退
                [imageView sd_setImageWithURL:[NSURL URLWithString:item.content.image[i]] placeholderImage:nil options:SDWebImageLowPriority];
                
                /// 每个图片所在的列数和行数
                NSInteger column = i % columns;
                NSInteger row = i / columns;
                x = (padding + w) * column;
                y = (padding + h) * row;
                
                imageView.frame = CGRectMake(x, y, w, h);
                
            } else {
                imageView.hidden = YES;
            }
        }
        _picContentView.hidden = NO;
        picH = rows*w + (rows-1)*padding;
        
    } else {
        _picContentView.hidden = YES;
        picH = 0;
    }
    return picH;
}

/// 计算评论的高度
- (CGFloat)calculateCommentContentH:(DynamicItem *)item {
    CGFloat commentContentH = 0;
    if (item.content.comments.count == 0) {
//        _commentContentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        commentContentH = 0;
        _commentContentView.hidden = YES;
    } else {
        commentContentH = 100;
        _commentContentView.hidden = NO;
    }
    return commentContentH;
}

- (UIImageView *)picViewAtIndex:(NSUInteger)index {
    
    return [_picContentView viewWithTag:index];
}


#pragma mark - Events 
- (void)picClick:(UITapGestureRecognizer *)tap {
    
    [[[XYImageViewer shareInstance] prepareImageURLList:_item.content.image
                                                   endView:^UIView *(NSIndexPath *indexPath) {
                                                       return [self picViewAtIndex:indexPath.row+1];
                                                   }] show:tap.view currentImgIndex:tap.view.tag-1];
    
}

@end
