//
//  ReviewImageViewController.h
//  ReviewImage
//
//  Created by 李伟超 on 14-10-27.
//  Copyright (c) 2014年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchController.h"
#import "CoverView.h"

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

@interface CustomMapViewController : UIViewController<UIGestureRecognizerDelegate, UIScrollViewDelegate, UITextFieldDelegate> {
    CGFloat initalScale;
    CGFloat currentScale;
    UILabel *promptLable;  //提示
    NSString *ImageTracePath;
    NSTimer *_timer;    
    NSMutableArray *_typeArray;
    CGRect showFrame;
}

@property (nonatomic, readonly) UIScrollView        *scrollView;
@property (nonatomic, retain) NSString              *entityName;
@property (nonatomic, strong) NSString              *ImageURL;
@property (nonatomic, strong) UIImageView           *imageView;
@property (nonatomic, assign) ImageOrientation      imageOrientation;
@property (nonatomic, assign) SearchType            searchType;
@property (nonatomic, retain) UIView                *containerView;
@property (nonatomic, retain) UIView                *showView;
@property (nonatomic, retain) NSMutableArray        *showArray;
@property (nonatomic ,retain) UIButton              *buttonWindow;
@property (nonatomic ,retain) UIButton              *buttonDepartment;
@property (nonatomic ,retain) UITextField           *txtSearchKey;
@property (nonatomic, retain) UIView                *infoView;


@property (nonatomic, retain) FetchController *fetchController;

@end
