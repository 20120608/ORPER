//
//  EarnMoneyDetailModel.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/2/26.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "EarnMoneyDetailModel.h"

@implementation EarnMoneyDetailModel

- (NSString *)msgForJoinStatus {
//	join_status  5是未参与 0是 1是已经提交任务审核了 2是审核通过 3是审核不通过 6是过时失效了

	NSString *string;
	switch ([self.join_info[@"join_status"] intValue]) {
		case 0:
			string = @"任务进行中";
			break;
		case 1:
			string = @"已经提交任务审核了";
			break;
		case 2:
			string = @"审核通过";
			break;
		case 3:
			string = @"审核不通过";
			break;
		case 4:
			string = @"暂无";
			break;
		case 5:
			string = @"未参与";
			break;
		case 6:
			string = @"过时失效";
			break;
		default:
			break;
	}
	return string;
}

@end
