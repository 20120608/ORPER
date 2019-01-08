//
//  RotaryTableViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/8.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "RotaryTableViewController.h"

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
/** 概率下一次抽中几 */
@property(nonatomic,strong) NSArray      *winNumArr;
@property(nonatomic,assign) NSInteger    nowNum;//第几次了

@end

@implementation RotaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = DQMMainColor;
  
  [self initView];
  
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
  
  
  //添加文字
  self.prizeArray = @[@"0.01元现金",@"很遗憾",@"20元旅游卡",@"很遗憾",@"0.01元现金",@"2元现金",@"20元旅游卡",@"1元现金"];
 
  
  self.winNumArr = @[@(1),@(2),@(3),@(4)];
  self.nowNum = 0;
}


#pragma mark 点击Go按钮
-(void)btnClick{
  
  NSLog(@"点击Go");
  
  //判断是否正在转
  if (_isAnimation) {
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
  
  
  NSLog(@"turnAngle = %ld",(long)_circleAngle);
  
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



@end
