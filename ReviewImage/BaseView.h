//
//  BaseView.h
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/31.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Touchbutton)(id);
typedef void(^Touchview)(void);

@protocol TouchBaseViewDelegate <NSObject>

@required

- (void)touchViewWithBegin:(NSSet *)touches withEvents:(UIEvent *)event;

@optional

- (void)touchButton:(id)para;

@end

@interface BaseView : UIView

@property (nonatomic, assign) CGFloat initalscale;
@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, assign)   id      delegate;
@property (nonatomic, assign)   CGPoint point;

- (void)createButtonAtPoint:(CGPoint)point Scale:(CGFloat)scale WithPara:(id)para;

@end

@interface CustomButton : UIButton

@property (nonatomic, retain) id para;

@end
