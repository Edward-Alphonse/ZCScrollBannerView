//
//  ViewController.m
//  ZCScrollBannerView
//
//  Created by QITMAC000242 on 17/2/17.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import "ViewController.h"

#import "ZCScrollBannerView.h"

#import "UIView+Size.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 1; i <= 5; i++) {
        NSString *name = [NSString stringWithFormat:@"img_%02d", i];
        UIImage *image = [UIImage imageNamed:name];
        [array addObject:image];
    }
    
    ZCScrollBannerView *bannerView = [[ZCScrollBannerView alloc]initWithFrame:CGRectMake(0, 100, self.view.width, 100) durationTime:3.f];
    [bannerView setImgList:array];
    [self.view addSubview:bannerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
