//
//  LoginCodeOrPassWordTableViewCell.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/24.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "LoginCodeOrPassWordTableViewCell.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"

@interface  LoginCodeOrPassWordTableViewCell () <JXCategoryViewDelegate, JXCategoryListContainerViewDelegate,LoginUseMsgcodeViewDelegate,LoginUsePassWordViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

/** 短信登入界面 */
@property(nonatomic,strong) LoginUseMsgcodeView *codeView;
/** 密码登入界面 */
@property(nonatomic,strong) LoginUsePassWordView *passwordView;

/** 下标 */
@property (nonatomic,assign) NSIndexPath *indexPath;
/** 用来撑开高度的View */
@property(nonatomic,strong) UIView       *backView;

@end

@implementation LoginCodeOrPassWordTableViewCell

+(LoginCodeOrPassWordTableViewCell *)cellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath FixedCellHeight:(CGFloat)fixedCellHeight
{
  static NSString *identifier = @"LoginCodeOrPassWordTableViewCell";
  LoginCodeOrPassWordTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil)
  {
    cell = [[LoginCodeOrPassWordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    CGFloat whiteViewHeight = 315;
    CGFloat margin = 24;
    UIView *whiteView = ({
      UIView *view = [[UIView alloc] init];
      [_backView addSubview: view];
      view.backgroundColor = UIColor.whiteColor;
      QMViewBorderRadius(view, 6, 0, UIColor.whiteColor);
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-33);
        make.height.mas_equalTo(whiteViewHeight);
        make.left.mas_equalTo(_backView.mas_left).offset(margin);
        make.right.mas_equalTo(_backView.mas_right).offset(-margin);
        make.bottom.mas_equalTo(_backView.mas_bottom).offset(-20);
      }];
      view;
    });
    
    UIView *shadowView = ({
      UIView *view = [[UIView alloc] init];
      [_backView addSubview: view];
      view.backgroundColor = UIColor.whiteColor;
      view.layer.shadowOffset =CGSizeMake(1,2);
      view.layer.shadowColor = QMHexColor(@"c6c6c6").CGColor;
      view.layer.shadowRadius = 2;
      view.layer.shadowOpacity = 1;
      view.layer.cornerRadius = 5;
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(whiteView);
      }];
      view;
    });
    [_backView sendSubviewToBack:shadowView];
    
    
    //滚动的菜单
    CGFloat categoryHeight = 45;
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.frame = CGRectMake(0, 39, kScreenWidth-2*margin, categoryHeight);
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.titleColor = QMTextColor;
    self.categoryView.titleSelectedColor = DQMMainColor;
    self.categoryView.titleFont = [UIFont systemFontOfSize:19];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    //线条颜色
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = DQMMainColor;
    lineView.lineStyle = JXCategoryIndicatorLineStyle_IQIYI;
    self.categoryView.indicators = @[lineView];
    [whiteView addSubview:self.categoryView];
    
    //视图容器
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:[UIViewController new] delegate:self];
    self.listContainerView.frame = CGRectMake(0, categoryHeight+39, kScreenWidth-2*margin, whiteViewHeight-39-categoryHeight);
    self.listContainerView.defaultSelectedIndex = 0;
    self.listContainerView.scrollView.scrollEnabled = false;
    [whiteView addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    
    
    //重载之后默认回到0，你也可以指定一个index
    if (self.titles == nil) {
      _titles = @[@"短信登录", @"密码登录"];
    }
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.titles = self.titles;
    [self.categoryView reloadData];

    self.listContainerView.defaultSelectedIndex = 0;
    [self.listContainerView reloadData];
    
    
  }
  return self;
}


