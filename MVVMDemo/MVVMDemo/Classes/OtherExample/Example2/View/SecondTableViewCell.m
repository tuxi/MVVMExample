//
//  SecondTableViewCell.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/10.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "UITableViewCell+XYConfigure.h"
#import "SecondModel.h"

@interface SecondTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;


@end
@implementation SecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)xy_config:(UITableViewCell *)cell model:(id)model indexPath:(NSIndexPath *)indexPath {
    
    SecondModel *m = (SecondModel *)model;
    self.titleLabel.text = m.title;
    self.summaryLabel.text = m.summary;
    self.publisherLabel.text = m.publisher;
    self.iconView.image = indexPath.row % 2 == 0 ? [UIImage imageNamed:@"1"] : [UIImage imageNamed:@"2"];
}

@end
