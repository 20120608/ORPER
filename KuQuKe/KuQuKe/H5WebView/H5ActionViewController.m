//
//  H5ActionViewController.m
//  KuQuKe
//
//  Created by hallelujah on 2019/3/11.
//  Copyright © 2019年 kuquke. All rights reserved.
//

#import "H5ActionViewController.h"
#import <WebKit/WebKit.h>

@interface H5ActionViewController () <WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation H5ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self createWebView];


}


#pragma mark - create UI
- (void)createWebView
{
	WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
	WKUserContentController *wkUController = [[WKUserContentController alloc] init];
	wkWebConfig.preferences.minimumFontSize = 0;
	wkWebConfig.userContentController = wkUController;
	// 自适应屏幕宽度js
	NSString *jSString = @"";
	WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
	// 添加js调用
	[wkUController addUserScript:wkUserScript];
	
	
	self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAVIGATION_BAR_HEIGHT) configuration:wkWebConfig];
	self.webView.backgroundColor = [UIColor whiteColor];
	self.webView.UIDelegate = self;
	self.webView.navigationDelegate = self;
	[self.webView sizeToFit];
	
	NSURL *url;
	url = [NSURL URLWithString:_apartUrl];
	NSLog(@"详情的连接 %@",url);
	
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:urlRequest];
	[self.view addSubview:_webView];
}



#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
	
}

#pragma mark - wkwebView delegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler();
	}])];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(NO);
	}])];
	[alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(YES);
	}])];
	[self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		textField.text = defaultText;
	}];
	[alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(alertController.textFields[0].text?:@"");
	}])];
	
	[self presentViewController:alertController animated:YES completion:nil];
}

-(void)dealloc{
	NSLog(@"正常释放");
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -  WKWebView NavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
	NSLog(@"是否允许这个导航");
	decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
	//    NSLog(@"知道返回内容之后，是否允许加载，允许加载");
	decisionHandler(WKNavigationResponsePolicyAllow);
	
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
	//    NSLog(@"开始加载");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
	//    NSLog(@"跳转到其他的服务器");
	
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
	//    NSLog(@"网页由于某些原因加载失败");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
	//    NSLog(@"网页开始接收网页内容");
	
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[_webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable value, NSError * _Nullable error) {
		CGSize actualSize = [webView sizeThatFits:CGSizeZero];
		CGRect newFrame = webView.frame;
		newFrame.size.height = actualSize.height;
		webView.frame = newFrame;
	}];
	
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
	//    NSLog(@"加载失败,失败原因:%@",[error description]);
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
	//    NSLog(@"网页加载内容进程终止");
}







#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
	return true;
}

/** 导航条左边的按钮 */
- (UIImage *)dqmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar {
	[leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
	return [UIImage imageNamed:@"NavgationBar_white_back"];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
	[self.navigationController popViewControllerAnimated:true];
}

- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
	return DQMMainColor;
}

@end
