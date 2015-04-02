//
//  ReviewImageViewController.m
//  ReviewImage
//
//  Created by 李伟超 on 14-10-27.
//  Copyright (c) 2014年 LWC. All rights reserved.
//

#import "CustomMapViewController.h"
#import "SVProgressHUD.h"
#import "LWCViewController.h"
#import "PopTableViewController.h"
#import "CoverView.h"
#import "DetailView.h"
#import "Department.h"
#import "Room.h"
#import "Window.h"

@implementation CustomMapViewController {
    PopTableViewController *popTableViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
#ifdef __IPHONE_7_0
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
            self.navigationController.navigationBar.translucent = NO;
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
#endif
        
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"BG_navBar"] forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    _entityName = @"Department";
    self.fetchController = [[FetchController alloc] initWithEntity:_entityName];
    _showArray = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _scrollView.bounds = self.view.bounds;
    [self loadImage];
    
//    LWCViewController *lwcVC = [[LWCViewController alloc] init];
//    [self.navigationController pushViewController:lwcVC animated:YES];
}

- (void)createUI {
    if (!_buttonDepartment) {
        _buttonDepartment = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_buttonDepartment setFrame:CGRectMake(0, 0, 70, 44)];
        _buttonDepartment.tag = 110;
//        [_buttonDepartment sizeToFit];
        [_buttonDepartment setTitle:NSLocalizedString(@"部门", nil) forState:UIControlStateNormal];
        [_buttonDepartment setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_buttonDepartment addTarget:self action:@selector(ClickButton:Event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!_buttonWindow) {
        _buttonWindow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_buttonWindow setFrame:CGRectMake(0, 0, 70, 44)];
        _buttonWindow.tag = 111;
//        [_buttonWindow sizeToFit];
        [_buttonWindow setTitle:NSLocalizedString(@"窗口", nil) forState:UIControlStateNormal];
        [_buttonWindow setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_buttonWindow addTarget:self action:@selector(ClickButton:Event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *DepartmentBarButton = [[UIBarButtonItem alloc] initWithCustomView:_buttonDepartment];
    UIBarButtonItem *WindowBarButton = [[UIBarButtonItem alloc] initWithCustomView:_buttonWindow];
    self.navigationItem.leftBarButtonItems = @[DepartmentBarButton,WindowBarButton];
    
    if (!_txtSearchKey) {
        _txtSearchKey = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
        _txtSearchKey.delegate = self;
        _txtSearchKey.placeholder = NSLocalizedString(@"输入查询关键词", nil);
        [_txtSearchKey sizeToFit];
        _txtSearchKey.font = [UIFont systemFontOfSize:14];
        _txtSearchKey.returnKeyType = UIReturnKeySearch;
        _txtSearchKey.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _txtSearchKey.borderStyle = UITextBorderStyleNone;
    }
    
    UIBarButtonItem *keyButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_txtSearchKey];
    self.navigationItem.rightBarButtonItems = @[keyButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _scrollView = nil;
    _entityName = nil;
    _ImageURL = nil;
    _imageView = nil;
    _showView = nil;
    promptLable = nil;
    _buttonWindow = nil;
    _buttonDepartment = nil;
    _containerView = nil;
    _infoView = nil;
    _showArray = nil;
}

- (void)loadView {
    [super loadView];
    
    self.view.clipsToBounds = YES;
    self.view.contentMode = UIViewContentModeScaleAspectFill;
    
    /****************************scrollview***************************/
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView setUserInteractionEnabled:YES];
    _scrollView.decelerationRate = 0.1f;
    _scrollView.delegate = self;
    
    _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    _containerView.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_containerView];
    
    [self.view addSubview:_scrollView];
    
    /****************************手势***************************/
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delegate = self;
    doubleTap.delaysTouchesBegan = YES;
    [_containerView addGestureRecognizer:doubleTap];
    
    /****************************初始化***************************/
    
    _imageOrientation = ImageOrientationPortrait;
}

/**
 *  加载图片
 */
- (void)loadImage {
    if (_imageView == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"groundOne" ofType:@".jpg"];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:imageData];
        self.imageView = [[UIImageView alloc] initWithImage:image];
        [self imageDidChange];
    }
}

#pragma mark- 属性设置

