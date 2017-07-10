//
//  ZCCarouselView.h
//  ZCCarouselView
//
//  Created by QITMAC000242 on 17/2/16.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCScrollBannerView : UIView

@property (nonatomic, strong) NSArray<UIImage *> *imgList;
@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *currentIndicatorColor;

@end
