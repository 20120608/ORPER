//
//  RACMVVMListTableViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/25.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "RACMVVMListTableViewCell.h"

@interface  RACMVVMListTableViewCell ()

/** 下标 */
@property (nonatomic,copy  ) NSIndexPath *indexPath;
/** 用来撑开高度的View */
@property(nonatomic,strong) UIView          *backView;

@end

@implementation RACMVVMListTableViewCell

+(RACMVVMListTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight
{
  static NSString *identifier = @"RACMVVMListTableViewCell";
  RACMVVMListTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil)
  {
    cell = [[RACMVVMListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  cell.fixedCellHeight = fixedCellHeight;
  cell.indexPath = indexPath;
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self)
  {
    self.backView = ({
      UIView *view = [[UIView alloc] init];
      [self.contentView addSubview: view];
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
      }];
      view;
    });
    
    UIImageView *coverImgView =  ({
      UIImageView *imageView = [[UIImageView alloc] init];
      QMSetImage(imageView, @"placeholderImage");
      [_backView addSubview: imageView];
      [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-12);
        make.size.mas_equalTo(CGSizeMake(120, 80));
      }];
      imageView;
    });
    
    UILabel *titleLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [_backView addSubview:label];
      QMLabelFontColorText(label, @"人生若只如初见,何事秋风悲画扇", QMTextColor, 16);
      label.font = [UIFont boldSystemFontOfSize:16];
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(coverImgView.mas_right).offset(10);
        make.top.mas_equalTo(_backView.mas_top);
        make.right.mas_equalTo(-12);
      }];
      label;
    });
    
    
    UILabel *upPersonLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [_backView addSubview:label];
      QMLabelFontColorText(label, @"UP主:小宝", QMSubTextColor, 14);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(coverImgView.mas_right).offset(10);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(-12);
      }];
      label;
    });
    
    UILabel *playCountLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [_backView addSubview:label];
      QMLabelFontColorText(label, @"播放量:12345亿", QMSubTextColor, 14);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(coverImgView.mas_right).offset(10);
        make.top.mas_equalTo(upPersonLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(-12);
      }];
      label;
    });
    
    UILabel *barrageCountLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [_backView addSubview:label];
      QMLabelFontColorText(label, @"弹幕:1234", QMSubTextColor, 14);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(playCountLabel.mas_right).offset(10);
        make.top.mas_equalTo(playCountLabel.mas_top).offset(5);
        make.right.mas_equalTo(-12);
      }];
      label;
    });
    
    
    //订阅数据
    [[RACObserve(self, cellModel) skip:1] subscribeNext:^(RACMVVMListModel *x) {
      titleLabel.text = x.name;
      [coverImgView qm_setImageUrlString:x.imgUrl];
      upPersonLabel.text = [NSString stringWithFormat:@"UP主：%@",x.author];
      playCountLabel.text = [NSString stringWithFormat:@"isbn：%@",x.isbn];
      barrageCountLabel.text = [NSString stringWithFormat:@"出版社：%@",x.publishHouse];
    }];
    
    
  }
  return self;
}


- (void)setFixedCellHeight:(CGFloat)fixedCellHeight {
  _fixedCellHeight = fixedCellHeight;
  if (fixedCellHeight != 0) {
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
      make.height.mas_equalTo(fixedCellHeight);
    }];
  }
}




@end
