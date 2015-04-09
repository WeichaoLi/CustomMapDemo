//
//  PopTableViewController.m
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/25.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "PopTableViewController.h"
#import "Area.h"
#import "PopViewCell.h"

#define width_scale self.view.bounds.size.width/320
#define height_scale self.view.bounds.size.height/568

@implementation PopTableViewController {
    UIView *sectionHeader;
    UIView *sectionFooter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    [bgView setUserInteractionEnabled:NO];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    bgView.alpha = 0.5;
    [self.view addSubview:bgView];
    
    CGRect frame = CGRectMake((self.view.bounds.size.width - 250*width_scale)/2, (self.view.bounds.size.height - 468*height_scale)/2 - 20, 250*width_scale, 468*height_scale);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view insertSubview:_tableView aboveSubview:bgView];
    
    UIView *footerView = [[UIView alloc] init];
    [_tableView setTableFooterView:footerView];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y + _tableView.frame.size.height, _tableView.frame.size.width, 40)];
    cancelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [cancelButton setBackgroundColor:[UIColor whiteColor]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self drawRect:cancelButton];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:cancelButton aboveSubview:_tableView];
}

- (void)drawRect:(UIView *)view {
//    view.layer.shadowColor = [UIColor blackColor].CGColor;
//    view.layer.shadowOffset = CGSizeMake(0.0, -2.0);
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    view.layer.shadowOpacity = 1;
//    view.layer.shadowRadius = 10.0;
//    view.layer.cornerRadius = 20.0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSLog(@"%@",touch.view);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view removeFromSuperview];
    [self setIsShow:NO];
    _headerTitle = nil;
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
    static BOOL isRegister = NO;
    
    if (!isRegister) {
        UINib *nib = [UINib nibWithNibName:@"PopViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        isRegister = YES;
    }
    PopViewCell *cell = (PopViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    id obj = _dataArray[indexPath.row];
    Area *area = (Area *)obj;
    
    if ([area.a_floor isEqualToString:@"L1"]) {
        cell.labelDetail.text = @"一楼";
    }else {
        cell.labelDetail.text = @"二楼";
    }
    cell.labelName.text = area.a_name;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!sectionHeader && _headerTitle) {
        sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        sectionHeader.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        sectionHeader.backgroundColor = [UIColor whiteColor];
        
        UILabel *tintLabel = [[UILabel alloc] initWithFrame:sectionHeader.bounds];
        tintLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tintLabel.text = _headerTitle;
        tintLabel.textAlignment = NSTextAlignmentCenter;
        [sectionHeader addSubview:tintLabel];
    }else {
        return nil;
    }
    return sectionHeader;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 40)];
//    [cancelButton setBackgroundColor:[UIColor whiteColor]];
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    [self drawRect:cancelButton];
//    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    return cancelButton;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_headerTitle) {
        return 40;
    }
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectCell) {
        [self dismiss];
        self.selectCell([_dataArray objectAtIndex:indexPath.row]);
    }
}

- (void)showInView:(UIView *)view {
    self.view.frame = view.bounds;
    if (!self.isShow) {
        [view insertSubview:self.view atIndex:10];
    }
    self.isShow = YES;
    sectionHeader = nil;
    [_tableView reloadData];
}

- (void)dismiss {
    [self.view removeFromSuperview];
    self.isShow = NO;
    _headerTitle = nil;
}

@end
