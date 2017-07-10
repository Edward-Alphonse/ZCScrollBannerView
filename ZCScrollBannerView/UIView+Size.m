//
//  UIView+View.m
//  NetworkDemo
//
//  Created by QITMAC000242 on 17/1/22.
//  Copyright © 2017年 QITMAC000242. All rights reserved.
//

#import "UIView+Size.h"

@implementation UIView (Size)

@dynamic left;
@dynamic right;
@dynamic bottom;
@dynamic top;

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)top {
    return self.y;
}

- (CGFloat)bottom {
    return self.y + self.height;
}

- (CGFloat)left {
    return self.x;
}

- (CGFloat)right {
    return self.x + self.width;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.centerX, centerY);
}

- (CGFloat)centerY {
    return self.center.y;
}

@end
