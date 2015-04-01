//
//  PopTableViewController.m
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/25.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "PopTableViewController.h"

@implementation PopTableViewController {
    UIView *sectionHeader;
    UIView *sectionFooter;
}

#define VIEW_WIDTH      self.view.bounds.size.width
#define VIEW_HEIGHT     self.view.bounds.size.height

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    [bgView setUserInteractionEnabled:NO];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    bgView.alpha = 0.5;
    [self.view addSubview:bgView];
    
    CGRect frame = CGRectMake((VIEW_WIDTH - 220)/2, (VIEW_HEIGHT - 470)/2, 220, 470);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view insertSubview:_tableView aboveSubview:bgView];
    
    UIView *footerView = [[UIView alloc] init];
    [_tableView setTableFooterView:footerView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view removeFromSuperview];
    [self setIsShow:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _tableView = nil;
    _dataArray = nil;
    _headerTitle = nil;
    _selectCell = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    id obj = _dataArray[indexPath.row];
    if ([obj isMemberOfClass:[Department class]]) {
        
        Department *dept = (Department *)obj;
        cell.textLabel.text = dept.dp_name;
        
    }else if ([obj isMemberOfClass:[Window class]]) {
        
        Window *window = (Window *)obj;
        cell.textLabel.text = window.wd_name;
        
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!sectionHeader) {
        sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        sectionHeader.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        sectionHeader.backgroundColor = [UIColor whiteColor];
        
        UILabel *tintLabel = [[UILabel alloc] initWithFrame:sectionHeader.bounds];
        tintLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tintLabel.text = _headerTitle;
        tintLabel.textAlignment = NSTextAlignmentCenter;
        [sectionHeader addSubview:tintLabel];
    }
    return sectionHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectCell) {
        [self dismiss];
        self.selectCell([_dataArray objectAtIndex:indexPath.row]);
    }
}

- (void)showInView:(UIView *)view {
    self.view.frame = view.bounds;
    [view insertSubview:self.view atIndex:10];
    self.isShow = YES;
    sectionHeader = nil;
    [_tableView reloadData];
}

- (void)dismiss {
    [self.view removeFromSuperview];
    self.isShow = NO;
}

@end
