//
//  ViewController.m
//  shiBie_Demo
//
//  Created by cchaojie on 2017/11/16.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh.h>

@interface ViewController ()<UIWebViewDelegate>

//@property(nonatomic,strong) UIImageView* imageView;
//@property(nonatomic,strong) UIImageView* imageView1;


@property (nonatomic, strong) UIWebView *webView;//网页

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIWebView *webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    //如果你导入的MJRefresh库不是最新的库，就用下面的方法创建下拉刷新和上拉加载事件
    webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    webView.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    //如果你导入的MJRefresh库是最新的库，就用下面的方法创建下拉刷新和上拉加载事件
    webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    webView.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [self.view addSubview:webView];
    self.webView = webView;

  
}

#pragma mark - 下拉刷新
- (void)headerRefresh{
    
    [self loadData];
}

#pragma mark - 上拉加载
- (void)footerRefresh{
    
    [self loadData];
}

#pragma mark - 结束下拉刷新和上拉加载
- (void)endRefresh{
    
    //当请求数据成功或失败后，如果你导入的MJRefresh库不是最新的库，就用下面的方法结束下拉刷新和上拉加载事件
    [self.webView.scrollView.mj_header endRefreshing];
    [self.webView.scrollView.mj_footer endRefreshing];
    
    //当请求数据成功或失败后，如果你导入的MJRefresh库是最新的库，就用下面的方法结束下拉刷新和上拉加载事件
    [self.webView.scrollView.mj_header endRefreshing];
    [self.webView.scrollView.mj_footer endRefreshing];
    
}
#pragma mark - 加载网页
- (void)loadData{
    
    NSString *urlString =@"http://blog.csdn.net/wwc455634698/article/details/53005676";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationTyp{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self endRefresh];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self endRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
