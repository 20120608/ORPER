//
//  ZJCalenderView.m
//  
//
//  Created by 张骏 on 17/3/28.
//  Copyright © 2017年 Zj. All rights reserved.
//

#import "ZJCalenderView.h"
#import "ZJCalenderCollectionView.h"
#import "ZJCalenderDateManager.h"
#import "ZJCalenderMonthModel.h"
#import "ZJCalenderDayModel.h"
#import "ZJCalenderConst.h"

@interface ZJCalenderView()
@property (nonatomic, strong) ZJCalenderCollectionView *calenderCollectionView;
@property (nonatomic, strong) UIView *swichView;
@property (nonatomic, strong) UIView *weekView;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UIButton *lastMonthBtn;
@property (nonatomic, strong) UIButton *nextMonthBtn;
@property (nonatomic, strong) NSMutableArray *monthModelArray;
@property (nonatomic, assign) NSInteger visibleIndex;
@property (nonatomic, assign) ZJCalenderMode calenderMode;

@end

@implementation ZJCalenderView

#pragma mark ---lifeCycle---

- (instancetype)initWithFrame:(CGRect)frame calenderMode:(ZJCalenderMode)calenderMode{
    
    if (calenderMode == ZJCalenderModePartScreen) {
        frame = CGRectMake(0, frame.origin.y, ZJScreenWidth, ZJCalenderPartScreenHeight);
    }
    
    if (self = [super initWithFrame:frame]) {
       
        self.calenderMode = calenderMode;
        
        self.layer.masksToBounds = YES;
        
        self.selectedEnable = YES;
    
        [self setupSwichView];
        
        [self setupWeekView];
        
        [self setupCalenderView];
        
        [self setupCalenderDate];
    }
    return self;
}


- (void)dealloc{
    [ZJCalenderDateManager sharedManager].selectFinished = NO;
}


#pragma mark ---public---
- (void)setFrame:(CGRect)frame{
    if (_calenderMode == ZJCalenderModePartScreen) {
        CGRect rect = CGRectMake(0, 0, ZJScreenWidth, ZJCalenderPartScreenHeight);
        rect.origin.y = frame.origin.y;
        [super setFrame:rect];
    } else {
        [super setFrame:frame];
    }
}


- (void)setVisibleIndex:(NSInteger)visibleIndex{
    _visibleIndex = visibleIndex;
    QMWeak(self);
    if (_calenderMode == ZJCalenderModePartScreen) {
        ZJCalenderMonthModel *monthModel = _monthModelArray[visibleIndex];
        dispatch_async(dispatch_get_main_queue(), ^{
			NSArray *monthArray = @[@"JAN",@"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC"];
           weakself.monthLabel.text = [NSString stringWithFormat:@"%@ %zd", monthArray[monthModel.month - 1], monthModel.year];
        });
    }
}


- (void)setSelectedEnable:(BOOL)selectedEnable{
    _selectedEnable = selectedEnable;
    
    _calenderCollectionView.userInteractionEnabled = selectedEnable;
}


- (void)reloadData{
    [self setupCalenderDate];
}


