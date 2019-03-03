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
@property (nonatomic,strong) UIImageView    *bgImageView;
/** 角度 */
@property (nonatomic,assign) CGFloat        circleAngle;
/** 动画中 */
@property (nonatomic,assign) BOOL           isAnimation;
/** 按钮 */
@property (nonatomic,strong) UIImageView    *btnimage;
/** 数据 */
@property (nonatomic,strong) NSMutableArray *prizeArray;
/** 剩余次数 */
@property (nonatomic,copy  ) NSString       *chanceNum;
/** 抽奖到的字典 */
@property (nonatomic,copy  ) NSDictionary   *winDataDic;


@end

@implementation RotaryTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = DQMMainColor;
	self.chanceNum = @"0";
	
	[self initView];
	
  [KuQuKeNetWorkManager GET_turntableListParams:[NSMutableDictionary new] View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
    self.chanceNum = dataDic[@"data"][@"prize_num"];//可用次数

    NSString *imageString = dataDic[@"data"][@"prize_info"][@"bgimg_url"];
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:imageString]
                    placeholderImage:[UIImage imageNamed:@"zhuanpan"]
                           completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                             if (image && cacheType == SDImageCacheTypeNone) {
                               CATransition *transition = [CATransition animation];
                               transition.type = kCATransitionFade;
                               transition.duration = 0.5;
                               transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                               [_bgImageView.layer addAnimation:transition forKey:nil];
                             }
                           }];
    //添加文字
    self.prizeArray = [[NSMutableArray alloc] initWithArray:dataDic[@"data"][@"prize_arr"]];
   
  } unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
  } failure:^(NSError *error) {
    
  }];
  
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
			make.top.mas_equalTo(_bgImageView.mas_bottom).offset(10);
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
			make.top.mas_equalTo(_bgImageView.mas_bottom).offset(25);
		}];
		view;
	});
	[self.view sendSubviewToBack:rulesBackView];
	
	UILabel *ruleSlabel = ({
		UILabel *label = [[UILabel alloc] init];
		[rulesBackView addSubview:label];
		label.numberOfLines = 0;
		QMLabelFontColorText(label, @"1.每人最多有3次机会参与抽奖，每个用户每天首次免费参与，每完成5个任务，可额外获得一次机会。\n\n2.兑换方式:\n中奖金额以现金方式发放到账户余额，可提现。", QMTextColor, 12);
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(UIEdgeInsetsMake(30, 10, 20, 10));
		}];
		label;
	});
	[ruleSlabel setText:ruleSlabel.text lineSpacing:8];
	
	
}


#pragma mark 点击Go按钮
- (void)btnClick {
  
  NSLog(@"点击Go");
  
  //判断是否正在转
  if (_isAnimation || [_chanceNum intValue] == 0) {
    return;
  }
  if (self.prizeArray.count != 8) {
    [self.view makeToast:@"奖品数量不足"];
    return;
  }
  
  _isAnimation = YES;
  
  //控制概率[0,80)
//  NSInteger lotteryPro = arc4random()%80;
  
  //请求抽奖的名次
  [self turntableData];
  
}

/**
 抽奖后获得抽奖的名次
 */
- (void)turntableData {
  
  [KuQuKeNetWorkManager POST_turntable:[NSMutableDictionary new] View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
    self.winDataDic = dataDic;
    
    //设置转圈的圈数
    NSInteger circleNum = 6;
    self.chanceNum = [NSString stringWithFormat:@"%d",[self.chanceNum intValue] - 1];
    
    
    __block int index = 99999;
    [self.prizeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      if ([dataDic[@"data"][@"id"] intValue] == [obj[@"id"] intValue]) {
        index = (int)idx;
      }
    }];
    
    _circleAngle = 22.5 + index * 45;
    
    CGFloat perAngle = M_PI/180.0;
    
    //回主线程刷新数据
    dispatch_async(dispatch_get_main_queue(), ^{
      
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
    });
    
  } unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
  } failure:^(NSError *error) {
    
  }];
}





#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
  NSLog(@"动画停止");
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:_winDataDic[@"data"][@"name"] message:@"" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

  }];
  [alert addAction:sureAction];
  [self presentViewController:alert animated:YES completion:nil];
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
