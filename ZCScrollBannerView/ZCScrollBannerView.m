//
//  ZCCarouselView.m
//  ZCCarouselView
//
//  Created by QITMAC000242 on 17/2/16.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import "ZCScrollBannerView.h"

#import "UIView+Size.h"

#define PAGECONTROL_HEIGHT 10

@interface ZCScrollBannerView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation ZCScrollBannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark --init

- (instancetype)init {
    if(self = [super init]) {
        [self initSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initSetting];
    }
    return self;
}

- (void)initSetting {
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.bounces = NO;
    _contentView.pagingEnabled = YES;
    _contentView.delegate = self;
    [self addSubview:_contentView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
    [self addSubview:_pageControl];
    
    _timeInterval = 1;
    
}

- (void)dealloc {
    [self stopTimer];
}

- (void)startTimer {
    [self stopTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(circle) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)circle {
    NSInteger currentPage = _pageControl.currentPage;
    if(currentPage < _imgList.count - 1) {
        currentPage++;
    }
    else {
        currentPage = 0;
    }
    [_contentView setContentOffset:CGPointMake(currentPage * self.width, 0) animated:YES];
}

#pragma mark --Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_contentView setFrame:CGRectMake(0, 0, self.width, self.height)];
    [_pageControl setFrame:CGRectMake(0, self.height - PAGECONTROL_HEIGHT, 100, PAGECONTROL_HEIGHT)];
    [_pageControl setCenterX:self.width/2];
    [_pageControl setPageIndicatorTintColor:_indicatorColor];
    [_pageControl setCurrentPageIndicatorTintColor:_currentIndicatorColor];

    //展示的图片存在
    if(_imgList) {
        _contentView.contentSize = CGSizeMake(_imgList.count * self.width, self.height);
        [_pageControl setNumberOfPages:_imgList.count];
        [_pageControl setCurrentPage:0];
        
        for(int i = 0; i < _imgList.count; i++) {
            UIImageView *imgView = [[UIImageView alloc]initWithImage:_imgList[i]];
            [imgView setFrame:CGRectMake(i * self.width, 0, self.width, self.height)];
            [_contentView addSubview:imgView];
        }
        [self startTimer];
    }
}


#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //浮点数结果转换为整数，会抹掉小数部分取整数。为保障页面偏移到屏幕一半时，进入到下一页，进行如下运算
    NSInteger currentPage = (scrollView.contentOffset.x + self.width *0.5)/ self.width;
    _pageControl.currentPage = currentPage;
}

@end