#pragma mark ---userInteraction---
- (void)swichBtnClicked:(UIButton *)sender {

    switch (sender.tag) {
        case 0:
            self.visibleIndex -= 1;
            _nextMonthBtn.enabled = YES;
            [_calenderCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_visibleIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
            if (_visibleIndex == 0) _lastMonthBtn.enabled = NO;
            break;
            
        default:
            self.visibleIndex += 1;
            _lastMonthBtn.enabled = YES;
            [_calenderCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_visibleIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
            if (_visibleIndex == _monthModelArray.count - 1) _nextMonthBtn.enabled = NO;
            break;
    }
}

/**
 滚动到下一年
 */
- (void)scrollNestYear {
  //bug:会在界面没创建前执行
//  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    self.visibleIndex = 12;
//    _nextMonthBtn.enabled = YES;
//    [_calenderCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_visibleIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:true];
//    if (_visibleIndex == 0) _lastMonthBtn.enabled = NO;
//    if (_visibleIndex == _monthModelArray.count - 1) _nextMonthBtn.enabled = NO;
//  });
}


#pragma mark ---private---
- (UIButton *)createButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = ZJCalenderBackgroundColor;
    [btn addTarget:self action:@selector(swichBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (UIImage *)bundleImageNamed:(NSString *)imageName{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", ZJCalenderBundle, imageName]];
}


#pragma mark ---UI---
- (void)setupSwichView{
    if (_calenderMode == ZJCalenderModeFullScreen) return;
    
    _swichView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJScreenWidth, ZJCalenderPartScreenSwichViewHeight)];
	[_swichView setGradientBackgroundWithColors:@[QMHexColor(@"88ec9b"), QMHexColor(@"5bbd7d")] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];

    [self addSubview:_swichView];
    
    _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZJCalenderWidth, ZJCalenderPartScreenSwichViewHeight)];
    _monthLabel.textAlignment = NSTextAlignmentCenter;
    _monthLabel.textColor = [UIColor whiteColor];
	_monthLabel.font = [UIFont systemFontOfSize:17];
    _monthLabel.font = [UIFont systemFontOfSize:ZJCalenderLargeTextSize weight:UIFontWeightLight];
    _monthLabel.backgroundColor = [UIColor clearColor];
    _monthLabel.layer.masksToBounds = YES;
    
    [_swichView addSubview:_monthLabel];

    _lastMonthBtn = [self createButton];
    _lastMonthBtn.tag = 0;
    _lastMonthBtn.frame = CGRectMake(0, 0, 50, ZJCalenderPartScreenSwichViewHeight);
    _lastMonthBtn.enabled = NO;
	_lastMonthBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [_lastMonthBtn setImage:[UIImage imageNamed:@"ZJCalenderLastImg"] forState:UIControlStateNormal];
	_lastMonthBtn.backgroundColor = [UIColor clearColor];
	[self setBorderWithView:_lastMonthBtn tlbr:3 borderColor:QMHexColor(@"999999") borderWidth:1];
    [_swichView addSubview:_lastMonthBtn];
    
    _nextMonthBtn = [self createButton];
    _nextMonthBtn.tag = 1;
    _nextMonthBtn.enabled = NO;
    _nextMonthBtn.frame = CGRectMake(ZJCalenderWidth-50, 0, 50, ZJCalenderPartScreenSwichViewHeight);
	_nextMonthBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [_nextMonthBtn setImage:[UIImage imageNamed:@"ZJCalenderNextImg"] forState:UIControlStateNormal];
	_nextMonthBtn.backgroundColor = [UIColor clearColor];
	[self setBorderWithView:_nextMonthBtn tlbr:1 borderColor:QMHexColor(@"999999") borderWidth:1];
    [_swichView addSubview:_nextMonthBtn];
}
- (void)setBorderWithView:(UIView *)view tlbr:(NSInteger)tlbr borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
	if (tlbr == 0) {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
		layer.backgroundColor = color.CGColor;
		[view.layer addSublayer:layer];
	}
	if (tlbr == 1) {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
		layer.backgroundColor = color.CGColor;
		[view.layer addSublayer:layer];
	}
	if (tlbr == 2) {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
		layer.backgroundColor = color.CGColor;
		[view.layer addSublayer:layer];
	}
	if (tlbr == 3) {
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
		layer.backgroundColor = color.CGColor;
		[view.layer addSublayer:layer];
	}
}


