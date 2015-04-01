//
//  BaseView.m
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/31.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "BaseView.h"

#define BUTTON_WIDTH    25
#define BUTTON_HEIGHT   48

@implementation BaseView {
    
}

- (id)init {
    if (self = [super init]) {
        self.initalscale = 1;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(touchViewWithBegin:withEvents:)]) {
        [_delegate touchViewWithBegin:touches withEvents:event];
    }else {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    id hitView = [super hitTest:point withEvent:event];
//    NSLog(@"baseVIew:=== %@",hitView);
//    return hitView;
//}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.subviews.count) {
        if (_scale>0 && _initalscale != _scale) {
            for (id view in self.subviews) {
                if ([view isMemberOfClass:[CustomButton class]]) {
                    CustomButton *button = (CustomButton *)view;                    
                    double temp = (double)_initalscale/(double)_scale;
                    
                    CGRect frame = button.frame;
                    
                    CGPoint center = button.center;
                    
                    frame.size.width *= temp;
                    frame.size.height *= temp;
                    button.frame = frame;
                    
                    CGFloat Y = frame.size.height*(1-temp)/temp/2;
                    center.y += Y;
                    
                    button.center = center;
                }
            }
            _initalscale = _scale;
        }
    }
}

- (void)dealloc {
    _delegate = nil;
}

- (void)createButtonAtPoint:(CGPoint)point Scale:(CGFloat)scale WithPara:(id)para {
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(point.x * scale - BUTTON_WIDTH/2, point.y * scale - BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [button setBackgroundImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setPara:para];
    
    [self addSubview:button];
}

- (void)clickButton:(id)sender {
    NSLog(@"===========");
    CustomButton *button = (CustomButton *)sender;
    if (_delegate && [_delegate respondsToSelector:@selector(touchButton:)]) {
        [_delegate touchButton:button.para];
    }
}

@end

@implementation CustomButton

- (void)removeFromSuperview {
    _para = nil;
    [super removeFromSuperview];
}

@end
