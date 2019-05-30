//
//  TaskingAlertView.m
//  KuQuKe
//
//  Created by Xcoder on 2019/4/22.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "TaskingAlertView.h"
#include <objc/runtime.h>
#import "DQMAlertView.h"
#import "EarnMoneyDetailModel.h"
#import "APPViewController.h"
#import "AppDelegate.h"


@interface TaskingAlertView ()

/** 白色背景 */
@property(nonatomic,strong) UIView          *whiteBackView;
/** 控件容器 */
@property(nonatomic,strong) UIView          *backView;
/** 按钮 */
@property(nonatomic,strong) UIButton        *receiveButton;

@end

@implementation TaskingAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.4];
		
		self.backView = ({
			UIView *view = [[UIView alloc] init];
			[self addSubview: view];
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
			}];
			view;
		});
		
		UIView *whiteBackView = ({
			UIView *view = [[UIView alloc] init];
			[_backView addSubview: view];
			view.backgroundColor = UIColor.whiteColor;
			QMViewBorderRadius(view, 4, 0, DQMMainColor);
			[view mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(self.mas_centerX);
				make.centerY.mas_equalTo(self.mas_centerY).offset(-40);
				make.width.mas_equalTo(SCREEN_WIDTH-100);
				make.height.mas_greaterThanOrEqualTo(187);
			}];
			view;
		});
		self.whiteBackView = whiteBackView;
		
		UIButton *closeButton = ({
			UIButton *button = [[UIButton alloc] init];
			[whiteBackView addSubview:button];
			button.tag = 0;
			QMSetButton(button, nil, 12, @"close_RIGHT_TOP", QMRandomColor, UIControlStateNormal);
			[button setAdjustsImageWhenHighlighted:false];
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(whiteBackView.mas_right);
				make.top.mas_equalTo(whiteBackView.mas_top);
				make.size.mas_equalTo(CGSizeMake(40, 40));
			}];
			button;
		});
		[[closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
			[self removeFromSuperview];
		}];
		
		UIImageView *iconImageView = ({
			UIImageView *imageView = [[UIImageView alloc] init];
			[whiteBackView addSubview: imageView];
			QMSetImage(imageView, @"icon_gametaskDetail_first");
			QMViewBorderRadius(imageView, 4, 0, DQMMainColor);
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(15);
				make.top.mas_equalTo(40);
				make.size.mas_equalTo(CGSizeMake(40, 40));
			}];
			imageView;
		});
		
		UILabel *titleLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[whiteBackView addSubview:label];
			QMLabelFontColorText(label, @"0.6元(含0.2元专属)", QMTextColor, 16);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(iconImageView.mas_right).offset(12);
				make.top.mas_equalTo(iconImageView.mas_top);
				make.right.mas_equalTo(-50);
			}];
			label;
		});
		
		UILabel *sizeFontLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[whiteBackView addSubview:label];
			QMLabelFontColorText(label, @"安装包大小79M", QMSubTextColor, 14);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(iconImageView.mas_right).offset(12);
				make.bottom.mas_equalTo(iconImageView.mas_bottom);
				make.right.mas_equalTo(-50);
			}];
			label;
		});
		
		UILabel *stepsLabel = ({
			UILabel *label = [[UILabel alloc] init];
			[whiteBackView addSubview:label];
			label.numberOfLines = 0;
			QMLabelFontColorText(label, @"安静的洛杉矶撒开了交罚款\n复活卡顺丰客服哈话费卡是否回家奥斯卡和康师傅", QMTextColor, 12);
			[label mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.mas_equalTo(iconImageView.mas_right);
				make.top.mas_equalTo(iconImageView.mas_bottom).offset(15);
				make.right.mas_equalTo(whiteBackView.mas_right).offset(-50);
			}];
			label;
		});
		
		UIButton *beginButton = ({
			UIButton *button = [[UIButton alloc] init];
			[whiteBackView addSubview:button];
			QMSetButton(button, @"开始任务", 18, nil, UIColor.whiteColor, UIControlStateNormal);
			button.backgroundColor = QMYellowColor;
			QMViewBorderRadius(button, 4, 0, DQMMainColor);
			[button addTarget:self action:@selector(beginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(whiteBackView.mas_centerX);
				make.top.mas_equalTo(stepsLabel.mas_bottom).offset(10);
				make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-200, 44));
			}];
			button;
		});
		
		self.receiveButton = ({
			UIButton *button = [[UIButton alloc] init];
			[whiteBackView addSubview:button];
			QMSetButton(button, @"领取奖励", 18, nil, UIColor.whiteColor, UIControlStateNormal);
			[button setBackgroundColor:QMBackColor forState:UIControlStateDisabled];
			[button setBackgroundColor:QMYellowColor forState:UIControlStateNormal];
			QMViewBorderRadius(button, 4, 0, DQMMainColor);
			button.enabled = false;
			[button addTarget:self action:@selector(receiveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
			
			[button mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerX.mas_equalTo(whiteBackView.mas_centerX);
				make.top.mas_equalTo(beginButton.mas_bottom).offset(10);
				make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-200, 44));
				make.bottom.mas_equalTo(whiteBackView.mas_bottom).offset(-40);
			}];
			button;
		});
		
		
		[RACObserve(self, earnMoneyModel) subscribeNext:^(EarnMoneyDetailModel *x) {
			
			titleLabel.text = x.title;
			sizeFontLabel.text = [NSString stringWithFormat:@"安装包大小:%@",x.apk_size];
			
			NSString *stepStr = [x.step_info componentsJoinedByString:@";\n"];
			stepsLabel.text = stepStr;
		}];
		
	}
	return self;
}


