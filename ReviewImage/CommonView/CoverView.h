//
//  CoverView.h
//  ReviewImage
//
//  Created by 李伟超 on 15/3/19.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HandleTouch)(void);

@interface CoverView : UIView

@property (nonatomic, retain) id para;
@property (nonatomic, copy) HandleTouch handleTouch;
@property (nonatomic, copy) NSArray *points;
@property (nonatomic, assign) CGFloat scale;
@property (readwrite, nonatomic, weak) id target;
@property (readwrite, nonatomic) SEL action;

- (id)initWithFrame:(CGRect)frame Scale:(CGFloat)scale Points:(NSString *)pointString;
- (void)startflicker;

+ (instancetype)createCoverviewWithFrame:(CGRect)frame
                           Scale:(CGFloat)scale
                          Points:(NSString *)pointString
                          Target:(id)target
                          Action:(SEL)action
                       Parameter:(id)para;

@end
