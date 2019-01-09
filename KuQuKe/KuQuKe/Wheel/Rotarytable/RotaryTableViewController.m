//
//  RotaryTableViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/8.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "RotaryTableViewController.h"
#import "UILabel+LineSpacing.h"

@interface RotaryTableViewController () <CAAnimationDelegate>

/** 转盘图片 */
@property (nonatomic,strong) UIImageView *bgImageView;
/** 角度 */
@property (nonatomic,assign) CGFloat     circleAngle;
/** 动画中 */
@property (nonatomic,assign) BOOL        isAnimation;
/** 按钮 */
@property(nonatomic,strong) UIImageView  *btnimage;
/** 数据 */
@property(nonatomic,strong) NSArray      *prizeArray;
/** 剩余次数 */
@property(nonatomic,copy) NSString       *chanceNum;

/** 概率下一次抽中几 */
@property(nonatomic,strong) NSArray      *winNumArr;
@property(nonatomic,assign) NSInteger    nowNum;//第几次了

@end

@implementation RotaryTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = DQMMainColor;
	self.chanceNum = @"0";
	
	[self initView];
	
	//模拟请求
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		self.chanceNum = @"1";
	});
	
	
}

#pragma mark 初始化View
-(void)initView{
	
  //转盘背景
  _bgImageView = [[UIImageView alloc] init];
  _bgImageView.center = self.view.center;
  _bgImageView.image = [UIImage imageNamed:@"zhuanpan"];
  [self.view addSubview:_bgImageView];
  [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.centerY.mas_equalTo(self.view.mas_centerY);
    make.width.mas_equalTo(kScreenWidth-50);
    make.height.mas_equalTo(_bgImageView.mas_width);
  }];
  
  //添加GO按钮图片
  UIImageView *btnimage = [[UIImageView alloc] init];
  self.btnimage = btnimage;
  btnimage.center = _bgImageView.center;
  btnimage.image = [UIImage imageNamed:@"zhizhen"];
  [self.view addSubview:btnimage];
  _bgImageView.userInteractionEnabled = YES;
  btnimage.userInteractionEnabled = YES;
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick)];
  [btnimage addGestureRecognizer:tap];
  [btnimage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.centerY.mas_equalTo(self.view.mas_centerY);
    make.height.width.mas_equalTo(_bgImageView.mas_width).multipliedBy(0.41);
  }];
	
	UILabel *rotaryLabel = ({
		UILabel *label = [[UILabel alloc] init];
		[self.view addSubview:label];
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(_bgImageView.mas_centerX);
			make.centerY.mas_equalTo(self.view.mas_centerY).offset(-11);
		}];
		label;
	});
	QMLabelFontColorText(rotaryLabel, @"抽奖", QMHexColor(@"#F04724"), 22);

	
	UILabel *chanceNumLabel = ({
		UILabel *label = [[UILabel alloc] init];
		[self.view addSubview:label];
		QMLabelFontColorText(label, @"0次机会", QMHexColor(@"#A8342A"), 12);
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(_bgImageView.mas_centerX);
			make.centerY.mas_equalTo(self.view.mas_centerY).offset(11);
		}];
		label;
	});
	
	//订阅次数
	[RACObserve(self, chanceNum) subscribeNext:^(NSString *x) {
		chanceNumLabel.text = [NSString stringWithFormat:@"%@次机会",x];
	}];
	
  
  //添加文字
  self.prizeArray = @[@"0.01元现金",@"很遗憾",@"20元旅游卡",@"很遗憾",@"0.01元现金",@"2元现金",@"20元旅游卡",@"1元现金"];
 
  
  self.winNumArr = @[@(1),@(2),@(3),@(4)];
  self.nowNum = 0;
	
	
	UIImageView *IlikeRotaryImageView = ({
		UIImageView *imageView = [[UIImageView alloc] init];
		[self.view addSubview: imageView];
		[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view.mas_centerX);
			make.top.mas_equalTo(self.dqm_navgationBar.mas_bottom).offset(20);
			make.width.mas_equalTo(kScreenWidth*0.9);
			make.height.mas_equalTo(imageView.mas_width).multipliedBy(0.185);
		}];
		imageView;
	});
	QMSetImage(IlikeRotaryImageView, @"我要抽现金");

	
	UIImageView *rulesImageView = ({
		UIImageView *imageView = [[UIImageView alloc] init];
		[self.view addSubview: imageView];
		QMSetImage(imageView, @"活动规则背景");
		[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view.mas_centerX);
			make.top.mas_equalTo(_bgImageView.mas_bottom).offset(20);
			make.height.mas_equalTo(30);
			make.width.mas_equalTo(212);
		}];
		imageView;
	});
	UILabel *ruleLabel = ({
		UILabel *label = [[UILabel alloc] init];
		[rulesImageView addSubview:label];
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view.mas_centerX);
			make.centerY.mas_equalTo(rulesImageView.mas_centerY);
		}];
		label;
	});
	QMLabelFontColorText(ruleLabel, @"活动规则", UIColor.whiteColor, 16);
	
	UIView *rulesBackView = ({
		UIView *view = [[UIView alloc] init];
		[self.view addSubview: view];
		view.backgroundColor = QMHexColor(@"93fed6");
		QMViewBorderRadius(view, 2, 0, DQMMainColor);
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(self.view.mas_centerX);
			make.left.mas_equalTo(12);
			make.right.mas_equalTo(-12);
			make.top.mas_equalTo(_bgImageView.mas_bottom).offset(35);
		}];
		view;
	});
	[self.view sendSubviewToBack:rulesBackView];
	
	UILabel *ruleSlabel = ({
		UILabel *label = [[UILabel alloc] init];
		[rulesBackView addSubview:label];
		label.numberOfLines = 0;
		QMLabelFontColorText(label, @"1.每人最多有3次机会参与抽奖，每个用户每天首次免费参与，每完成5个任务，可额外获得一次机会。\n2.兑换方式:\n中奖金额以现金方式发放到账户余额，可提现。", QMTextColor, 12);
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(UIEdgeInsetsMake(30, 10, 20, 10));
		}];
		label;
	});
	[ruleSlabel setText:ruleSlabel.text lineSpacing:8];
	
	
}


