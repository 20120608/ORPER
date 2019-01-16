//
//  UserMessageInputView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "UserMessageInputView.h"
#import "HXPhotoPicker.h"
#import "SDWebImageManager.h"

static const CGFloat kPhotoViewMargin = 3;
static const CGFloat printScreensViewMargin = 12.0;

@interface UserMessageInputView () <HXPhotoViewDelegate>

@property (strong, nonatomic) HXPhotoManager         *manager;
@property (weak, nonatomic  ) HXPhotoView            *photoView;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;


@end

@implementation UserMessageInputView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    /** 姓名 */
    self.nameLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      QMLabelFontColorText(label, @"姓名", QMTextColor, 15);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(70, 44));
      }];
      label;
    });
    
    /** 电话 */
    self.phoneLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      QMLabelFontColorText(label, @"手机号", QMTextColor, 15);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(_nameLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(70, 44));
      }];
      label;
    });
    
    /** 验证码 */
    self.codeLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      QMLabelFontColorText(label, @"验证码", QMTextColor, 15);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(_phoneLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(70, 44));
      }];
      label;
    });
    
    /** 姓名 */
    self.nameTextFiled = ({
      UITextField *textField = [[UITextField alloc] init];
      [self addSubview:textField];
      textField.placeholder = @"注册所用姓名";
      textField.textColor = QMTextColor;
      textField.font = KQMFont(16);
      [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(10);
        make.top.mas_equalTo(_nameLabel.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.height.mas_equalTo(40);
      }];
      textField;
    });
    UIView *line1 = [[UIView alloc] init];
    [_nameTextFiled addSubview:line1];
    line1.backgroundColor = QMBackColor;
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.mas_equalTo(0);
      make.height.mas_equalTo(1);
    }];
    
    /** 电话 */
    self.phoneTextFiled = ({
      UITextField *textField = [[UITextField alloc] init];
      [self addSubview:textField];
      textField.placeholder = @"注册所用的手机号";
      textField.textColor = QMTextColor;
      textField.font = KQMFont(16);
      [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(10);
        make.top.mas_equalTo(_phoneLabel.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-150);
        make.height.mas_equalTo(40);
      }];
      textField;
    });
    UIView *line2 = [[UIView alloc] init];
    [self addSubview:line2];
    line2.backgroundColor = QMBackColor;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(_phoneLabel.mas_right).offset(10);
      make.top.mas_equalTo(_phoneLabel.mas_bottom);
      make.right.mas_equalTo(self.mas_right).offset(-15);
      make.height.mas_equalTo(1);
    }];
    
    /** 验证码 */
    self.codeTextFiled = ({
      UITextField *textField = [[UITextField alloc] init];
      [self addSubview:textField];
      textField.placeholder = @"注册所用姓名";
      textField.textColor = QMTextColor;
      textField.font = KQMFont(16);
      [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(10);
        make.top.mas_equalTo(_codeLabel.mas_top);
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.height.mas_equalTo(40);
      }];
      textField;
    });
    UIView *line3 = [[UIView alloc] init];
    [_codeTextFiled addSubview:line3];
    line3.backgroundColor = QMBackColor;
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.right.bottom.mas_equalTo(0);
      make.height.mas_equalTo(1);
    }];
    
    /** 验证码 */
    self.codeButton = ({
      UIButton *button = [[UIButton alloc] init];
      [self addSubview:button];
      QMSetButton(button, @"获取验证码", 15, nil, QMTextColor, UIControlStateNormal);
      QMViewBorderRadius(button, 4, 1, QMSubTextColor);
      [button addTarget:self action:@selector(codeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.mas_equalTo(_phoneTextFiled.mas_top);
      }];
      button;
    });
    
    
    /** 上传截图 */
    UILabel *msgLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.top.mas_equalTo(_codeLabel.mas_bottom);
        make.width.mas_equalTo(kScreenWidth);//撑开宽
        make.size.mas_equalTo(CGSizeMake(80, 44));
      }];
      label;
    });
    QMLabelFontColorText(msgLabel, @"上传截图", QMTextColor, 15);
    
    
    /** 提交的图片数组 */
    self.printScreensView = ({
      UIView *view = [[UIView alloc] init];
      [self addSubview: view];
      QMViewBorderRadius(view, 8, 0, QMBackColor);
      view.backgroundColor = QMBackColor;
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(printScreensViewMargin);
        make.top.mas_equalTo(msgLabel.mas_bottom).offset(12);
        make.width.mas_equalTo(kScreenWidth-printScreensViewMargin*2);//选图片的子视图会撑高
      }];
      view;
    });
    
    
	  /** 提交审核按钮 */
	  self.putButton = ({
		  UIButton *button = [[UIButton alloc] init];
		  [self addSubview:button];
		  QMSetButton(button, @"提交审核", 16, nil, UIColor.whiteColor, UIControlStateNormal);
		  QMViewBorderRadius(button, 4, 0, QMBlueColor);
		  button.backgroundColor = QMBlueColor;
		  [button addTarget:self action:@selector(beginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		  [button mas_makeConstraints:^(MASConstraintMaker *make) {
			  make.centerX.mas_equalTo(self.mas_centerX);
			  make.height.mas_equalTo(45);
			  make.width.mas_equalTo(150);
			  make.top.mas_equalTo(_printScreensView.mas_bottom).offset(44);
		  }];
		  button;
	  });
    /** 介绍 */
    self.msgLabel = ({
      UILabel *label = [[UILabel alloc] init];
      [self addSubview:label];
      label.textAlignment = NSTextAlignmentCenter;
      QMLabelFontColorText(label, @"通过审核后自动到账,审核时长1~2工作日", QMSubTextColor, 10);
      [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-30-HOME_INDICATOR_HEIGHT);//撑开高
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_putButton.mas_bottom).offset(20);
      }];
      label;
    });
    
    //创建选择图片的容器
    [self createImagesBackContentView];
    
  }
  return self;
}


