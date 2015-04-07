//
//  CoverView.m
//  ReviewImage
//
//  Created by 李伟超 on 15/3/19.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "CoverView.h"
#import <QuartzCore/CADisplayLink.h>

#define POINT_MAKE(X) CGPointMake X

@implementation CoverView {
    CGMutablePathRef pathRef;
    CADisplayLink *_timer;
}

- (id)initWithFrame:(CGRect)frame Scale:(CGFloat)scale Points:(NSString *)pointString {
    frame = [self adjustFrame:frame with:scale];
    if (self = [super initWithFrame:frame]) {
        [self setUserInteractionEnabled:YES];
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
}

- (CGRect)adjustFrame:(CGRect)frame with:(CGFloat)scale {    
    return CGRectMake(frame.origin.x * scale, frame.origin.y * scale, frame.size.width * scale, frame.size.height * scale);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_points.count) {
        /**
         *  cgpath
         */
        CGContextRef gc = UIGraphicsGetCurrentContext();
        pathRef = CGPathCreateMutable();
        CGPoint initalPoint = CGPointZero;
        for (int i = 0; i < _points.count; i++) {
            CGPoint point = CGPointFromString(_points[i]);
            point = CGPointMake(point.x * _scale, point.y * _scale);
            if (i==0) {
                CGPathMoveToPoint(pathRef, NULL, point.x, point.y);
                initalPoint = point;
            }else {
                CGPathAddLineToPoint(pathRef, NULL, point.x, point.y);
            }
        }
        CGPathAddLineToPoint(pathRef, NULL, initalPoint.x, initalPoint.y);
        CGPathCloseSubpath(pathRef);
        CGContextAddPath(gc, pathRef);
        [[UIColor redColor] setFill];
        CGContextFillPath(gc);
        
        /**
         *  cgcontext
         *
         */
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        for (int i = 0; i < _points.count; i++) {
//            CGPoint point = CGPointFromString(_points[i]);
//            point = CGPointMake(point.x * _scale, point.y * _scale);
//            if (i == 0) {
//                CGContextMoveToPoint(context, point.x, point.y);
//            }else {
//                CGContextAddLineToPoint(context, point.x, point.y);
//            }
//        }
//        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//        CGContextClosePath(context);
//        CGContextDrawPath(context, kCGPathFillStroke);
        
        /**
         *  bezier
         */
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
        pathRef = CGPathCreateMutable();
        CGPathAddRect(pathRef, NULL, rect);
        CGPathCloseSubpath(pathRef);
        
        [UIColor.redColor setFill];
        UIRectFill(rect);
    }
    
    self.alpha = 0.6;
}

- (void)startflicker {
    if (!_timer) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(RepeatAnimation) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(RepeatAnimation)];
        [_timer setFrameInterval:60.f];
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)RepeatAnimation {
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.alpha = 0.3;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5
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
    UITouch *touch = [touches anyObject];
    /**
     *  判断点击的位置是不是在CGPath所绘的区域内
     */
    if (CGPathContainsPoint(pathRef, NULL, [touch locationInView:self], NO)) {
//        if (_handleTouch) {
//            _handleTouch();
//        }
        __strong id target = _target;
        if (target && [target respondsToSelector:_action]) {
            [target performSelectorOnMainThread:_action withObject:_para waitUntilDone:YES];
        }
    }else {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }    
}

- (id)initWithFrame:(CGRect)frame Scale:(CGFloat)scale Points:(NSString *)pointString Target:(id)target Action:(SEL)action Parameter:(id)para {
    frame = [self adjustFrame:frame with:scale];
    if (self = [super initWithFrame:frame]) {
        [self setUserInteractionEnabled:YES];
        _scale = scale;
        _target = target;
        _action = action;
        _para = para;
        [self setPointsWith:pointString];
    }
    return self;
}

+ (instancetype)createCoverviewWithFrame:(CGRect)frame Scale:(CGFloat)scale Points:(NSString *)pointString Target:(id)target Action:(SEL)action Parameter:(id)para{
    return [[CoverView alloc] initWithFrame:frame Scale:scale Points:pointString Target:target Action:action Parameter:para];
}

- (void)removeFromSuperview {
//    [_timer invalidate];
    [_timer removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    _timer = nil;
    CGPathRelease(pathRef);
    [super removeFromSuperview];
}

- (void)dealloc {
    [_timer removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    _timer = nil;
    _para = nil;
}

@end
