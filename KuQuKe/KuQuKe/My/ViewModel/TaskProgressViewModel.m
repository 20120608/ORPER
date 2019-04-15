//
//  TaskProgressViewModel.m
//  KuQuKe
//
//  Created by Xcoder on 2019/4/15.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "TaskProgressViewModel.h"
#import "TaskProgressModel.h"//cell的样式
#import "TaskProgressTableViewCell.h"
#import "TaskProgressFailTableViewCell.h"

@interface TaskProgressViewModel()
	//数据源
	@property(nonatomic,strong)NSMutableArray *models;
	@property(nonatomic,assign)NSInteger currentPage;
	
	@end

//分页第一页是0 、1
static const NSInteger startingValue = 1;


@implementation TaskProgressViewModel
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
			[params setValue:[NSNumber numberWithInt:10] forKey:@"num"];
			[params setValue:paramPage forKey:@"page"];
			[params setValue:@"1" forKey:@"type"];//默认给1  游戏不做

			[KuQuKeNetWorkManager GET_getBakListParams:params View:self.currentVC.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				
				NSArray *dataArray = [TaskProgressModel mj_objectArrayWithKeyValuesArray:dataDic[@"data"][@"task_list"][@"list"]];
				if(dataArray.count > 0){
					if(requestPage == startingValue){
						self.currentPage = startingValue;
						[self.models removeAllObjects];
					} else {
						self.currentPage = requestPage;
					}
					[self.models addObjectsFromArray:dataArray];
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
	
	//监听登录操作产生的数据
	//switchToLatest获取最新发送的信号，只能用于信号中信号
	[_requestVideoListCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
		//    NSLog(@"请求完成后的回调");
		[[NSNotificationCenter defaultCenter] postNotificationName: NotificationName_TaskProgressViewController object:x];
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
	
	
	
	
#pragma mark - tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [_models count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TaskProgressModel *model =  _models[indexPath.section];
	if ([model.status intValue] == 1) {
		TaskProgressTableViewCell *cell = [TaskProgressTableViewCell cellWithTableView:tableView indexPath:indexPath FixedCellHeight:0];
		cell.model = model;
		return cell;
	}
	TaskProgressFailTableViewCell *cell = [TaskProgressFailTableViewCell cellWithTableView:tableView indexPath:indexPath FixedCellHeight:0];
		cell.model = model;
	return cell;
	
}
	
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
	footer.backgroundColor = QMBackColor;
	return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 10;
}


#pragma mark - Getter && Setter
- (NSMutableArray *)models {
if (!_models) {
	_models = [NSMutableArray array];
}
return _models;
}
	
@end
