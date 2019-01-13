//
//  DQMLabelSizeToFitTableViewCell.m
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2019/1/2.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "DQMLabelSizeToFitTableViewCell.h"


@interface DQMLabelSizeToFitTableViewCell ()

/** 自适应高度的文本框 */
@property(nonatomic,strong) UILabel          *contentLabel;

@end

@implementation DQMLabelSizeToFitTableViewCell

+(DQMLabelSizeToFitTableViewCell *)cellWithTableView:(UITableView *)tableView
{
  static NSString *identifier = @"DQMLabelSizeToFitTableViewCell";
  DQMLabelSizeToFitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil)
  {
    cell = [[DQMLabelSizeToFitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  cell.backgroundColor = QMHexColor(@"f9f9f9");
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self)
  {
	  
	  /** 自适应高度的文本框 */
	  UIView *backColorView = ({
		  UIView *view = [[UIView alloc] init];
		  [self.contentView addSubview:view];
		  view.backgroundColor = QMBackColor;
		  view.hidden = true;
		  QMViewBorderRadius(view, 4, 0, DQMMainColor);
		  [view mas_makeConstraints:^(MASConstraintMaker *make) {
			  make.edges.mas_equalTo(UIEdgeInsetsMake(0, 20, 0, 20));
		  }];
		  view;
	  });
	  
	  [RACObserve(self, showBackColorView) subscribeNext:^(id  _Nullable x) {
		  backColorView.hidden = ![x boolValue];
	  }];
	  
    /** 自适应高度的文本框 */
    self.contentLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self.contentView addSubview:label];
      label.numberOfLines = 0;
      QMLabelFontColorText(label, @"这是会自动适应行高的cell的内容测试，是一串富文本内容;这是会自动适应行高的cell的内容测试，是一串富文本内容;这是会自动适应行高的cell的内容测试，是一串富文本内容", QMHexColor(@"333333"), 13);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(10);
        make.width.mas_equalTo(kScreenWidth-20);
      }];
      label;
    });
	  
  }
  return self;
}


#pragma mark - datasource
- (void)setContentText:(NSMutableAttributedString *)contentText
{
  _contentText = contentText;
  _contentLabel.attributedText = contentText;
}


/** 更改内边距 */
-(void)setLabelEdgeInsetTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right  {
	[_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(top, left, bottom, right));
		make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-bottom);
		make.width.mas_equalTo(kScreenWidth-left-right);
	}];
	
}




@end
