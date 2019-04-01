//
//  EarnMoneyAlertView.m
//  KuQuKe
//
//  Created by hallelujah on 2019/3/13.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "EarnMoneyAlertView.h"

@interface EarnMoneyAlertView () <UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property(nonatomic,strong) UITableView          *tableView;

@end

@implementation EarnMoneyAlertView

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
		
		UIImageView *iconImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[self addSubview: imageView];
			QMSetImage(imageView, @"logo");
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(25);
				make.top.mas_equalTo(40);
				make.size.mas_equalTo(CGSizeMake(34, 34));
			}];
			imageView;
		});
		
		
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
	return 0;
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

- (void)BeginButtonClick:(UIButton *)sender {
	if ([self.delegate respondsToSelector:@selector(EarnMoneyAlertView:DidSelectBeginButton:)]) {
		[self.delegate EarnMoneyAlertView:self DidSelectBeginButton:sender];
	}
}

- (void)AlertViewbuttonCloseClick:(UIButton *)sender {
	[self hide];
}

- (void)show {
	NSLog(@"调用的显示,看订阅");
}
- (void)hide {
	NSLog(@"调用的隐藏,看订阅");
}


@end
