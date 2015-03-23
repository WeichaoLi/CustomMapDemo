//
//  CoverView.h
//  ReviewImage
//
//  Created by 李伟超 on 15/3/19.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HandleTouch)(void);

@interface CoverView : UIView {
    NSTimer *_timer;
}

@property (nonatomic, copy) HandleTouch handleTouch;
@property (nonatomic, copy) NSArray *points;
@property (nonatomic, assign) CGFloat scale;

- (id)initWithFrame:(CGRect)frame Scale:(CGFloat)scale Points:(NSString *)pointString;
- (void)startflicker;

@end
