//
//  PopTableViewController.h
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/25.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectCell)(id);

@interface PopTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) BOOL    isShow;
@property (nonatomic, retain) UITableView   *tableView;
@property (nonatomic, retain) NSArray       *dataArray;
@property (nonatomic, retain) NSString      *headerTitle;

@property (nonatomic, copy) DidSelectCell selectCell;

- (void)showInView:(UIView *)view;
- (void)dismiss;

@end
