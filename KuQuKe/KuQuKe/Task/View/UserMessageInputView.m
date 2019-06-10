//
//  UserMessageInputView.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "UserMessageInputView.h"
#import "SDWebImageManager.h"

static const CGFloat kPhotoViewMargin = 3;
static const CGFloat printScreensViewMargin = 12.0;

@interface UserMessageInputView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *stepImgsArray;//步骤图片
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *uploadArray;
@property (nonatomic, strong) NSMutableArray *waitArray;
@property (nonatomic, strong) NSMutableArray *completeArray;
@property (nonatomic, strong) HXDatePhotoToolManager *toolManager;
@property (weak, nonatomic) id<UIViewControllerPreviewing> previewingContext;

@end

@implementation UserMessageInputView

#pragma mark - load
- (HXDatePhotoToolManager *)toolManager {
	if (!_toolManager) {
		_toolManager = [[HXDatePhotoToolManager alloc] init];
	}
	return _toolManager;
}


#pragma mark - event
- (void)codeButtonClick:(UIButton *)sender {
	if ([self.delegate respondsToSelector:@selector(getCodeWithUserMessageInputView:code:phone:name:)]) {
		[self.delegate getCodeWithUserMessageInputView:self code:_codeLabel.text phone:_phoneLabel.text name:_nameLabel.text];
	}
}

- (void)beginButtonClick:(UIButton *)sender {
	if ([self.delegate respondsToSelector:@selector(saveToInvestigateWithUserMessageInputView:ImageArray:code:phone:name:)]) {
		[self.delegate saveToInvestigateWithUserMessageInputView:self ImageArray:[self takeOutimageArray] code:_codeLabel.text phone:_phoneLabel.text name:_nameLabel.text];
	}
}

- (instancetype)initWithStepModels:(NSArray *)imageArray {
	
	self = [super init];
	self.stepImgsArray = [[NSArray alloc] initWithArray:imageArray];
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
		textField.placeholder = @"短信验证码";
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
			make.left.mas_equalTo(self.mas_left).offset(4);
			make.top.mas_equalTo(msgLabel.mas_bottom).offset(12);
			make.width.mas_equalTo(kScreenWidth-4*2);
			make.height.mas_equalTo(((kScreenWidth - 4*2 - 3 * 3)/4 + 4) * (_stepImgsArray.count / 4 + 1) * 2+12);
		}];
		view;
	});
	
	
	/** 提交审核按钮 */
	self.putButton = ({
		UIButton *button = [[UIButton alloc] init];
		[self addSubview:button];
		QMSetButton(button, @"提交审核", 16, nil, UIColor.whiteColor, UIControlStateNormal);
		QMViewBorderRadius(button, 4, 0, UIColor.whiteColor);
		button.backgroundColor = QMPriceColor;
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
		QMLabelFontColorText(label, @"通过审核后自动到账,审核时长1~3工作日", QMSubTextColor, 10);
		[label mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.mas_equalTo(self.mas_bottom).offset(-30-HOME_INDICATOR_HEIGHT);//撑开高
			make.left.right.mas_equalTo(0);
			make.top.mas_equalTo(_putButton.mas_bottom).offset(20);
		}];
		label;
	});
	
	//创建选择图片的容器
	[self createImagesBackContentView];
	
	return self;
}


#pragma mark - HXPhotoManager
- (void)createImagesBackContentView {
	
	UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
	[layout setScrollDirection:UICollectionViewScrollDirectionVertical]; //设置竖直滚动
	layout.minimumInteritemSpacing = 3;
	layout.minimumLineSpacing = 3;
	layout.itemSize = CGSizeMake(((kScreenWidth - printScreensViewMargin*2 - kPhotoViewMargin * 3)/4 - 1), ((kScreenWidth - printScreensViewMargin*2 - kPhotoViewMargin * 3)/4 - 1) * 2+8);

	self.collectionView = ({
		UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(4, 4, kScreenWidth - printScreensViewMargin*2+1, 0) collectionViewLayout:layout];
		view.delegate = self;
		view.dataSource = self;
		view.scrollEnabled = false;
		view.backgroundColor = QMBackColor;
		[view registerClass:[HXCollectionViewCell class] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
		[_printScreensView addSubview:view];
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(UIEdgeInsetsMake(6, 4, 4, 4));
		}];
		view;
	});
	
}

- (NSMutableArray <HXPhotoModel *> *)takeOutimageArray {
	NSMutableArray <HXPhotoModel *> *imageArray = [[NSMutableArray alloc] init];
	
	[[self cellsForCollectionView:self.collectionView] enumerateObjectsUsingBlock:^(HXCollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if (obj.selectHXPhotoModel) {
			[imageArray addObject:obj.selectHXPhotoModel];
		}
	}];
	return imageArray;
}
//获取cell
- (NSArray<HXCollectionViewCell *> *)cellsForCollectionView:(UICollectionView *)collectionView {
	NSInteger sections = collectionView.numberOfSections;
	NSMutableArray<HXCollectionViewCell *> *cells = [[NSMutableArray alloc] init];
	for (int section = 0; section < sections; section++) {
		 NSInteger rows = [collectionView numberOfItemsInSection:section];
		for (int row = 0; row < rows; row++) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
			[cells addObject:(HXCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath]];
			}
		}
	return cells;
}

#pragma mark - collectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.stepImgsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	HXCollectionViewCell *cell = [HXCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
	[cell settingExImg:_stepImgsArray[indexPath.item]];
	return cell;
}

//  HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
//  photoView.frame = CGRectMake(3, 3, kScreenWidth - printScreensViewMargin*2 - kPhotoViewMargin * 2, 0);
////  photoView.showAddCell = NO;
//  photoView.outerCamera = NO;//相机放外边
//  photoView.backgroundColor = QMBackColor;
//  photoView.lineCount = 4;
//  photoView.delegate = self;
//  photoView.manager.configuration.showDateSectionHeader = NO;
//  [_printScreensView addSubview:photoView];
//  self.photoView = photoView;
//
//  [self.photoView refreshView];

//#pragma mark - HXphotomanager delegate
//- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
//
//  //将获取到的图片暴露出去
//  self.imageArray = photos;
//
//}
//
//- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
//  NSSLog(@"%@",networkPhotoUrl);
//}
//
//- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
//  NSSLog(@"%@",NSStringFromCGRect(frame));
////    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
//
//  //更新约束
//  [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
//    make.edges.mas_equalTo(UIEdgeInsetsMake(kPhotoViewMargin, kPhotoViewMargin, kPhotoViewMargin, kPhotoViewMargin));
//    make.height.mas_greaterThanOrEqualTo(CGRectGetMaxY(frame));//3间隔
//  }];
//  [UIView animateWithDuration:0.25 animations:^{
//    [self layoutIfNeeded];
//  }];
//}

@end
