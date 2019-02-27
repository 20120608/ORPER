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
#import "EarnMoneyDetailModel.h"//注册赚钱模型
#import "EarnMoneyViewModel.h"//视图模型


@interface EarnMoneyForRegisterViewController () <UserMessageInputViewDelegate,PreviewTaskRequireViewDelegate>

@property (nonatomic, strong) EarnMoneyViewModel *racViewModel;

/** 滚动的背景 */
@property(nonatomic,strong) UIScrollView          *scrollView;

/** 任务模型 */
@property(nonatomic,strong) EarnMoneyDetailModel          *earnModel;

@end

@implementation EarnMoneyForRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self createUI];

  //绑定
  [self setupBind];
  
  [self.racViewModel.requestVideoListCommand execute:@{@"reloadData":@"1"}];

}



#pragma mark - Bind UI
- (void)setupBind{
  
  self.racViewModel.currentVC = self;
  
  //通知方法刷新表视图
  @weakify(self)
  [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NotificationName_EarnMoneyForRegisterViewController object:nil] subscribeNext:^(NSNotification * _Nullable x) {
    @strongify(self)
    NSDictionary * dataDic = [x object];
    [self resetRefreshView:dataDic];
  }];
}



/**
 请求成功后的刷新
 */
- (void)resetRefreshView:(NSDictionary *)dataDic {
  self.earnModel = [EarnMoneyDetailModel mj_objectWithKeyValues:dataDic];
}




#pragma mark - UI
- (void)createUI {
  
  EarnMoneyForSubLabelView *subTagView = ({
    EarnMoneyForSubLabelView *view = [[EarnMoneyForSubLabelView alloc] init];
    [self.scrollView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.scrollView.mas_left);
      make.top.mas_equalTo(self.scrollView.mas_top);
      make.right.mas_equalTo(self.scrollView.mas_right);
    }];
    view;
  });
  subTagView.backgroundColor = UIColor.whiteColor;
  
  PreviewTaskRequireView *preTaskView = ({
    PreviewTaskRequireView *view = [[PreviewTaskRequireView alloc] init];
    [self.scrollView addSubview: view];
	view.delegate = self;
    view.backgroundColor = UIColor.whiteColor;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.scrollView.mas_left);
      make.top.mas_equalTo(subTagView.mas_bottom);
      make.right.mas_equalTo(self.scrollView.mas_right);
    }];
    view;
  });
  
  UserMessageInputView *userMessageView = ({
    UserMessageInputView *view = [[UserMessageInputView alloc] init];
    [self.scrollView addSubview: view];
	view.delegate = self;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.scrollView.mas_left);
      make.top.mas_equalTo(preTaskView.mas_bottom);
      make.right.mas_equalTo(self.scrollView.mas_right);
      make.bottom.mas_equalTo(self.scrollView.mas_bottom);
    }];
    view;
  });
  userMessageView.backgroundColor = UIColor.whiteColor;
  
  
  [[RACObserve(self, earnModel) skip:1] subscribeNext:^(EarnMoneyDetailModel *x) {
    preTaskView.imagesUrlStringArray = [[NSMutableArray alloc] initWithArray:x.exp_img];
    subTagView.earnModel = x;
    preTaskView.earnModel = x;
  }];
}

#pragma mark - 开始任务
- (void)beginButtonClickPreviewTaskRequireView:(PreviewTaskRequireView *)view {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	[params setValue:_taskID forKey:@"id"];
	
	[KuQuKeNetWorkManager POST_taskStartParams:params View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		[self.view makeToast:@"现在开始任务了!"];
		//刷新数据一下
		[self.racViewModel.requestVideoListCommand execute:@{@"reloadData":@"1"}];
		
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
}

#pragma mark - 提交审核按钮
- (void)getCodeWithUserMessageInputView:(UserMessageInputView *)userMessageInputView code:(NSString *)code phone:(NSString *)phone name:(NSString *)name {
  NSLog(@"获取验证码");
	
}

- (void)saveToInvestigateWithUserMessageInputView:(UserMessageInputView *)userMessageInputView ImageArray:(NSArray <HXPhotoModel *>  *)imageArray code:(NSString *)code phone:(NSString *)phone name:(NSString *)name {
	if ([_earnModel.join_info[@"join_status"] intValue] != 0) {
		[self.view makeToast:[_earnModel msgForJoinStatus]];
		return;
	} else if ([code length] == 0 || [phone length] == 0 || [name length] == 0) {
		[self.view makeToast:@"请填写个人信息!"];
		return;
	} else if([imageArray count] == 0) {
		[self.view makeToast:@"请先选择截图!"];
		return;
	}
	
  NSLog(@"上传图片中");
  
  NSMutableArray *imageUrlArray = [[NSMutableArray alloc] init];
  
  [imageArray enumerateObjectsUsingBlock:^(HXPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
    HXPhotoModel *hxPhotoModel = imageArray[idx];
    [KuQuKeNetWorkManager POST_taskImgUploadParams:[NSDictionary new] uploadWithImage:hxPhotoModel.previewPhoto filename:nil name:@"file" View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
      
      [imageUrlArray addObject:dataDic[@"data"][@"real_img_url"]];
      if (imageUrlArray.count == imageArray.count) {
        //图片都传好后保存
        [self saveUserMessageToAudit:imageUrlArray code:code phone:phone name:name];
      }
      
    } unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
      
    } failure:^(NSError *error) {
      
    } showHUD:false networkstatus:false showError:true checkLoginStatus:false];
  }];
}

/**
 图片上传后提交审核
 */
- (void)saveUserMessageToAudit:(NSMutableArray *)imageUrlArray code:(NSString *)code phone:(NSString *)phone name:(NSString *)name {
	//要删除第一个
	NSString *imgString = [imageUrlArray componentsJoinedByString:@","];
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	[params setValue:_taskID forKey:@"id"];
	[params setValue:_earnModel.join_info[@"applyid"] forKey:@"applyid"];
	[params setValue:imgString forKey:@"img"];
	[params setValue:name forKey:@"account"];
	[params setValue:phone forKey:@"mobile"];
	[params setValue:code forKey:@"code"];

	[KuQuKeNetWorkManager POST_addTaskOkParams:params View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		NSLog(@"完成了提交审核！");
		[self.view makeToast:@"提交成功,请等待审核"];
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
}




#pragma mark - load
- (EarnMoneyViewModel *)racViewModel{
  if (!_racViewModel) {
    _racViewModel = [[EarnMoneyViewModel alloc] init];
  }
  return _racViewModel;
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
