//
//  ReviewImageViewController.h
//  ReviewImage
//
//  Created by 李伟超 on 14-10-27.
//  Copyright (c) 2014年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverView.h"

typedef NS_ENUM(NSInteger, ImageOrientation) {
    ImageOrientationPortrait = UIInterfaceOrientationPortrait,
    ImageOrientationLandScapeLeft = UIInterfaceOrientationLandscapeLeft,
    ImageOrientationLandScapeRight = UIInterfaceOrientationLandscapeRight,
    ImageOrientationPortraitUpsideDown = UIInterfaceOrientationPortraitUpsideDown,
};

@interface UIScrollView (TouchesEvent)

@end

@interface ReviewImageViewController : UIViewController<UIGestureRecognizerDelegate, UIScrollViewDelegate, UITextFieldDelegate> {
    CGFloat initalScale;
    CGFloat currentScale;
    UILabel *promptLable;  //提示
    NSString *ImageTracePath;
    NSTimer *_timer;    
    NSMutableArray *_typeArray;
    CGRect showFrame;
}

@property (nonatomic, readonly) UIScrollView        *scrollView;
@property (nonatomic, strong) NSString              *ImageURL;
@property (nonatomic, strong) UIImageView           *imageView;
@property (nonatomic, assign) ImageOrientation      imageOrientation;
@property (nonatomic, retain) UIView                *containerView;
@property (nonatomic, retain) CoverView             *showView;
@property (nonatomic ,retain) UIButton              *buttonType;
@property (nonatomic ,retain) UIButton              *buttonDepartment;
@property (nonatomic ,retain) UITextField           *txtSearchKey;
@property (nonatomic, retain) UIView                *infoView;

@end
