//
//  CompleteInformationViewController.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/10.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "CompleteInformationViewController.h"
#import "UserDetailModel.h"
#import "DQMRightImageViewTableViewCell.h"
#import "SettingUserInfoWithInputViewController.h"//带输入框的编辑
#import "SettingUserInfoWithTableViewController.h"//带选择列表的编辑
#import "PGDatePickManager.h"//时间选择器
#import "HXPhotoPicker.h"//图片选择库

@interface CompleteInformationViewController () <PGDatePickerDelegate,HXCustomCameraViewControllerDelegate,HXAlbumListViewControllerDelegate>
/** 用户模型 */
@property(nonatomic,strong) UserDetailModel *userModel;
/** 组的数组 */
@property(nonatomic,strong) NSMutableArray  *sectionsArray;

//选择图片器
@property (strong, nonatomic) HXPhotoManager *manager;
/** 选择后的图片 */
@property(nonatomic,strong) UIImage          *faceImage;


@end

@implementation CompleteInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView.tableFooterView = [UIView new];
	
}

- (void)viewWillAppear:(BOOL)animated {
	
	UserDetailModel *userModel = [[UserDetailModel alloc] init];
	userModel.userface = [GET_USERDEFAULT(HEADPIC) length] == 0 ? @"" : GET_USERDEFAULT(HEADPIC);
	userModel.aliPay = [GET_USERDEFAULT(ALIPAY) length] == 0 ? @"" : GET_USERDEFAULT(ALIPAY);
	userModel.email = [GET_USERDEFAULT(EMAIL) length] == 0 ? @"" : GET_USERDEFAULT(EMAIL);
	userModel.weChat = [GET_USERDEFAULT(WECHAT) length] == 0 ? @"" : GET_USERDEFAULT(WECHAT);
	userModel.nickName = [GET_USERDEFAULT(NICKNAME) length] == 0 ? @"" : GET_USERDEFAULT(NICKNAME);
	userModel.qq = [GET_USERDEFAULT(QQ) length] == 0 ? @"" : GET_USERDEFAULT(QQ);
	userModel.phone = [GET_USERDEFAULT(MOBILE) length] == 0 ? @"" : GET_USERDEFAULT(MOBILE);
	userModel.job = [GET_USERDEFAULT(JOB) length] == 0 ? @"" : GET_USERDEFAULT(JOB);
	userModel.birthday = [GET_USERDEFAULT(BIRTHDAY) length] == 0 ? @"" : GET_USERDEFAULT(BIRTHDAY);
	userModel.sex = [GET_USERDEFAULT(SEX) length] == 0 ? @"" : GET_USERDEFAULT(SEX);
	self.userModel = userModel;
	
	//处理数据  必须保证没有字段为空  可以给@“”
	[self createSectionsDataArray];
	
	//返回主线程刷新界面
	dispatch_async(dispatch_get_main_queue(), ^{
		[UIView transitionWithView:self.tableView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
			[self.tableView reloadData];
		} completion:nil];
	});
}

//组装cell的数据源
- (void)createSectionsDataArray {
  if (_userModel == nil) {
    [self.view makeToast:@"请先登入!"];
    return;
  }
  
  
  self.sectionsArray = [[NSMutableArray alloc] init];
  NSArray *titleArray = @[@[@"上传头像"],@[@"昵称",@"性别",@"出生日期"],@[@"职业",@"微信号",@"支付宝号",@"邮箱",@"QQ",@"手机号"]];
  NSArray *subtitleArray = @[@[@""],@[_userModel.nickName,_userModel.sex,_userModel.birthday],@[_userModel.job,_userModel.weChat,_userModel.aliPay,_userModel.email,_userModel.qq,_userModel.phone]];
  NSArray *subImageArray = @[@[_userModel.userface],@[@"",@"",@""],@[@"",@"",@"",@"",@"",@""]];
  //对应跳转的界面 0 为不跳转
  NSArray *destVcArray = @[@[[UIViewController class]],@[[SettingUserInfoWithInputViewController class],[SettingUserInfoWithTableViewController class],[UIViewController class]],@[[SettingUserInfoWithTableViewController class],[SettingUserInfoWithInputViewController class],[SettingUserInfoWithInputViewController class],[SettingUserInfoWithInputViewController class],[SettingUserInfoWithInputViewController class],[SettingUserInfoWithInputViewController class]]];
  //样式的数组
  NSArray *viewTpyeArray = @[@[@(0)],@[@(SettingInputStyleNickName),@(0),@(0)],@[@(SettingTableStyleJob),@(SettingInputStyleWeChat),@(SettingInputStyleAliPay),@(SettingInputStyleEmail),@(SettingInputStyleQQ),@(SettingInputStylePhone)]];
  
  for (int i = 0; i < 3; i++) {
    NSMutableArray<DQMRightImageViewTableViewCellModel *> *itemArray = [[NSMutableArray alloc] init];
    for (int j = 0; j < [titleArray[i] count]; j++) {
      DQMRightImageViewTableViewCellModel *item = [DQMRightImageViewTableViewCellModel initWithtitle:titleArray[i][j] andSubTitle:subtitleArray[i][j] andsubImageUrl:subImageArray[i][j] IfNeedCreateWithdestVc:destVcArray[i][j] andviewType:[viewTpyeArray[i][j] integerValue]];
      [itemArray addObject:item];
    }
    [_sectionsArray addObject:itemArray];
  }
	
	QMWeak(self);
	[[RACObserve(self, faceImage) skip:1] subscribeNext:^(UIImage *x) {
		if ([weakself.sectionsArray count] > 0 && weakself.faceImage != nil) {
			DQMRightImageViewTableViewCellModel*item = weakself.sectionsArray[0][0];
			item.subImage = weakself.faceImage;
			NSMutableArray<DQMRightImageViewTableViewCellModel *> *itemArray = [[NSMutableArray alloc] initWithObjects:item, nil];
			[weakself.sectionsArray replaceObjectAtIndex:0 withObject:itemArray];
		}
		[weakself.tableView reloadData];
	}];
	
	
  NSLog(@"11111");
}