- (void)setImageView:(UIImageView *)imageView {
    if(imageView != _imageView){
        [_imageView removeObserver:self forKeyPath:@"image"];
        [_imageView removeFromSuperview];
        
        _imageView = imageView;
        _imageView.frame = _imageView.bounds;
        
        [_imageView addObserver:self forKeyPath:@"image" options:0 context:nil];
        
        [_containerView insertSubview:_imageView atIndex:0];
        
        _scrollView.zoomScale = 1;
        _scrollView.contentOffset = CGPointZero;
        _containerView.bounds = _imageView.bounds;
        
        [self resetZoomScale];
        _scrollView.zoomScale  = _scrollView.minimumZoomScale;
        [self scrollViewDidZoom:_scrollView];
    }
}

/**
 *  导航栏按钮点击事件
 */
- (void)ClickButton:(id)sender Event:(UIEvent *)event{
    
    [_txtSearchKey resignFirstResponder];

    UIButton *button = (UIButton *)sender;
    
    if (!popTableViewController) {
        popTableViewController = [[PopTableViewController alloc] init];
        [popTableViewController setIsShow:NO];
        
        __weak CustomMapViewController *weakSelf = self;
        [popTableViewController setSelectCell:^(id para){
            [weakSelf displayWithPara:para];
        }];
        [self addChildViewController:popTableViewController];
    }    

    if (button.tag == 110) {
        _searchType = SearchDepartment;
        popTableViewController.dataArray = [_fetchController queryDataWithPredicate:nil InEntity:@"Department" SortByKey:@"dp_name"];
        popTableViewController.headerTitle = NSLocalizedString( @"请选择部门", nil);
    }
    
    if (button.tag == 111) {
        _searchType = SearchWindow;
        popTableViewController.dataArray = [_fetchController queryDataWithPredicate:nil InEntity:@"Window" SortByKey:@"wd_name"];
        popTableViewController.headerTitle = NSLocalizedString(@"请选择窗口", nil);
    }
    
    [popTableViewController showInView:self.view];
}

/**
 *  显示窗口、部门查询结果
 *
 *  @param para 部门或窗口对象
 */
- (void)displayWithPara:(id)para {
    //清空显示列表
    _showArray = [NSMutableArray array];
    
    if(para) {
        [_showArray addObject:para];
    }
//    switch (_searchType) {
//            
//        case SearchDepartment:{
//            Department *dept = (Department *)para;
//            [_showArray addObject:dept];
//        }
//            break;
//            
//        case SearchWindow:{
//            Window *window = (Window *)para;
//            [_showArray addObject:window];
//            
//        }
//            break;
//        case SearchKeyword:{
//            Room *room = (Room *)para;
//            [_showArray addObject:room];
//        }
//            break;
//            
//        default:
//            break;
//    }
    
    //在图上显示查询结果
    [self showAllView];
}

#pragma mark - 当图片改变或例如旋转

- (void)imageDidChange {
        
    CGSize size = (self.imageView.image) ? self.imageView.image.size : self.view.bounds.size;
    CGFloat ratio;
    
    if (_imageOrientation == ImageOrientationPortrait || _imageOrientation == ImageOrientationPortraitUpsideDown) { //判断图片是不是正的
        ratio = MIN(_scrollView.frame.size.width / size.width, _scrollView.frame.size.height / size.height);
    }else {
        ratio = MIN(_scrollView.frame.size.width / size.height, _scrollView.frame.size.height / size.width);
    }    
    initalScale = ratio;
    CGFloat W = ratio * size.width;
    CGFloat H = ratio * size.height;
    self.imageView.frame = CGRectMake(0, 0, W, H);

    _scrollView.zoomScale = 1;
    _scrollView.contentOffset = CGPointZero;
    _containerView.bounds = _imageView.bounds;

    [self resetZoomScale];
    _scrollView.zoomScale  = _scrollView.minimumZoomScale;
    [self scrollViewDidZoom:_scrollView];
    
    _imageView.frame = _containerView.bounds;
    
    if (_showView == nil) {
        _showView = [[BaseView alloc] init];
        _showView.backgroundColor = [UIColor clearColor];
        _showView.delegate = self;
        [_containerView insertSubview:_showView aboveSubview:_imageView];
    }
    _showView.frame = _containerView.bounds;
}