#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
  [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
  [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
  if (index == 0) {
    //这里不判断会因为重复创建后 触发多次订阅
    if (!_codeView) {
      _codeView = [[LoginUseMsgcodeView alloc] init];
      _codeView.delegate = self;
      QMWeak(self);
      [[RACObserve(self, countDown) distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        weakself.codeView.countDown = [x intValue];
      }];
    }
    return _codeView;
  }
  self.passwordView = [[LoginUsePassWordView alloc] init];
  self.passwordView.delegate = self;
  return self.passwordView;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
  return self.titles.count;
}



#pragma mark - Login Delegate
- (void)LoginUseMsgcodeView:(LoginUseMsgcodeView *)loginUseMsgcodeView DidClickSendCodeButton:(UIButton *)button {
  //  NSLog(@"获取验证码");
  if ([self.delegate respondsToSelector:@selector(LoginCodeOrPassWordTableViewCell:LoginUseMsgcodeView:DidClickSendCodeButton:)]) {
    [self.delegate LoginCodeOrPassWordTableViewCell:self LoginUseMsgcodeView:loginUseMsgcodeView DidClickSendCodeButton:button];
  }
}

- (void)LoginUseMsgcodeView:(LoginUseMsgcodeView *)loginUseMsgcodeView DidClickLoginButton:(UIButton *)button {
  //  NSLog(@"短信登入");
  if ([self.delegate respondsToSelector:@selector(LoginCodeOrPassWordTableViewCell:LoginUseMsgcodeView:DidClickLoginButton:)]) {
    [self loginButtonBeginAnimation:button AndView:loginUseMsgcodeView];//动画
    [self.delegate LoginCodeOrPassWordTableViewCell:self LoginUseMsgcodeView:loginUseMsgcodeView DidClickLoginButton:button];
  }
}


- (void)LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickLoginButton:(UIButton *)button {
  //  NSLog(@"密码登录");
  if ([self.delegate respondsToSelector:@selector(LoginCodeOrPassWordTableViewCell:LoginUsePassWordView:DidClickLoginButton:)]) {
    [self loginButtonBeginAnimation:button AndView:loginUsePassWordView];//动画
    [self.delegate LoginCodeOrPassWordTableViewCell:self LoginUsePassWordView:loginUsePassWordView DidClickLoginButton:button];
  }
}

- (void)LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickRegisterButton:(UIButton *)button {
  //  NSLog(@"注册");
  if ([self.delegate respondsToSelector:@selector(LoginCodeOrPassWordTableViewCell:LoginUsePassWordView:DidClickRegisterButton:)]) {
    [self.delegate LoginCodeOrPassWordTableViewCell:self LoginUsePassWordView:loginUsePassWordView DidClickRegisterButton:button];
  }
}

- (void)LoginUsePassWordView:(LoginUsePassWordView *)loginUsePassWordView DidClickSearchButton:(UIButton *)button {
  //  NSLog(@"找回");
  if ([self.delegate respondsToSelector:@selector(LoginCodeOrPassWordTableViewCell:LoginUsePassWordView:DidClickSearchButton:)]) {
    [self.delegate LoginCodeOrPassWordTableViewCell:self LoginUsePassWordView:loginUsePassWordView DidClickSearchButton:button];
  }
}






//高度
- (void)setFixedCellHeight:(CGFloat)fixedCellHeight {
  _fixedCellHeight = fixedCellHeight;
  if (fixedCellHeight != 0) {
    [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
      make.height.mas_equalTo(fixedCellHeight);
    }];
  }
}



#pragma mark - loginButton Animation
-(void)loginButtonBeginAnimation:(UIButton *)sender AndView:(UIView *)showView {
  
  //开始登录事件
  //执行登录按钮转圈动画的view
  UIView *loginAnimView = [[UIView alloc] initWithFrame:sender.frame];
  loginAnimView.layer.cornerRadius = 10;
  loginAnimView.layer.masksToBounds = YES;
  loginAnimView.frame = sender.frame;
  loginAnimView.backgroundColor = DQMMainColor;
  [showView addSubview:loginAnimView];
  sender.hidden = YES;

  //把view从宽的样子变圆
  CGPoint centerPoint = loginAnimView.center;
  CGFloat radius = MIN(sender.frame.size.width, sender.frame.size.height);
  [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{

    loginAnimView.frame = CGRectMake(0, 0, radius, radius);
    loginAnimView.center = centerPoint;
    loginAnimView.layer.cornerRadius = radius/2;
    loginAnimView.layer.masksToBounds = YES;

  }completion:^(BOOL finished) {

    //给圆加一条不封闭的白色曲线
    UIBezierPath* path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:CGPointMake(radius/2, radius/2) radius:(radius/2 - 5) startAngle:0 endAngle:M_PI_2 * 2 clockwise:YES];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.lineWidth = 1.5;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.fillColor = DQMMainColor.CGColor;
    shapeLayer.frame = CGRectMake(0, 0, radius, radius);
    shapeLayer.path = path.CGPath;
    [loginAnimView.layer addSublayer:shapeLayer];

    //让圆转圈，实现"加载中"的效果
    CABasicAnimation* baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    baseAnimation.duration = 0.4;
    baseAnimation.fromValue = @(0);
    baseAnimation.toValue = @(2 * M_PI);
    baseAnimation.repeatCount = MAXFLOAT;
    [loginAnimView.layer addAnimation:baseAnimation forKey:nil];
  }];

  [[RACObserve(self, loginStatus) skip:1] subscribeNext:^(id  _Nullable x) {
    //把蒙版、动画view等隐藏，把真正的login按钮显示出来
    sender.hidden = false;
    [loginAnimView removeFromSuperview];
    [loginAnimView.layer removeAllAnimations];
    
    BOOL status = [x boolValue];
    if (status) {
      //登入成功
      [showView makeToast:@"登录成功！"];
      
    } else {
      //登入失败
      CGPoint sy = CGPointMake(sender.centerX-10, sender.centerY);
      CGPoint sx = CGPointMake(sender.centerX+10, sender.centerY);
      CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
      [animation setTimingFunction:[CAMediaTimingFunction
                                    functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
      [animation setFromValue:[NSValue valueWithCGPoint:sx]];
      [animation setToValue:[NSValue valueWithCGPoint:sy]];
      [animation setAutoreverses:YES];
      [animation setDuration:0.08];
      [animation setRepeatCount:3];
      [sender.layer addAnimation:animation forKey:nil];
    }
  }];


}



@end