#pragma mark - tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [_sectionsArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  //返回1 3 1 1
  return section == 1 ? 3 : section == 2 ? 6 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
  return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section != 3) {
    CGFloat cellHeight = indexPath.section == 0 ? 90 : 58;
    DQMRightImageViewTableViewCell *cell = [DQMRightImageViewTableViewCell cellWithTableView:tableView indexPath:indexPath andFixedHeightIfNeed:cellHeight showArrow:true];
    cell.model = self.sectionsArray[indexPath.section][indexPath.row];
    return cell;
   
  } else if (indexPath.section == 3) {
    
    DQMDefaultTableViewCell *cell = [DQMDefaultTableViewCell cellWithTableView:tableView];
    [cell removeAllSubviews];
    UILabel *loginOutLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [cell addSubview:loginOutLabel];
    loginOutLabel.textAlignment = NSTextAlignmentCenter;
    QMLabelFontColorText(loginOutLabel, @"提交", DQMMainColor, 16);
    return cell;
    
  }
  
  UITableViewCell *cell = [[UITableViewCell alloc] init];
  return cell;
}





#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"下标 %ld   %ld",indexPath.section,indexPath.row);
  
  if (indexPath.section == 3) {
    //退出
    
  }
  
  else if (indexPath.section == 0) {
    //头像
	  UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	  UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		  
	  }];
	  UIAlertAction *manAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		  [self HXChooseImageWithCamera];
	  }];
	  UIAlertAction *wumanAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		  [self HXChooseImageWithPhotoAlbum];
	  }];
	  
	  [alertC addAction:cancleAction];
	  [alertC addAction:manAction];
	  [alertC addAction:wumanAction];
	  [self presentViewController:alertC animated:true completion:^{
		  
	  }];
    
  }
	
  else if (indexPath.section == 1 && indexPath.row == 1) {
	  //性别
	  UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	  UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
	  UIAlertAction *manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      [self saveUserInfoWithType:@"2" Value:@"1"];
		  [kUserDefaults setValue:@"男" forKey:SEX];
	  }];
	  UIAlertAction *wumanAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		  [self saveUserInfoWithType:@"2" Value:@"2"];
		  [kUserDefaults setValue:@"女" forKey:SEX];
	  }];
    UIAlertAction *nillAction = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      [self saveUserInfoWithType:@"2" Value:@"0"];
		[kUserDefaults setValue:@"保密" forKey:SEX];
    }];
	  
	  [alertC addAction:cancleAction];
	  [alertC addAction:manAction];
	  [alertC addAction:wumanAction];
    [alertC addAction:nillAction];
	  [self presentViewController:alertC animated:true completion:^{
	  }];
  }
  
  else if (indexPath.section == 1 && indexPath.row == 2) {
    //生日
	  PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
	  datePickManager.isShadeBackground = true;
	  datePickManager.confirmButtonTextColor = DQMMainColor;
	  PGDatePicker *datePicker = datePickManager.datePicker;
	  datePicker.delegate = self;
	  datePicker.datePickerType = PGDatePickerType1;
	  datePicker.isHiddenMiddleText = true;
	  datePicker.isCycleScroll = true;
	  datePicker.datePickerMode = PGDatePickerModeDate;
	  datePicker.lineBackgroundColor = DQMMainColor;
	  datePicker.textColorOfSelectedRow = DQMMainColor;
	  [self presentViewController:datePickManager animated:false completion:nil];
	  
  }
  
  
  else {
    //跳转二级设置界面
    DQMRightImageViewTableViewCell *cell = (DQMRightImageViewTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIViewController *vc = [[cell.model.destVc alloc] init];
    if ([vc isKindOfClass:[SettingUserInfoWithInputViewController class]]) {
      
      SettingUserInfoWithInputViewController *inputvc = (SettingUserInfoWithInputViewController *)vc;
      inputvc.settingInputStyle = cell.model.viewType;
      [self.navigationController pushViewController:inputvc animated:true];

      
    } else if ([vc isKindOfClass:[SettingUserInfoWithTableViewController class]]) {
      SettingUserInfoWithTableViewController *inputvc = (SettingUserInfoWithTableViewController *)vc;
      inputvc.settingTableStype = cell.model.viewType;
      [self.navigationController pushViewController:inputvc animated:true];
    }
  }
}