- (void)setupWeekView {
    CGFloat weekX = 0;
    CGFloat weekY = CGRectGetMaxY(_swichView.frame);
    CGFloat weekW = ZJCalenderWidth;
    CGFloat weekH = ZJCalenderWeekViewHeight;
    
    _weekView = [[UIView alloc] initWithFrame:CGRectMake(weekX, weekY, weekW, weekH)];
    _weekView.backgroundColor = ZJCalenderBackgroundColor;
    
    CGFloat weekDayWidth = weekW / 7;
    
    for (NSInteger i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0 + weekDayWidth * i, (ZJCalenderWeekViewHeight - weekDayWidth) / 2 + 14, weekDayWidth, ZJCalenderCommonTextSize)];
        label.font = [UIFont systemFontOfSize:ZJCalenderCommonTextSize weight:UIFontWeightLight];
        label.textColor = ZJCalenderDisabledTextColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = ZJCalenderBackgroundColor;
        label.layer.masksToBounds = YES;
        
        switch (i) {
            case 0:
                label.text = @"SUN";
                label.textColor = ZJCalenderThemeColor;
                break;
                
            case 1:
                label.text = @"MON";
                break;
                
            case 2:
                label.text = @"TUE";
                break;
                
            case 3:
                label.text = @"WED";
                break;
                
            case 4:
                label.text = @"THU";
                break;
                
            case 5:
                label.text = @"FRI";
                break;
                
            default:
                label.text = @"SAT";
                label.textColor = ZJCalenderThemeColor;
                break;
        }
        
        [_weekView addSubview:label];
    }
    
    [self addSubview:_weekView];
    
    if (_calenderMode == ZJCalenderModePartScreen) return;
    
    UIColor *colorOne = [ZJCalenderBackgroundColor colorWithAlphaComponent:1.0];
    UIColor *colorTwo = [ZJCalenderBackgroundColor colorWithAlphaComponent:0.0];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    CAGradientLayer *shadowLayer = [CAGradientLayer layer];
    shadowLayer.colors = @[(id)colorOne.CGColor, (id)colorTwo.CGColor];
    shadowLayer.locations = @[stopOne, stopTwo];
    shadowLayer.frame = CGRectMake(0, _weekView.frame.size.height, _weekView.frame.size.width, 10);
    [_weekView.layer addSublayer:shadowLayer];
}


- (void)setupCalenderView {
    
    CGFloat calenderX = ZJPadding;
    CGFloat calenderY = CGRectGetMaxY(_weekView.frame);
    CGFloat calenderW = (ZJCalenderWidth);
    CGFloat calenderH = (ZJCalenderWidth);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    CGFloat itemWidth = (ZJCalenderWidth) / 7;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    _calenderCollectionView = [[ZJCalenderCollectionView alloc] initWithFrame:CGRectMake(calenderX, calenderY, calenderW, calenderH) collectionViewLayout:layout];
    _calenderCollectionView.calenderMode = _calenderMode;
    _calenderCollectionView.monthModelArray = _monthModelArray.count ? _monthModelArray : nil;

  [self insertSubview:_calenderCollectionView atIndex:0];
}


- (void)setupCalenderDate {
    WeakObj(self);
	[[ZJCalenderDateManager sharedManager] getCalenderDateComplete:^(NSMutableArray *monthModelArray) {
		if (selfWeak.calenderCollectionView) {
			selfWeak.calenderCollectionView.monthModelArray = monthModelArray;
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			selfWeak.monthModelArray = monthModelArray;
			selfWeak.visibleIndex = 0;
			selfWeak.nextMonthBtn.enabled = YES;
		});
	}];
}


- (void)setCheckinHistoryArray:(NSMutableArray *)checkinHistoryArray {
  _checkinHistoryArray = checkinHistoryArray;
  
  NSCalendar* calendar = [NSCalendar currentCalendar];
  unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
  NSDateComponents* comp = [calendar components:unitFlags fromDate:[NSDate date]];
  
  QMWeak(self);
  [self.monthModelArray enumerateObjectsUsingBlock:^(ZJCalenderMonthModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if (obj.year == [comp year] && obj.month == [comp month]) {
      obj = [weakself addSign_status:obj checkinHistoryArray:checkinHistoryArray];
      [weakself.monthModelArray replaceObjectAtIndex:idx withObject:obj];
    }
  }];
  [weakself.calenderCollectionView reloadData];
  
}

- (ZJCalenderMonthModel *)addSign_status:(ZJCalenderMonthModel *)monthModel checkinHistoryArray:(NSMutableArray *)checkinHistoryArray {
  [monthModel.dayModelArray enumerateObjectsUsingBlock:^(ZJCalenderDayModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    obj.signStatus = [checkinHistoryArray[idx][@"is_sign"] intValue];
    [monthModel.dayModelArray replaceObjectAtIndex:idx withObject:obj];
  }];
  return monthModel;
}


@end
