//
//  MyExclusiveTaskViewModel.m
//  KuQuKe
//
//  Created by hallelujah on 2019/3/12.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "MyExclusiveTaskViewModel.h"
#import "NSData+YYAdd.h"
#import "MyExclusiveTaskViewController.h"//应用列表

#import "TaskTableViewCell.h"//任务列表cell
#import "LeftAndRightLabelHeaderView.h"//组头
#import "EarnMoneyForRegisterViewController.h"//注册赚钱



@interface MyExclusiveTaskViewModel()
//可选的
@property(nonatomic,strong)NSMutableArray *taskListModelArray;
//进行中的
@property(nonatomic,strong)NSMutableArray *goingModelArray;
@property(nonatomic,assign)NSInteger currentPage;

@end

//分页第一页是0 、1
static const NSInteger startingValue = 1;


@implementation MyExclusiveTaskViewModel
#pragma mark - Life Cycle
- (id) init{
	if (self = [super init]) {
		_currentPage = startingValue;
		[self setupBind];
	}
	return self;
}

#pragma mark - private Methods
- (void)setupBind {
	//RACCommand事件
	@weakify(self)
	//封装网络请求的操作
	_requestVideoListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
		return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
			@strongify(self)
			//请求分页的视频列表数据
			NSDictionary *inputData = (NSDictionary *)input;
			BOOL headerRefresh = [inputData[@"headerRefresh"] boolValue];
			NSInteger requestPage = headerRefresh ? startingValue : self.currentPage + 1;
			NSString *paramPage = [NSString stringWithFormat:@"%ld",requestPage];
			
			NSMutableDictionary *params = [NSMutableDictionary dictionary];
			[params setValue:@"1" forKey:@"type"];//1应用赚 2游戏赚
			[params setValue:[NSNumber numberWithInt:10] forKey:@"num"];
			[params setValue:paramPage forKey:@"page"];
			
			[KuQuKeNetWorkManager GET_getTaskListParams:params View:self.currentVC.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				
				NSArray *dataArray = [APPTaskModel mj_objectArrayWithKeyValuesArray:dataDic[@"data"][@"task_list"][@"list"]];
				if(dataArray.count > 0){
					if(requestPage == startingValue){
						self.currentPage = startingValue;
						[self.taskListModelArray removeAllObjects];
					} else {
						self.currentPage = requestPage;
					}
					[self.taskListModelArray addObjectsFromArray:dataArray];
				} else {
					
				}
				
				NSArray *goingArray = [APPTaskModel mj_objectArrayWithKeyValuesArray:dataDic[@"data"][@"task_nowlist"]];
				if(goingArray.count > 0){
					if(requestPage == startingValue){
						[self.goingModelArray removeAllObjects];
					} else {
						self.currentPage = requestPage;
					}
					[self.goingModelArray addObjectsFromArray:goingArray];
				} else {
					
				}
				
				//发送请求的数据
				[subscriber sendNext:dataDic];
				[subscriber sendCompleted];
				
			} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				
				//发送请求的数据
				[subscriber sendNext:dataDic];
				[subscriber sendCompleted];
				
			} failure:^(NSError * _Nonnull error) {
				
				//发送请求的数据
				[subscriber sendNext:@{}];
				[subscriber sendCompleted];
				
			}];
			
			
			return nil;
		}];
	}];
	
	//switchToLatest获取最新发送的信号，只能用于信号中信号
	[_requestVideoListCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
		//    NSLog(@"请求完成后的回调");
		[[NSNotificationCenter defaultCenter] postNotificationName: NotificationName_MyExclusiveTaskViewController object:x];
	}];
	
	//监听登录操作的状态：正在进行或者已经结束
	//默认会监测一次，所以这里使用skip表示跳过第一次信号。
	[[_requestVideoListCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
		if ([x isEqual:@(YES)]) {
			//      NSLog(@"开始请求的回调");
			//正在执行，显示MBProgressHUD
		}else{
			//      NSLog(@"结束请求的回调");
			//正在执行或者没有执行，隐藏MBProgressHUD
		}
	}];
	
}




#pragma mark - Delegate：UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return [_goingModelArray count];
	}
	return [_taskListModelArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	LeftAndRightLabelHeaderView *heaerView = [[LeftAndRightLabelHeaderView alloc] initWithFrame:CGRectZero];
	LeftAndRightLabelHeaderViewModel *heaerModel = [LeftAndRightLabelHeaderViewModel initWithleftString:@"我的专属任务" rightString:@""];
	heaerView.headerModel = heaerModel;
	heaerView.textFont = KQMFont(25);
	heaerView.textColor = QMHexColor(@"eaeaea");
	heaerView.backgroundColor = UIColor.whiteColor;
	return heaerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	TaskTableViewCell *cell = [TaskTableViewCell cellWithTableView:tableView initWithCellStyle:TaskTableViewCellStyleSubTag indexPath:indexPath andFixedHeightIfNeed:80];
	cell.appTaskModel = _taskListModelArray[indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	EarnMoneyForRegisterViewController *vc = [[EarnMoneyForRegisterViewController alloc] initWithTitle:@"注册赚钱"];
	vc.nowtype = @"3";
	vc.taskID = ((APPTaskModel *)_taskListModelArray[indexPath.row]).id;
	[self.currentVC.navigationController pushViewController:vc animated:true];
	
}


#pragma mark - Getter && Setter
- (NSMutableArray *)taskListModelArray {
	if (!_taskListModelArray) {
		_taskListModelArray = [NSMutableArray array];
	}
	return _taskListModelArray;
}

@end