/**
 保存到后台
 */
- (void)saveUserInfoWithType:(NSString *)type Value:(NSString *)value {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  [params setValue:type forKey:@"type"];
  [params setValue:value forKey:@"data"];

  [KuQuKeNetWorkManager POST_updateUserInfoParams:params View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
    [self viewWillAppear:true];
    
  } unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
  } failure:^(NSError *error) {
    
  }];
}

#pragma mark - PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
  NSTimeInterval time= [dateComponents.date timeIntervalSince1970]*10;// *1000 是精确到毫秒，不乘就是精确到秒
  NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
  NSLog(@"选中的日期 dateComponents = %@   %@", dateComponents,timeString);
   [self saveUserInfoWithType:@"3" Value:timeString];

	//存储年月日
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString *destDateString = [dateFormatter stringFromDate:dateComponents.date];
	[kUserDefaults setValue:destDateString forKey:BIRTHDAY];
	[self viewWillAppear:true];
}



#pragma mark - HXPhotoManager load
- (HXPhotoManager *)manager {
	if (!_manager) {
		_manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
		_manager.configuration.openCamera = YES;
		_manager.configuration.saveSystemAblum = NO;
		_manager.configuration.themeColor = [UIColor blackColor];
		self.manager.configuration.photoMaxNum = 20;//多少张
		self.manager.configuration.videoMaxNum = 0;//不要视频
		self.manager.configuration.singleSelected = true;//单选
		self.manager.configuration.singleJumpEdit = false;//单选后编辑
	}
	return _manager;
}

#pragma mark - HXPhotoManager delegate
/**
 从相册选择
 */
- (void)HXChooseImageWithPhotoAlbum {
	[self hx_presentSelectPhotoControllerWithManager:self.manager didDone:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL isOriginal, UIViewController *viewController, HXPhotoManager *manager) {
		
	} imageList:^(NSArray<UIImage *> *imageList, BOOL isOriginal) {
//		图片数组
		NSLog(@"选择个数%ld",[imageList count]);
	} cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
		
	}];
}

/**
 从相机选择
 */
- (void)HXChooseImageWithCamera {
	if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[self.view makeToast:@"此设备不支持相机!"];
		return;
	}
	AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
	if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
		[self.view makeToast:@"请在设置-隐私-相机中允许访问相机"];
		return;
	}
	[self hx_presentCustomCameraViewControllerWithManager:self.manager done:^(HXPhotoModel *model, HXCustomCameraViewController *viewController) {
		//拍摄回来的model;
		if (model.type == HXPhotoModelMediaTypePhoto) {
			[self getThePicture:@[model]];
		}
	} cancel:^(HXCustomCameraViewController *viewController) {
		NSSLog(@"取消了");
	}];
}

/**
 相机拍完的回调
 */
- (void)customCameraViewController:(HXCustomCameraViewController *)viewController didDone:(HXPhotoModel *)model {
	if (model.type == HXPhotoModelMediaTypePhoto) {
		[self getThePicture:@[model]];
	}
	NSLog(@"不知道怎么进来的");
}

/** 已选的 */
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original {
	[self getThePicture:photoList];
}

-(void)getThePicture:(NSArray<HXPhotoModel *> *)imagesArray {
	self.faceImage = imagesArray[0].tempImage;
  
  //上传图片到服务器
  [KuQuKeNetWorkManager POST_taskImgUploadParams:[NSDictionary new] uploadWithImage:self.faceImage filename:nil name:@"file" View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
    //图片都传好后保存
    dispatch_async(dispatch_get_main_queue(), ^{
      NSString *urlString = dataDic[@"data"][@"img_url"];
      [kUserDefaults setValue:urlString forKey:@"HEADPIC"];//保存
      [self saveUserInfoWithType:@"8" Value:urlString];
	  [kUserDefaults setValue:dataDic[@"data"][@"real_img_url"] forKey:HEADPIC];
    });
    
  } unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
    
  } failure:^(NSError *error) {
    
  } showHUD:false networkstatus:false showError:true checkLoginStatus:false];
  
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