#pragma mark 点击Go按钮
-(void)btnClick{
  
  NSLog(@"点击Go");
  
  //判断是否正在转
  if (_isAnimation || [_chanceNum intValue] == 0) {
    return;
  }
  _isAnimation = YES;
  
  //控制概率[0,80)
  NSInteger lotteryPro = arc4random()%80;
  //设置转圈的圈数
  NSInteger circleNum = 6;
  
//  if (lotteryPro < 10) {
//    _circleAngle = 22.5;
//  }else if (lotteryPro < 20){
//    _circleAngle = 67.5;
//  }else if (lotteryPro < 30){
//    _circleAngle = 112.5;
//  }else if (lotteryPro < 40){
//    _circleAngle = 157.5;
//  }else if (lotteryPro < 50){
//    _circleAngle = 202.5;
//  }else if (lotteryPro < 60){
//    _circleAngle = 247.5;
//  }else if (lotteryPro < 70){
//    _circleAngle = 292.5;
//  }else if (lotteryPro < 80){
//    _circleAngle = 337.5;
//  }
  
  
  if (_nowNum >= self.winNumArr.count) {
    _circleAngle = 67.5;//其他的都是不中的
  } else if ([self.winNumArr[_nowNum] intValue] == 1) {
    _circleAngle = 22.5;
  } else if ([self.winNumArr[_nowNum] intValue] == 2) {
    _circleAngle = 67.5;
  } else if ([self.winNumArr[_nowNum] intValue] == 3) {
    _circleAngle = 112.5;
  } else if ([self.winNumArr[_nowNum] intValue] == 4) {
    _circleAngle = 157.5;
  } else if ([self.winNumArr[_nowNum] intValue] == 5) {
    _circleAngle = 202.5;
  } else if ([self.winNumArr[_nowNum] intValue] == 6) {
    _circleAngle = 247.5;
  } else if ([self.winNumArr[_nowNum] intValue] == 7) {
    _circleAngle = 292.5;
  } else if ([self.winNumArr[_nowNum] intValue] == 8) {
    _circleAngle = 337.5;
  }

  self.nowNum = self.nowNum +1;
  
  
  CGFloat perAngle = M_PI/180.0;
  
  
  NSLog(@"turnAngle = %.1ld",(long)_circleAngle);
  
  CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
  rotationAnimation.toValue = [NSNumber numberWithFloat:_circleAngle * perAngle + 360 * perAngle * circleNum];
  rotationAnimation.duration = 3.0f;
  rotationAnimation.cumulative = YES;
  rotationAnimation.delegate = self;
  
  
  //由快变慢
  rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  rotationAnimation.fillMode=kCAFillModeForwards;
  rotationAnimation.removedOnCompletion = NO;
  [_btnimage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
  
}




#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
  
  NSLog(@"动画停止");
  
  
  self.prizeArray = @[@"0.01元现金",@"很遗憾",@"20元旅游卡",@"很遗憾",@"0.01元现金",@"2元现金",@"20元旅游卡",@"1元现金"];

  
  NSString *title;
  
  if (_circleAngle == 22.5) {
    title = _prizeArray[0];
  }else if (_circleAngle == 67.5){
    title = _prizeArray[1];
  }else if (_circleAngle == 112.5){
    title = _prizeArray[2];
  }else if (_circleAngle == 157.5){
    title = _prizeArray[3];
  }else if (_circleAngle == 202.5){
    title = _prizeArray[4];
  }else if (_circleAngle == 247.5){
    title = _prizeArray[5];
  }else if (_circleAngle == 292.5){
    title = _prizeArray[6];
  }else if (_circleAngle == 337.5){
    title = _prizeArray[7];
  }
  UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
  [alert show];
  
  _isAnimation = false;
  
}

#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
	return true;
}

/** 导航条左边的按钮 */
- (UIImage *)dqmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar {
	[leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
	return [UIImage imageNamed:@"NavgationBar_white_back"];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	[self.navigationController popViewControllerAnimated:true];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
	return [UIColor clearColor];
}


@end
