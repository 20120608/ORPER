//
//  RACMVVMViewModel.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/25.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "RACMVVMViewModel.h"
#import "RACMVVMListTableViewCell.h"
#import "DQMCommonNetWorkingManager.h"//常见的网络请求

#import "DQMLoginViewController.h"

#import "NSData+YYAdd.h"


@interface RACMVVMViewModel()
//数据源
@property(nonatomic,strong)NSMutableArray *videoModels;
@property(nonatomic,assign)NSInteger currentPage;

@end

//分页第一页是0 、1
static const NSInteger startingValue = 1;


@implementation RACMVVMViewModel
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
      NSMutableDictionary *params = [NSMutableDictionary dictionary];
      NSString *paramPage = [NSString stringWithFormat:@"%ld",requestPage];
      [params setObject:paramPage forKey:@"page"];
      [params setObject:[NSNumber numberWithInt:10] forKey:@"pagesize"];
      [params setValue:@"爱" forKey:@"keyword"];
      [params setValue:@"4d183277-94ac-4238-aed1-bf1d7e3858b5" forKey:@"cabinetId"];

      //请求列表数据
      [DQMCommonNetWorkingManager GET_PDWSearchBookWithBookName:params AndView:self.currentVC.view success:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
        
        NSLog(@"数据");
        NSArray *dataArray = [RACMVVMListModel mj_objectArrayWithKeyValuesArray:dataDic[@"res"]];
        if(dataArray.count > startingValue){
          if(requestPage == startingValue){
            self.currentPage = startingValue;
            [self.videoModels removeAllObjects];
          } else {
            self.currentPage = requestPage;
          }
          [self.videoModels addObjectsFromArray:dataArray];
        } else {
          
        }
        //发送请求的数据
        [subscriber sendNext:dataDic];
        [subscriber sendCompleted];
        
      } unknown:^(RequestStatusModel * _Nonnull reqsModel, NSDictionary * _Nonnull dataDic) {
        
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
    [[NSNotificationCenter defaultCenter] postNotificationName: NotificationName_RefreshMainVC object:x];
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
	
	
	
	NSString *str = [NSString stringWithFormat:@"kuquke_%@kuquke666_666",[[QMSGeneralHelpers currentTimeStr] md5String]];
	NSString *token = [str md5String];
	
	NSDictionary *testDemoDic = [[NSMutableDictionary alloc] init];
	[testDemoDic setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[testDemoDic setValue:token forKey:@"token"];
	
	[DQMCommonNetWorkingManager GET_KuqukeWithParams:testDemoDic View:self.currentVC.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		NSLog(@"dataDic = %@",dataDic);
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		NSLog(@"dataDic2 = %@",dataDic);
	} failure:^(NSError *error) {
		NSLog(@"error = %@",error);
	}];
	
	NSString *uidString = @"1";
	
	NSString *md5uid = [[NSString stringWithFormat:@"kuquke_%@kuquke666%@kuquke666_666",[[QMSGeneralHelpers currentTimeStr] md5String],[uidString md5String]] md5String];
	
	NSDictionary *uidDemoDic = [[NSMutableDictionary alloc] init];
	[uidDemoDic setValue:[QMSGeneralHelpers currentTimeStr] forKey:@"time"];
	[uidDemoDic setValue:md5uid forKey:@"token"];
	[uidDemoDic setValue:uidString forKey:@"uid"];

	[DQMCommonNetWorkingManager GET_getIndexConfig:uidDemoDic View:self.currentVC.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		NSLog(@"dataDic = %@",dataDic);
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		NSLog(@"dataDic2 = %@",dataDic);
	} failure:^(NSError *error) {
		NSLog(@"error = %@",error);
	}];
	
	NSString *timeString = [QMSGeneralHelpers currentTimeStr];
	NSNumber *phonetype = [NSNumber numberWithInteger:2];
	NSString *deviceid = [QMSGeneralHelpers getNowuniqueString];
//	[[NSString stringWithFormat:@"kuquke_%@kuquke666%@kuquke666%@kuquke666_666",[deviceid md5String],[[NSString stringWithFormat:@"%@",phonetype] md5String],[timeString md5String]] md5String];
	
	NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
	[postDic setValue:deviceid forKey:@"deviceid"];
	[postDic setValue:phonetype forKey:@"phonetype"];
	[postDic setValue:timeString forKey:@"time"];
	
	NSString *postTokenString = [QMSGeneralHelpers md5Codesign:postDic];

	[postDic setValue:postTokenString forKey:@"token"];


	[DQMCommonNetWorkingManager POST_Kuqukelogin:postDic View:self.currentVC.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		NSLog(@"dataDic = %@",dataDic);
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		NSLog(@"dataDic2 = %@",dataDic);
	} failure:^(NSError *error) {
		NSLog(@"error = %@",error);
	}];
}




#pragma mark - Delegate：UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.videoModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  RACMVVMListTableViewCell *cell = [RACMVVMListTableViewCell cellWithTableView:tableView indexPath:indexPath FixedCellHeight:104];
  cell.cellModel = self.videoModels[indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  DQMLoginViewController *vc = [[DQMLoginViewController alloc] init];
  [self.currentVC presentViewController:vc animated:true completion:nil];
}



#pragma mark - Getter && Setter
- (NSMutableArray *)videoModels {
  if (!_videoModels) {
    _videoModels = [NSMutableArray array];
  }
  return _videoModels;
}

@end
