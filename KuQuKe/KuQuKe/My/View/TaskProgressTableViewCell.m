//
//  TaskProgressTableViewCell.m
//  KuQuKe
//
//  Created by Xcoder on 2019/4/15.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "TaskProgressTableViewCell.h"

@interface TaskProgressTableViewCell ()
    /** 图标 */
    @property(nonatomic,strong) UIImageView      *iconImageView;
    /** 标题 */
    @property(nonatomic,strong) UILabel          *titleLabel;
    /** 子标题 */
    @property(nonatomic,strong) UILabel          *subTitleLabel;
    /** 价格 */
    @property(nonatomic,strong) UILabel          *priceLabel;
    
    /** 时间 */
    @property(nonatomic,strong) UILabel          *leftLabel;
    /** msg */
    @property(nonatomic,strong) UILabel          *msgLabel;
    
    
    @end

@implementation TaskProgressTableViewCell
    
+(TaskProgressTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight
    {
        static NSString *identifier = @"TaskProgressTableViewCell";
        TaskProgressTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[TaskProgressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
            
            /** 图标 */
            self.iconImageView = ({
                UIImageView *imageView = [[UIImageView alloc] init];
                [self.backView addSubview: imageView];
                QMSetImage(imageView, @"logo");
                QMViewBorderRadius(imageView, 4, 0, DQMMainColor);
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(15);
                    make.top.mas_equalTo(13);
					make.height.mas_equalTo(44);
                    make.width.mas_equalTo(imageView.mas_height);
                }];
                imageView;
            });
            
            /** 标题 */
            self.titleLabel = ({
                UILabel *label = [[UILabel alloc] init];
                [self.backView addSubview:label];
                QMLabelFontColorText(label, @"京东白条-获额版", QMTextColor, 16);
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(_iconImageView.mas_right).offset(8);
                    make.top.mas_equalTo(_iconImageView.mas_top);
                    make.right.mas_equalTo(self.mas_right).offset(-60);
                }];
                label;
            });
            
            /** 子标题 */
            self.subTitleLabel = ({
                UILabel *label = [[UILabel alloc] init];
                [self.backView addSubview:label];
                QMLabelFontColorText(label, @"线上完成 高通过率", QMSubTextColor, 14);
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(_iconImageView.mas_right).offset(8);
                    make.bottom.mas_equalTo(_iconImageView.mas_bottom);
                    make.right.mas_equalTo(self.mas_right).offset(-60);
                }];
                label;
            });
			
			/** 价格 */
			self.priceLabel = ({
				UILabel *label = [[UILabel alloc] init];
				[self.contentView addSubview:label];
				QMLabelFontColorText(label, @"+1.5元", QMTextColor, 15);
				[label mas_makeConstraints:^(MASConstraintMaker *make) {
					make.right.mas_equalTo(-13);
					make.centerY.mas_equalTo(_iconImageView.mas_centerY);
				}];
				label;
			});
            
            UIView *line = ({
                UIView *view = [[UIView alloc] init];
                [self.backView addSubview: view];
                view.backgroundColor = QMBackColor;
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.mas_equalTo(0);
                    make.height.mas_equalTo(1);
                    make.top.mas_equalTo(68);
                }];
                view;
            });
            
            
            /** 时间 */
            self.leftLabel = ({
                UILabel *label = [[UILabel alloc] init];
                [self.backView addSubview:label];
                QMLabelFontColorText(label, @"2019年04月08日21:35:56", QMSubTextColor, 14);
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(15);
                    make.top.mas_equalTo(line.mas_bottom).offset(10);
                    make.height.mas_equalTo(15);
                    make.bottom.mas_equalTo(self.backView).offset(-10);
                }];
                label;
            });
            
            /** msg */
            self.msgLabel = ({
                UILabel *label = [[UILabel alloc] init];
                [self.backView addSubview:label];
                QMLabelFontColorText(label, @"2019年04月08日21:35:56", QMSubTextColor, 14);
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-13);
                    make.top.mas_equalTo(line.mas_bottom).offset(10);
                    make.height.mas_equalTo(15);
                }];
                label;
            });
			
            [[RACObserve(self, model) skip:1] subscribeNext:^(TaskProgressModel *x) {
                
				/** 图标 */
				[self.iconImageView qm_setImageUrlString:x.appicon_url];
				
				/** 标题 */
				self.titleLabel.text = x.title;
				
				/** 子标题 */
				self.subTitleLabel.text = [x.status intValue] == 1 ? @"任务进行中" : @"任务失败";
				
				/** 价格 */
				self.priceLabel.text = x.price;
				
				/** 时间 */
				self.leftLabel.text = x.finish_time;
				
				/** msg */
				self.msgLabel.text = x.audit_msg;
                
            }];
        }
        return self;
    }
    
    
- (void)setFixedCellHeight:(CGFloat)fixedCellHeight {
    _fixedCellHeight = fixedCellHeight;
    if (fixedCellHeight != 0) {
        [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(fixedCellHeight);
        }];
    }
}

@end