- (void)showAllView {
//    [_infoView setHidden:YES];
    [_scrollView setZoomScale:_scrollView.minimumZoomScale];
    CGPoint point = CGPointZero;
    [_showView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (_showArray.count) {
        for (id obj in _showArray) {
            if ([obj isMemberOfClass:[Department class]]) {
                Department *dept = (Department *)obj;
                if (dept.dp_frame.length) {
                    point = CGPointMake(CGRectGetMaxX(CGRectFromString(dept.dp_frame)), CGRectGetMidY(CGRectFromString(dept.dp_frame)));
                    [self addDisplayViewWithFrame:CGRectFromString(dept.dp_frame) Scale:initalScale Points:dept.dp_points Parameter:dept];
                }
                NSSet *windows = dept.windows;
                for (Window *window in windows) {
                    if (window.wd_point.length) {
                        point = CGPointFromString(window.wd_point);
                        [_showView createButtonAtPoint:CGPointFromString(window.wd_point) Scale:initalScale WithPara:window];
                    }
                }
            }
            if ([obj isMemberOfClass:[Window class]]) {
                Window *window = (Window *)obj;
                if (window.wd_point.length) {
                    point = CGPointFromString(window.wd_point);
                    [_showView createButtonAtPoint:CGPointFromString(window.wd_point) Scale:initalScale WithPara:window];
                }
            }
            if ([obj isMemberOfClass:[Room class]]) {
                Room *room = (Room *)obj;
                if (room.rm_frame.length) {
                    point = CGPointMake(CGRectGetMaxX(CGRectFromString(room.rm_frame)), CGRectGetMidY(CGRectFromString(room.rm_frame)));
                    [self addDisplayViewWithFrame:CGRectFromString(room.rm_frame) Scale:initalScale Points:nil Parameter:room];
                }
            }
        }
    }
    [_scrollView zoomToRect:CGRectMake(point.x*initalScale, point.y*initalScale, 10, 10) animated:YES];
}

- (void)addDisplayViewWithFrame:(CGRect)frame Scale:(CGFloat)scale Points:(NSString *)pointString Parameter:(id)para {
    CoverView *displayView = [CoverView createCoverviewWithFrame:frame
                                                           Scale:scale
                                                          Points:pointString
                                                          Target:self
                                                          Action:@selector(handleTouch:)
                                                       Parameter:para];
    displayView.backgroundColor = [UIColor clearColor];
    [displayView startflicker];
    [_showView insertSubview:displayView atIndex:10];
}

#pragma mark - 点击屏幕上的视图触发的事件

#pragma mark 点击图标按钮

- (void)touchButton:(id)para {
    NSLog(@"%@",para);
    [self handleTouch:para];
}

- (void)handleTouch:(id)para {
    if (!_infoView) {
        CGRect frame = self.view.frame;
        _infoView = [[DetailView alloc] initWithFrame:CGRectMake(0, frame.size.height - 150, frame.size.width, 150)];
        _infoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        _infoView.backgroundColor = [UIColor blackColor];
        _infoView.alpha = 0.7;
        [self.view insertSubview:_infoView aboveSubview:_scrollView];
        [_infoView layoutIfNeeded];
    }    
    [_infoView setHidden:NO];
    if (para) {
        if ([para isMemberOfClass:[Department class]]) {
            Department *dept = (Department *)para;
            _infoView.lable_1.text = dept.dp_name;
            _infoView.lable_2.text = dept.dp_info;
        }
        if ([para isMemberOfClass:[Window class]]) {
            Window *window = (Window *)para;
            _infoView.lable_1.text = window.wd_name;
            _infoView.lable_2.text = window.wd_info;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_txtSearchKey resignFirstResponder];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_infoView];
    if (point.x<0 || point.y <0) {
        [_infoView setHidden:YES];
    }
//    if (_infoView.hidden) {
//        [_infoView setHidden:NO];
//    }else {
//        [_infoView setHidden:YES];
//    }
}

#pragma mark- Scrollview delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _containerView.frame.size.width;
    CGFloat H = _containerView.frame.size.height;
    
    CGRect rct = _containerView.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    _containerView.frame = rct;
    
//    if (scrollView.zoomScale >= scrollView.maximumZoomScale) {
//        [self showPrompt:@"已放大到最大比例"];
//    }
    currentScale = scrollView.zoomScale;
    
    _showView.scale = currentScale;
    [_showView layoutSubviews];
}

- (void)resetZoomScale {
//    CGFloat Rw = _scrollView.frame.size.width / self.imageView.frame.size.width;
//    CGFloat Rh = _scrollView.frame.size.height / self.imageView.frame.size.height;
//    
//    CGFloat scale = 1;
    
//    if (_imageOrientation == ImageOrientationPortrait || _imageOrientation == ImageOrientationPortraitUpsideDown) {
//        Rw = MAX(Rw, _imageView.image.size.width / (scale * _scrollView.frame.size.width));
//        Rh = MAX(Rh, _imageView.image.size.height / (scale * _scrollView.frame.size.height));
//    }else {
//        Rw = MAX(Rw, _imageView.image.size.width / (scale * _scrollView.frame.size.height));
//        Rh = MAX(Rh, _imageView.image.size.height / (scale * _scrollView.frame.size.width));
//    }

    _scrollView.contentSize = _imageView.frame.size;
    _scrollView.minimumZoomScale = 1;
//    _scrollView.maximumZoomScale = MAX(MAX(Rw, Rh), 1);
    _scrollView.maximumZoomScale = 3;
}

