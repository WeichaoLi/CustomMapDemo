//
//  LWCViewController.h
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/24.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchController.h"

@interface LWCViewController : UIViewController<UIGestureRecognizerDelegate>

@property (assign, nonatomic) IBOutlet UITextField *x;
@property (assign, nonatomic) IBOutlet UITextField *y;
@property (assign, nonatomic) IBOutlet UITextField *w;
@property (assign, nonatomic) IBOutlet UITextField *h;
@property (assign, nonatomic) IBOutlet UITextField *department;
@property (assign, nonatomic) IBOutlet UITextField *window;
@property (assign, nonatomic) IBOutlet UITextField *detail;

@property (nonatomic, strong) FetchController *fetchController;

- (IBAction)ClickButton:(id)sender;
@end
