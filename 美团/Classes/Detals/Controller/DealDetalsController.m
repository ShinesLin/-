//
//  DealDetalsController.m
//  美团
//
//  Created by apple on 16/3/12.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "DealDetalsController.h"
#import "Deals.h"
#import "DealsTool.h"
#import "MBProgressHUD+MJ.h"
#import "UIView+AutoLayout.h"
#import "ListPriceCenterLine.h"
#import "Restrictions.h"
#import "UIButton+Extension.h"
#import "UIImageView+WebCache.h"


#define UMAppKey @"53fb4899fd98c5a4db00a8a0"
@interface DealDetalsController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
/** 显示网页加载圈圈*/
//@property (nonatomic,weak) UIActivityIndicatorView *loadView;
@end

@implementation DealDetalsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    //显示左边内容
    [self setupLeftContent];
    //显示右边内容
    [self setupRightContent];
}

//规定显示横屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - 处理左边内容
- (void)setupLeftContent
{
    [self updateLeftContent];
    
    GetSingleDealParams *pamars = [[GetSingleDealParams alloc]init];
    pamars.deal_id = self.deal.deal_id;
    [DealsTool getSingleDeal:pamars success:^(GetSingleDealResult *result) {
        if (result.deals.count) {
            self.deal = [result.deals lastObject];
            [self updateLeftContent];
        }else{
            [MBProgressHUD showError:@"没有指定团购"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"加载团购失败"];
    }];
}

- (void)updateLeftContent
{
    self.titleLabel.text = self.deal.title;
    self.descripLabel.text = self.deal.desc;
    self.listLabel.text = [NSString stringWithFormat:@"￥%@",self.deal.list_price];
    self.labelWithConstraint.constant = [self.listLabel.text sizeWithAttributes:@{NSFontAttributeName : self.listLabel.font}].width + 1;
    
    self.currentLabel.text = [NSString stringWithFormat:@"门店价%@",self.deal.current_price];
    
    self.refoundableAnyTimebtn.selected = self.deal.restrction.is_refundable;
    self.refoundableexpirebtn.selected = self.deal.restrction.is_refundable;
    self.purchaseCount.title = [NSString stringWithFormat:@"已销售%d",self.deal.purchase_count];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
}

#pragma mark - 处理右边内容
- (void)setupRightContent
{
    
    NSURL *url = [NSURL URLWithString:self.deal.deal_h5_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
     self.webView.scrollView.hidden = YES;
    [self.webView loadRequest:request];
    
    //显示圆圈
//    UIActivityIndicatorView *loadView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
//    [self.webView addSubview:loadView];
//    [loadView startAnimating];
    //居中
    //[loadView autoCenterInSuperview];
    
    //self.loadView = loadView;
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
        //显示网页内容
         webView.scrollView.hidden = NO;
        
        //移除圈圈
       // [self.loadView removeFromSuperview];
        
    }else{//加载初始页面完毕
        NSString *js = [NSString stringWithFormat:@"window.location.href = '%@';",urlStr];
        [webView stringByEvaluatingJavaScriptFromString:js];
    }
   
}

#pragma mark - 按钮点击
- (IBAction)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buy {
}

- (IBAction)collect {
}

- (IBAction)share {
    
    
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
@end
