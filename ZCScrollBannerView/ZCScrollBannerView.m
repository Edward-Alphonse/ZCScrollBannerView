//
//  ZCCarouselView.m
//  ZCCarouselView
//
//  Created by QITMAC000242 on 17/2/16.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import "ZCScrollBannerView.h"

//#import "UIView+Size.h"

#define VIEW_WIDTH      CGRectGetWidth(self.frame)
#define VIEW_HEIGHT     CGRectGetHeight(self.frame)
#define PAGECONTROL_HEIGHT 10
#define PAGE_NUMBER     3
#define PAGEINDICATOR_WIDTH 20

@interface ZCScrollBannerView () <UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat durationTime;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger position;

@end

@implementation ZCScrollBannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark --初始化
- (instancetype)initWithFrame:(CGRect)frame durationTime:(CGFloat)durationTime {
    self = [super initWithFrame:frame];
    if(self) {
        _durationTime = durationTime;
        [self setupContentViewWithFrame:frame];
        [self startTimer];
    }
    return self;
}

- (void)setupContentViewWithFrame:(CGRect)frame {
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.bounces = NO;
    _contentView.pagingEnabled = YES;
    _contentView.delegate = self;
    _contentView.contentSize = CGSizeMake(PAGE_NUMBER * VIEW_WIDTH, VIEW_HEIGHT);
    [self addSubview:_contentView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
    
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];

    [self addSubview:_pageControl];
    
}

- (void)dealloc {
    [self stopTimer];
}

#pragma mark --属性设置
- (void)setImgList:(NSArray<UIImage *> *)imgList {
    _imgList = imgList;
    _currentIndex = 0;
    if(_imgList) {
        self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame)- PAGECONTROL_HEIGHT, _imgList.count * PAGEINDICATOR_WIDTH, PAGECONTROL_HEIGHT);
        [_pageControl setCenter:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(_pageControl.frame))];
        [self.pageControl setNumberOfPages:_imgList.count];
        [self layoutContentView];
    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    if(self.pageControl){
        self.pageControl.pageIndicatorTintColor = indicatorColor;
    }
}

- (void)setCurrentIndicatorColor:(UIColor *)currentIndicatorColor {
    if(self.pageControl) {
        self.pageControl.currentPageIndicatorTintColor = currentIndicatorColor;
    }
}

- (NSInteger)previousViewIndex:(NSInteger)currentIndex {
    if(currentIndex == 0) {
        return self.imgList.count - 1;
    }
    return currentIndex - 1;;
}

- (NSInteger)nextViewIndex:(NSInteger)currentIndex {
    if(currentIndex == self.imgList.count - 1) {
        return 0;
    }
    return currentIndex + 1;
}



#pragma mark --定时器
- (void)startTimer {
    if(self.durationTime > 0) {
        [self stopTimer];
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.durationTime target:self selector:@selector(circle) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer {
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)circle {
    NSInteger index = (self.contentView.contentOffset.x + VIEW_WIDTH)/VIEW_WIDTH;
    [_contentView setContentOffset:CGPointMake(index * VIEW_WIDTH, 0) animated:YES];
}

#pragma mark --布局
- (void)layoutContentView {
    [_contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //展示的图片存在
    [self.pageControl setCurrentPage:self.currentIndex];

    NSInteger previousIndex = [self previousViewIndex:self.currentIndex];
    NSInteger nextIndex = [self nextViewIndex:self.currentIndex];
    
    UIImageView *previousImageView = [[UIImageView alloc] initWithImage:self.imgList[previousIndex]];
    previousImageView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.contentView addSubview:previousImageView];
    
    UIImageView *currentImageView = [[UIImageView alloc] initWithImage:self.imgList[self.currentIndex]];
    currentImageView.frame = CGRectMake(VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.contentView addSubview:currentImageView];
    
    UIImageView *nextImageView = [[UIImageView alloc] initWithImage:self.imgList[nextIndex]];
    nextImageView.frame = CGRectMake(2 * VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.contentView addSubview:nextImageView];
    
    self.contentView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
    
    [self startTimer];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.durationTime]];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    if(offSet.x <= 0) {
        self.currentIndex = [self previousViewIndex:self.currentIndex];
        [self layoutContentView];
    }
    else if(offSet.x >= (PAGE_NUMBER - 1) * VIEW_WIDTH) {
        self.currentIndex = [self nextViewIndex:self.currentIndex];
        [self layoutContentView];
    }
}

@end
