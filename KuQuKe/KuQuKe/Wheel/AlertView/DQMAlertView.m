//
//  DQMAlertView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/3/7.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "DQMAlertView.h"

@interface DQMAlertView () <UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property(nonatomic,strong) UITableView          *tableView;

@end

@implementation DQMAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.6];
		
		UIView *backView = ({
			UIView *view = [[UIView alloc] init];
			[self addSubview: view];
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(self.mas_centerX);
				make.centerY.mas_equalTo(self.mas_centerY);
				make.width.mas_equalTo(kScreenWidth/3*2);
			}];
			view;
		});
		
		UIView *whiteView = ({
			UIView *whiteView = [[UIView alloc] init];
			[backView addSubview: whiteView];
			whiteView.userInteractionEnabled = true;
			QMViewBorderRadius(whiteView, 4, 0, QMBackColor);
			[whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(backView);
			}];
			whiteView;
		});
		
		UILabel *titleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[whiteView addSubview:label];
			label.font = [UIFont boldSystemFontOfSize:20];
			label.backgroundColor = UIColor.whiteColor;
			label.textAlignment = NSTextAlignmentCenter;
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.right.mas_equalTo(whiteView);
				make.top.mas_equalTo(whiteView.mas_top);
				make.height.mas_equalTo(60);
			}];
			label;
		});
		QMLabelFontColorText(titleLabel, @"是否放弃任务", QMTextColor, 20);
		
		self.tableView = ({
			UITableView *tableView       = [[UITableView alloc] init];
			[whiteView addSubview:tableView];
			tableView.delegate           = self;
			tableView.dataSource         = self;
			tableView.estimatedRowHeight = 40;
			tableView.rowHeight          = UITableViewAutomaticDimension;
			tableView.tableFooterView    = [[UIView alloc] init];
			[tableView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.right.mas_equalTo(whiteView);
				make.top.mas_equalTo(whiteView.mas_top).offset(60);
				make.bottom.mas_equalTo(whiteView.mas_bottom);
				make.height.mas_equalTo(132);
			}];
			tableView;
		});
		
		
		//show
		[[self rac_signalForSelector:@selector(show)] subscribeNext:^(id  _Nullable x) {
			CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
			animation.fromValue = [NSNumber numberWithFloat:0.01f];
			animation.toValue = [NSNumber numberWithFloat:1.0f];
			animation.duration = 0.2f;
			animation.fillMode = kCAFillModeForwards;
			animation.removedOnCompletion = NO;
			[whiteView.layer addAnimation:animation forKey:@"scaleAnimation"];
		}];
		
		//hide
		[[self rac_signalForSelector:@selector(hide)] subscribeNext:^(id  _Nullable x) {
			CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
			animation.fromValue = [NSNumber numberWithFloat:1.0f];
			animation.toValue = [NSNumber numberWithFloat:0.01f];
			animation.duration = 0.2f;
			animation.fillMode = kCAFillModeForwards;
			animation.removedOnCompletion = NO;
			[whiteView.layer addAnimation:animation forKey:@"scaleAnimation"];
			//移除
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				[self removeFromSuperview];
			});
		}];
		
		
		
	}
	return self;
}

#pragma mark : ==============  代理 ==============
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	DQMDefaultTableViewCell *cell = [DQMDefaultTableViewCell cellWithTableView:tableView];
	cell.textLabel.textAlignment = NSTextAlignmentCenter;
	cell.textLabel.text = @[@"返回列表",@"放弃任务",@"取消"][indexPath.row];
	if (indexPath.row == 0) {
		cell.textLabel.textColor = QMBlueColor;
	} else {
		cell.textLabel.textColor = QMTextColor;
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([self.delegate respondsToSelector:@selector(DQMAlertView:DidSelectIndexPath:)]) {
		[self.delegate DQMAlertView:self DidSelectIndexPath:indexPath];
	}
}


- (void)AlertViewbuttonClick:(UIButton *)sender {
	[self hide];
}

- (void)show {
	NSLog(@"调用的显示,看订阅");
}
- (void)hide {
	NSLog(@"调用的隐藏,看订阅");
}

@end

