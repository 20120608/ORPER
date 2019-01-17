//
//  ViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/1/6.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  
  
  
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
  [QMSGeneralHelpers showAlertMaskViewAlpha:0.5 AndLoadingAlwaysHUD:true animated:true graceTime:1 delayAfter:1 completeBlock:^(UIView *maskView, MBProgressHUD *hud) {
    
    NSLog(@"结束回调%f",maskView.width);
  }];
  
  
}


@end
