//
//  ShopCategoryViewController.m
//  KuQuKe
//
//  Created by Xcoder on 2019/4/16.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "ShopCategoryViewController.h"
@interface ShopCategoryViewController ()

@end

@implementation ShopCategoryViewController



- (void)viewDidLoad {
    [super viewDidLoad];


	[KuQuKeNetWorkManager GET_huawutongLogin:@{} View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		[kUserDefaults setValue:dataDic[@"token"] forKey:USER_TOKEN];

		NSLog(@"游客号码dataDic = %@",dataDic);
		[self getUserInfo];
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
	
	
	
}


- (void)getUserInfo {
	[KuQuKeNetWorkManager GET_getMember:@{} View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		NSLog(@"getUserInfo = %@",dataDic);
		[self gettag];
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
}

- (void)gettag {
	[KuQuKeNetWorkManager GET_huawutonggetTags:@{} View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		NSLog(@"gettag = %@",dataDic);
		[self getdialoglist];
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
}

-(void)getdialoglist {
	[KuQuKeNetWorkManager GET_huawutonggetCurDateDialLogList:@{} View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		NSLog(@"getdialoglist = %@",dataDic);
		[self gettaskbegin];
		
	} failure:^(NSError *error) {
		
	}];
}

-(void)gettaskbegin {
	[KuQuKeNetWorkManager GET_huawutonggetTask:@{} View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
		NSLog(@"gettaskbegin = %@",dataDic);
		[self getNewPhone];
		
	} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
		
	} failure:^(NSError *error) {
		
	}];
}


-(void)getNewPhone {
	for (int i = 0; i < 3; i++) {
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i/10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[KuQuKeNetWorkManager GET_huawutongNewPhone:@{} View:self.view success:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				
				NSLog(@"电话号码: %@",dataDic[@"data"][0][@"mobile"]);
				
			} unknown:^(RequestStatusModel *reqsModel, NSDictionary *dataDic) {
				
			} failure:^(NSError *error) {
				
			}];
		});
	}

}




@end
