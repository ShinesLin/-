//
//  DealDetalsController.m
//  美团
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealDetalsController.h"
#import "Deals.h"
@interface DealDetalsController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DealDetalsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    
    NSURL *url = [NSURL URLWithString:self.deal.deal_h5_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //显示更多，图文详情url路径，需要拼接
    // 拼接详情的URL路径
    NSString *ID = self.deal.deal_id;
    ID = [ID substringFromIndex:[ID rangeOfString:@"-"].location + 1];
    NSString *urlStr = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", ID];
    if ([webView.request.URL.absoluteString isEqualToString:urlStr]) {//加载详情完毕
        NSMutableString *js = [NSMutableString string];
        [js appendString:@"var bodyHTML = '';"];
        // 拼接link的内容
        [js appendString:@"var link = document.body.getElementsByTagName('link')[0];"];
        [js appendString:@"bodyHTML += link.outerHTML;"];
        // 拼接多个div的内容
        [js appendString:@"var divs = document.getElementsByClassName('detail-info');"];
        [js appendString:@"for (var i = 0; i<=divs.length; i++) {"];
        [js appendString:@"var div = divs[i];"];
        [js appendString:@"if (div) { bodyHTML += div.outerHTML; }"];
        [js appendString:@"}"];
        // 设置body的内容
        [js appendString:@"document.body.innerHTML = bodyHTML;"];
        
         //执行JS代码
        [webView stringByEvaluatingJavaScriptFromString:js];
        
    }else{//加载初始页面完毕
        NSString *js = [NSString stringWithFormat:@"window.location.href = '%@';",urlStr];
        [webView stringByEvaluatingJavaScriptFromString:js];
    }
   
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    NSLog(@"%@  %@",self.deal.details,request.URL);
//    return YES;

//var bodyHtml = '';
//var linkDiv = document.body.getElementsByTagName('link');
//bodyHtml += linkDiv.outerHTML;
//var divs = document.getElementsByClassName('detail-info');
//for (var i = 0;i<=divs.length;i++){
//    var nodes = divs[i];
//    if(nodes){
//        bodyHtml += nodes.outerHTML;
//    }
//}
//document.body.innerHTML = bodyHtml;
//}

//NSMutableString *js = [NSMutableString string];
//[js appendString:@"var bodyHtml = '';"];
//[js appendString:@"var linkDiv = document.body.getElementsByTagName('link')[0];"];
//[js appendString:@"bodyHtml += linkDiv.outerHTML;"];
//
//[js appendString:@"var divs = document.getElementsByClassName('detail-info');"];
//[js appendString:@"for (var i = 0;i<=divs.length;i++){"];
//[js appendString:@"var nodes = divs[i];"];
//[js appendString:@"if(nodes){ bodyHtml += nodes.outerHTML;"];
//[js appendString:@"}"];
//
//[js appendString:@"document.body.innerHTML = bodyHtml;"];
//[webView stringByEvaluatingJavaScriptFromString:js];

@end