#pragma mark - HXPhotoManager
- (void)createImagesBackContentView {
  
  HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
  photoView.frame = CGRectMake(3, 3, kScreenWidth - printScreensViewMargin*2 - kPhotoViewMargin * 2, 0);
//  photoView.showAddCell = NO;
  photoView.outerCamera = NO;//相机放外边
  photoView.backgroundColor = QMBackColor;
  photoView.lineCount = 4;
  photoView.delegate = self;
  photoView.manager.configuration.showDateSectionHeader = NO;
  [_printScreensView addSubview:photoView];
  self.photoView = photoView;
  
  [self.photoView refreshView];
  
}

#pragma mark - load
- (HXPhotoManager *)manager {
  if (!_manager) {
    _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
    _manager.configuration.saveSystemAblum = YES;
    _manager.configuration.photoMaxNum = 20;
    _manager.configuration.videoMaxNum = 0;
    _manager.configuration.maxNum = 20;
  }
  return _manager;
}

- (HXDatePhotoToolManager *)toolManager {
  if (!_toolManager) {
    _toolManager = [[HXDatePhotoToolManager alloc] init];
  }
  return _toolManager;
}

#pragma mark - HXphotomanager delegate
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
  NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
  
  //    [self.toolManager writeSelectModelListToTempPathWithList:allList requestType:0 success:^(NSArray<NSURL *> *allURL, NSArray<NSURL *> *photoURL, NSArray<NSURL *> *videoURL) {
  //        NSSLog(@"%@",allURL);
  //    } failed:^{
  //
  //    }];
  
  
  //    [self.view showLoadingHUDText:nil];
  //    __weak typeof(self) weakSelf = self;
  //    [self.toolManager getSelectedImageList:allList success:^(NSArray<UIImage *> *imageList) {
  //        [weakSelf.view handleLoading];
  //        NSSLog(@"%@",imageList);
  //    } failed:^{
  //        [weakSelf.view handleLoading];
  //    }];
}

- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
  NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
  NSSLog(@"%@",NSStringFromCGRect(frame));
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);

  //更新约束
  [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(UIEdgeInsetsMake(kPhotoViewMargin, kPhotoViewMargin, kPhotoViewMargin, kPhotoViewMargin));
    make.height.mas_greaterThanOrEqualTo(CGRectGetMaxY(frame));//3间隔
  }];
  [UIView animateWithDuration:0.25 animations:^{
    [self layoutIfNeeded];
  }];
}






#pragma mark - event
- (void)codeButtonClick:(UIButton *)sender {
  
}

- (void)beginButtonClick:(UIButton *)sender {
  
}



@end