#pragma mark - Tap gesture

- (void)didDoubleTap:(UITapGestureRecognizer*)gesture {
    CGPoint touchPoint = [gesture locationInView:_scrollView];
//    if (_scrollView.zoomScale != _scrollView.minimumZoomScale) {
//        [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:YES];
//    }else {
//        [UIView animateWithDuration:0.4f animations:^{
//            [_scrollView setZoomScale:_scrollView.maximumZoomScale animated:NO];
//            CGFloat X = touchPoint.x * _scrollView.maximumZoomScale - _scrollView.contentOffset.x - _scrollView.center.x;
//            CGFloat Y = touchPoint.y * _scrollView.maximumZoomScale - _scrollView.contentOffset.y - _scrollView.center.y;
//            X = X>0?(MIN(X, _scrollView.contentSize.width - _scrollView.frame.size.width)):MAX(X, 0);
//            Y = Y>0?(MIN(Y, _scrollView.contentSize.height - _scrollView.frame.size.height)):MAX(Y, 0);
//            [_scrollView setContentOffset:CGPointMake(X, Y)];
//        }completion:^(BOOL finished){
//            
//        }];
//    }
    if (_scrollView.zoomScale != _scrollView.minimumZoomScale) {
        [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:YES];
    }else {
        [_scrollView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 0, 0) animated:YES];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

/*
#pragma mark - 提示视图，例如图片已扩大到最大比例

- (void)showPrompt:(NSString *)message {
    if (promptLable == nil) {
        promptLable = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 180)/2, self.view.frame.size.height - 100, 180, 40)];
        promptLable.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        promptLable.backgroundColor = [UIColor blackColor];
        promptLable.textAlignment = NSTextAlignmentCenter;
        promptLable.textColor = [UIColor whiteColor];
        
        [promptLable.layer setMasksToBounds:YES];
        promptLable.layer.shadowColor = [UIColor blackColor].CGColor;
        promptLable.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        promptLable.layer.shadowOpacity = 3;
        promptLable.layer.shadowRadius = 10.0;
        promptLable.layer.cornerRadius = 20.0;
        
        [self.view insertSubview:promptLable aboveSubview:_scrollView];
    }
    promptLable.hidden = NO;
    promptLable.text = message;
    [self performSelector:@selector(hiddenPrompt) withObject:nil afterDelay:1.5f];
}

- (void)hiddenPrompt {
    promptLable.hidden = YES;
}*/

#pragma mark - Rotation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    CGFloat scale  = currentScale;
    [self imageDidChange];
//    _scrollView.zoomScale = scale;
    if (_showArray.count) {
        [self showAllView];
    }    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!popTableViewController) {
        popTableViewController = [[PopTableViewController alloc] init];
        [popTableViewController setIsShow:NO];
        
        __weak CustomMapViewController *weakSelf = self;
        [popTableViewController setSelectCell:^(id para){
            [weakSelf displayWithPara:para];
        }];
        [self addChildViewController:popTableViewController];
    }
    [popTableViewController dismiss];
    
    
    _searchType = SearchKeyword;
    [popTableViewController dismiss];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField.text.length) {
        [self searchWithKeywords:textField.text];
    }
    return YES;
}

- (void)searchWithKeywords:(NSString *)keyWords {
    
    
    _showArray = [NSMutableArray arrayWithArray:[_fetchController queryDataWithKeywords:keyWords
                                                                              InEntitys:@{@"Department": @[@"dp_name", @"dp_info"],
                                                                                          @"Window": @[@"wd_name", @"wd_info"],
                                                                                          @"Room": @[@"rm_name", @"rm_info"]}
                                                                              SortByKey:nil]];
    
    
    
    popTableViewController.dataArray = _showArray;
//    popTableViewController.headerTitle = NSLocalizedString(@"搜索结果", nil);
    
    if (_showArray.count) {
        [popTableViewController showInView:self.view];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:NSLocalizedString(@"没有搜到该关键字", nil)
                                                       delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles: nil];
        [alert show];
    }
}

@end

@implementation UIScrollView (TouchesEvent)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
