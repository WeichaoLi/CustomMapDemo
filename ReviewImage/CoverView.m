//
//  CoverView.m
//  ReviewImage
//
//  Created by 李伟超 on 15/3/19.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "CoverView.h"

#define POINT_MAKE(X) CGPointMake X

@implementation CoverView

- (id)initWithFrame:(CGRect)frame Scale:(CGFloat)scale Points:(NSString *)pointString{
    frame = [self adjustFrame:frame with:scale];
    if (self = [super initWithFrame:frame]) {
        _scale = scale;
        [self setPointsWith:pointString];
    }
    return self;
}

- (void)setPointsWith:(NSString *)Str {
    //@"{0,0}-{0,53}-{60,53}-{60,23}-{170,23}-{170,0}";
    NSArray *array = [Str componentsSeparatedByString:@"-"];
    if (!_points) {
        _points = [NSArray arrayWithArray:array];
    }
//    for (NSString *pointStr in array) {
//        CGPoint point = CGPointFromString(pointStr);
//        _points
//    }
}

- (CGRect)adjustFrame:(CGRect)frame with:(CGFloat)scale {    
    return CGRectMake(frame.origin.x * scale, frame.origin.y * scale, frame.size.width * scale, frame.size.height * scale);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.clipsToBounds = NO;
    if (_points.count) {

        CGContextRef context = UIGraphicsGetCurrentContext();
        for (int i = 0; i < _points.count; i++) {
            CGPoint point = CGPointFromString(_points[i]);
            point = CGPointMake(point.x * _scale, point.y * _scale);
            if (i == 0) {
                CGContextMoveToPoint(context, point.x, point.y);
            }else {
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
        CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
        CGContextFillPath(context);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
        
//        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
//        for (int i = 0; i < _points.count; i++) {
//            CGPoint point = CGPointFromString(_points[i]);
//            point = CGPointMake(point.x * _scale, point.y * _scale);
//            NSLog(@"%@",NSStringFromCGPoint(point));
//            if (i == 0) {
//                [bezierPath moveToPoint:point];
//            }else {
//                [bezierPath addLineToPoint:point];
//            }
//        }
//        [bezierPath closePath];
//        [UIColor.yellowColor setFill];
//        [bezierPath fill];
//        [UIColor.blackColor setStroke];
//        bezierPath.lineWidth = 1;
//        [bezierPath stroke];
    }else {
        [UIColor.yellowColor setFill];
        UIRectFill(rect);
    }
    
    self.alpha = 0.6;
}

- (void)startflicker {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(RepeatAnimation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)RepeatAnimation {
    
    [UIView animateWithDuration:0.4
                          delay:0
                        options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 0.3;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.4
                                               delay:0
                                             options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                                          animations:^{
                                              self.alpha = 0.6;
                                          }
                                          completion:^(BOOL finished){
                                              
                                          }];
                     }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_handleTouch) {
        _handleTouch();
    }
}

@end
