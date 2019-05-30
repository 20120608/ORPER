//
//  EarnMoneyViewModel.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/26.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "EarnMoneyViewModel.h"
#import "EarnMoneyForRegisterViewController.h"//注册赚钱的

@interface EarnMoneyViewModel()

@end

@implementation EarnMoneyViewModel
#pragma mark - Life Cycle
- (id) init{
  if (self = [super init]) {
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
      
      NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
      [params setValue:self.currentVC.taskID forKey:@"id"];
	  [params setValue:_nowtype forKey:@"nowtype"];
      [KuQuKeNetWorkManager GET_taskDetailV2Params:params View:self.currentVC.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
        NSLog(@"任务详情 %@",dataDic);
		  
		 
        //发送请求的数据
        [subscriber sendNext:dataDic[@"data"]];
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
    [[NSNotificationCenter defaultCenter] postNotificationName: NotificationName_EarnMoneyForRegisterViewController object:x];
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








@end
