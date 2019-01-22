//
//  EarnMoneyForRegisterViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "EarnMoneyForRegisterViewController.h"
#import "EarnMoneyForSubLabelView.h"//标签
#import "PreviewTaskRequireView.h"  //任务内容
#import "UserMessageInputView.h"//输入用户信息

@interface EarnMoneyForRegisterViewController ()

/** 滚动的背景 */
@property(nonatomic,strong) UIScrollView          *scrollView;
/** 任务步骤图片数组 */
@property (nonatomic, copy) NSMutableArray<NSString *> *imagesUrlStringArray;


@end

@implementation EarnMoneyForRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self createUI];
  
  
  //模拟请求
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.imagesUrlStringArray = [[NSMutableArray alloc] initWithArray:@[@"http://img4.duitang.com/uploads/item/201601/15/20160115231312_TWuG5.gif",
                                                                        @"http://c.hiphotos.baidu.com/baike/pic/item/d1a20cf431adcbefd4018f2ea1af2edda3cc9fe5.jpg",
                                                                        @"http://img3.duitang.com/uploads/item/201605/28/20160528202026_BvuWP.jpeg",
                                                                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118823131&di=aa588a997ac0599df4e87ae39ebc7406&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201605%2F08%2F20160508154653_AQavc.png",
                                                                        @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=722693321,3238602439&fm=27&gp=0.jpg",
                                                                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118892596&di=5e8f287b5c62ca0c813a548246faf148&imgtype=0&src=http%3A%2F%2Fwx1.sinaimg.cn%2Fcrop.0.0.1080.606.1000%2F8d7ad99bly1fcte4d1a8kj20u00u0gnb.jpg",
                                                                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118914981&di=7fa3504d8767ab709c4fb519ad67cf09&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201410%2F05%2F20141005221124_awAhx.jpeg",
                                                                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118934390&di=fbb86678336593d38c78878bc33d90c3&imgtype=0&src=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Farchive%2Fe90aa49ddb2fa345fa588cf098baf7b3d0e27553.jpg",
                                                                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524118984884&di=7c73ddf9d321ef94a19567337628580b&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201506%2F07%2F20150607185100_XQvYT.jpeg"]];
    
  });
  
  
}


#pragma mark - UI
- (void)createUI {
  
  EarnMoneyForSubLabelView *subTagView = ({
    EarnMoneyForSubLabelView *view = [[EarnMoneyForSubLabelView alloc] init];
    [self.scrollView addSubview: view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(_scrollView.mas_left);
      make.top.mas_equalTo(_scrollView.mas_top);
      make.right.mas_equalTo(_scrollView.mas_right);
    }];
    view;
  });
  subTagView.backgroundColor = UIColor.whiteColor;
  
  PreviewTaskRequireView *preTaskView = ({
    PreviewTaskRequireView *view = [[PreviewTaskRequireView alloc] init];
    [self.scrollView addSubview: view];
    view.backgroundColor = UIColor.whiteColor;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_scrollView.mas_left);
            make.top.mas_equalTo(subTagView.mas_bottom);
            make.right.mas_equalTo(_scrollView.mas_right);
    }];
    view;
  });
  
  [[RACObserve(self, imagesUrlStringArray) skip:1] subscribeNext:^(NSMutableArray<NSString *> *x) {
    preTaskView.imagesUrlStringArray = x;
  }];
  
  
  UserMessageInputView *userMessageView = ({
    UserMessageInputView *view = [[UserMessageInputView alloc] init];
    [self.scrollView addSubview: view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(_scrollView.mas_left);
      make.top.mas_equalTo(preTaskView.mas_bottom);
      make.right.mas_equalTo(_scrollView.mas_right);
      make.bottom.mas_equalTo(_scrollView.mas_bottom);
    }];
    view;
  });
  userMessageView.backgroundColor = UIColor.whiteColor;
  
  
  
  
}



#pragma mark - load UI
-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = ({
      UIScrollView *scrollView = [[UIScrollView alloc] init];
      [self.view addSubview:scrollView];
      [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(NAVIGATION_BAR_HEIGHT, 0, 0, 0));
      }];
      scrollView;
    });
  }
  return _scrollView;
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
  return DQMMainColor;
}

@end
