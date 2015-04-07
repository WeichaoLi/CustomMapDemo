//
//  DetailView.m
//  CustomMapDemo
//
//  Created by 李伟超 on 15/4/2.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[UIColor clearColor] setFill];
    UIRectFill(rect);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_lable_1 == nil) {
        _lable_1 = [self createLableWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
        [self addSubview:_lable_1];
    }
    if (_lable_2 == nil) {
        _lable_2 = [self createLableWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.frame), 75)];
        [self addSubview:_lable_2];
    }
    if (_lable_3 == nil) {
        _lable_3 = [self createLableWithFrame:CGRectMake(0, 115, CGRectGetWidth(self.frame), 35)];
        [self addSubview:_lable_3];
    }
}

- (UILabel *)createLableWithFrame:(CGRect)frame {
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [lable setTextColor:[UIColor whiteColor]];
    lable.numberOfLines = 0;
    
    return lable;
}

- (void)dealloc {
    _lable_1 = nil;
    _lable_2 = nil;
    _lable_3 = nil;
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (hidden) {
        _lable_1.text = nil;
        _lable_2.text = nil;
        _lable_3.text = nil;
    }
}

@end
