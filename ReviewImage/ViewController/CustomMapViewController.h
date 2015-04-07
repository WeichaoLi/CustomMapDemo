//
//  ReviewImageViewController.h
//  ReviewImage
//
//  Created by 李伟超 on 14-10-27.
//  Copyright (c) 2014年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchController.h"
#import "BaseView.h"

@class DetailView;
@class CoverView;

typedef NS_ENUM(NSUInteger, SearchType){
    SearchKeyword = 0,
    SearchDepartment = 1,
    SearchWindow,
};

typedef NS_ENUM(NSInteger, ImageOrientation) {
    ImageOrientationPortrait = UIInterfaceOrientationPortrait,
    ImageOrientationLandScapeLeft = UIInterfaceOrientationLandscapeLeft,
    ImageOrientationLandScapeRight = UIInterfaceOrientationLandscapeRight,
    ImageOrientationPortraitUpsideDown = UIInterfaceOrientationPortraitUpsideDown,
};

@interface UIScrollView (TouchesEvent)

@end

@interface CustomMapViewController : UIViewController<UIGestureRecognizerDelegate, UIScrollViewDelegate, UITextFieldDelegate, TouchBaseViewDelegate> {
    CGFloat initalScale;
    CGFloat currentScale;
    UILabel *promptLable;  //提示
    NSString *ImageTracePath;
    NSTimer *_timer;    
    NSMutableArray *_typeArray;
    CGRect showFrame;
}

@property (nonatomic, copy)     NSString            *entityName;

@property (nonatomic, readonly) UIScrollView        *scrollView;
@property (nonatomic, retain) NSString              *ImageURL;
@property (nonatomic, retain) UIImageView           *imageView;
@property (nonatomic, assign) ImageOrientation      imageOrientation;
@property (nonatomic, assign) SearchType            searchType;
@property (nonatomic, retain) UIView                *containerView;
@property (nonatomic, retain) BaseView              *showView;
@property (nonatomic, retain) NSMutableArray        *showArray;
@property (nonatomic ,retain) UIButton              *buttonWindow;
@property (nonatomic ,retain) UIButton              *buttonDepartment;
@property (nonatomic ,retain) UITextField           *txtSearchKey;
@property (nonatomic, retain) DetailView            *infoView;


@property (nonatomic, retain) FetchController *fetchController;

@end