#pragma mark - 任务
- (void)beginButtonClick:(UIButton *)sender {
	
	[self.currentVC.tableView.mj_header beginRefreshing];

	if (_earnMoneyModel.bundleID == nil) {
		
		NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
		NSTimeInterval a=[dat timeIntervalSince1970];
		NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
		NSLog(@" 没有bundleID  进入后台的时间戳:%@",timeString);
		//将两个时间戳发送到后台并保存，提供给领取奖励的时候调用
		NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
		[params setValue:_earnMoneyModel.id forKey:@"tid"];
		[params setValue:timeString forKey:@"add_time"];
		
		[KuQuKeNetWorkManager POST_getJoinTime:params View:self success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
			//保存成功,可以点击领取了
			NSLog(@"任务已经保存到后台了");
			self.receiveButton.enabled = true;
			
		} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
			
		} failure:^(NSError *error) {
			
		}];
		
		MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
		hud.label.text = @"请前往App Store下载";
		hud.minShowTime = 4;
		[hud removeFromSuperViewOnHide];
		[self.window addSubview:hud];
		[hud showAnimated:true];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[hud hideAnimated:true];
		});
		
		return;
	}
	
	NSLog(@"开始任务");
	MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	hud.label.text = @"正在搜索APP";
	hud.minShowTime = 4;
	[hud removeFromSuperViewOnHide];
	[self.window addSubview:hud];
	[hud showAnimated:true];
	
	[self testGoOtherAPP:hud bundleID:_earnMoneyModel.bundleID];
	
	
	//传入定时器 指定时间内没取消会弹窗
	_earnMoneyModel.beginDate = [NSDate dateWithTimeIntervalSinceNow:180];
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[app startearnMoneyModelTimer:_earnMoneyModel];
	
}

//尝试跳转
- (void)testGoOtherAPP:(MBProgressHUD *)hud bundleID:(NSString *)bundleID {
	
	NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
	NSTimeInterval a=[dat timeIntervalSince1970];
	NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
	NSLog(@"进入后台的时间戳:%@",timeString);
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		UIApplicationState state = [UIApplication sharedApplication].applicationState;
		BOOL result = (state == UIApplicationStateBackground);
		if(result) {
			NSLog(@"成功跳转，酷去客已经在后台");
			[hud hideAnimated:true];
			
			//将两个时间戳发送到后台并保存，提供给领取奖励的时候调用
			NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
			[params setValue:_earnMoneyModel.id forKey:@"tid"];
			[params setValue:timeString forKey:@"add_time"];
			
			[KuQuKeNetWorkManager POST_getJoinTime:params View:self success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				//保存成功,可以点击领取了
				NSLog(@"任务已经保存到后台了");
				self.receiveButton.enabled = true;
				
			} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				
			} failure:^(NSError *error) {
				
			}];
			
			
		} else {
			NSLog(@"活跃状态,证明没有跳转");
			if (hud != nil) {
				hud.label.text = @"找不到相应的APP!\n请移步APPStor下载";
				dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
					[hud hideAnimated:true];
				});
			}
		}
	});
	
	[self runtimeJump:bundleID];
	
}

//尝试跳转
- (void)runtimeJump:(NSString *)bundleID {
	Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
	NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
	[workspace performSelector:@selector(openApplicationWithBundleID:) withObject:bundleID];
}



- (void)receiveButtonClick:(UIButton *)sender {
	if (_earnMoneyModel.applyid != nil) {
		NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
		[params setValue:_earnMoneyModel.id forKey:@"id"];
		[params setValue:_earnMoneyModel.applyid forKey:@"applyid"];
		[params setValue:@"2" forKey:@"nowstatus"];
		
		[KuQuKeNetWorkManager POST_addExclusiveTaskOk:params View:self success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
			
			[self makeToast:@"领取奖励申请已提交!"];
			
			//完成任务 移除定时器的模型
			AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
			[app removeTimeTask:_earnMoneyModel.id];
			
		} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
			
		} failure:^(NSError *error) {
			
		}];
	} else {
		[self makeToast:@"请先参加任务!"];
	}
	
}


- (void)showAnimation {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	animation.fromValue = [NSNumber numberWithFloat:0.01f];
	animation.toValue = [NSNumber numberWithFloat:1.0f];
	animation.duration = 0.35f;
	animation.fillMode = kCAFillModeForwards;
	animation.removedOnCompletion = NO;
	[self.backView.layer addAnimation:animation forKey:@"scaleAnimation"];
	CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
	animation2.fromValue = [NSNumber numberWithFloat:0.01f];
	animation2.toValue = [NSNumber numberWithFloat:1.0f];
	animation2.duration = 0.35f;
	animation2.fillMode = kCAFillModeForwards;
	animation2.removedOnCompletion = NO;
	[self.backView.layer addAnimation:animation2 forKey:@"opacityAnimation"];
}


@end
