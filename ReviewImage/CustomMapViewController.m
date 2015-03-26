//
//  ReviewImageViewController.m
//  ReviewImage
//
//  Created by 李伟超 on 14-10-27.
//  Copyright (c) 2014年 LWC. All rights reserved.
//

#import "CustomMapViewController.h"
#import "SVProgressHUD.h"
#import "KxMenu.h"
#import "LWCViewController.h"
#import "PopTableViewController.h"

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
}

- (void)createUI {
    if (!_buttonDepartment) {
        _buttonDepartment = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_buttonDepartment setFrame:CGRectMake(0, 0, 70, 44)];
        _buttonDepartment.tag = 110;
//        [_buttonDepartment sizeToFit];
        [_buttonDepartment setTitle:@"部门" forState:UIControlStateNormal];
        [_buttonDepartment setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_buttonDepartment addTarget:self action:@selector(ClickButton:Event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!_buttonWindow) {
        _buttonWindow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_buttonWindow setFrame:CGRectMake(0, 0, 70, 44)];
        _buttonWindow.tag = 111;
//        [_buttonWindow sizeToFit];
        [_buttonWindow setTitle:@"窗口" forState:UIControlStateNormal];
        [_buttonWindow setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_buttonWindow addTarget:self action:@selector(ClickButton:Event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *DepartmentBarButton = [[UIBarButtonItem alloc] initWithCustomView:_buttonDepartment];
    UIBarButtonItem *WindowBarButton = [[UIBarButtonItem alloc] initWithCustomView:_buttonWindow];
    self.navigationItem.leftBarButtonItems = @[DepartmentBarButton,WindowBarButton];
    
    if (!_txtSearchKey) {
        _txtSearchKey = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
        _txtSearchKey.delegate = self;
        _txtSearchKey.placeholder = @"输入查询关键词";
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
    _ImageURL = nil;
    _imageView = nil;
    _showView = nil;
    promptLable = nil;
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
        [popTableViewController setSelectCell:^(NSManagedObject *para){
            [weakSelf displayWithPara:para];
        }];
        [self addChildViewController:popTableViewController];
    }    

    if (button.tag == 110) {
        _searchType = SearchDepartment;
        popTableViewController.dataArray = [_fetchController queryDataWithPredicate:nil InEntity:@"Department"];
        popTableViewController.headerTitle = @"请选择部门";
    }
    
    if (button.tag == 111) {
        LWCViewController *lwcVC = [[LWCViewController alloc] init];
        [self.navigationController pushViewController:lwcVC animated:YES];
        return;
        _searchType = SearchWindow;
        popTableViewController.dataArray = [_fetchController queryDataWithPredicate:nil InEntity:@"Window"];
        popTableViewController.headerTitle = @"请选择窗口";
    }
    
    if (!popTableViewController.isShow) {
        [popTableViewController showInView:self.view];
    }else {
        [popTableViewController dismiss];
    }
}

- (void)typeItemClick:(id)sender {
    
}

/**
 *  显示窗口、部门查询结果
 *
 *  @param para 部门或窗口对象
 */
- (void)displayWithPara:(NSManagedObject *)para {
    //清空显示列表
    _showArray = [NSMutableArray array];
    switch (_searchType) {
            
        case SearchDepartment:{
            Department *dept = (Department *)para;
            [_showArray addObject:dept];
            [self showAllView];
        }
        break; 
            
        case SearchWindow:{
            Window *window = (Window *)para;
            [_showArray addObject:window];
            
        }
            break;
            
        default:
            break;
    }
    
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
        _showView = [[UIView alloc] init];
        _showView.backgroundColor = [UIColor clearColor];
        [_containerView insertSubview:_showView aboveSubview:_imageView];
    }
    _showView.frame = _containerView.bounds;
    [_showView layoutSubviews];
    
//    NSString *pointString = @"{0,0}-{0,53}-{60,53}-{60,23}-{170,23}-{170,0}";
//    [self addShowViewWithFrame:CGRectMake(43, 52, 170, 53) Scale:initalScale Points:pointString];
}

- (void)redrawDisplayView {

}

- (void)showAllView {
    [_showView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (_showArray.count) {
        for (NSManagedObject *obj in _showArray) {
            if ([obj isMemberOfClass:[Department class]]) {
                Department *dept = (Department *)obj;
                if (dept.dp_frame.length) {
                    [self addDisplayViewWithFrame:CGRectFromString(dept.dp_frame) Scale:initalScale Points:dept.dp_points];
                }
                NSSet *windows = dept.windows;
                for (Window *win in windows) {
                    if (win.wd_frame.length) {
                        [self addDisplayViewWithFrame:CGRectFromString(win.wd_frame) Scale:initalScale Points:win.wd_points];
                    }
                }
            }
            if ([obj isMemberOfClass:[Window class]]) {
//                Window *win = (Window *)obj;
            }
        }
    }
}

- (void)addDisplayViewWithFrame:(CGRect)frame Scale:(CGFloat)scale Points:(NSString *)pointString {
    
//    CoverView *displayView = [[CoverView alloc] initWithFrame:frame Scale:scale Points:pointString];
//    
//    displayView.backgroundColor = [UIColor clearColor];
//    __weak ReviewImageViewController *weakSelf = self;
//    [displayView setHandleTouch:^{
//        [weakSelf handleTouch];
//    }];
//    [_showView insertSubview:displayView atIndex:0];
//    [displayView startflicker];
    
    CoverView *displayView = [CoverView createCoverviewWithFrame:frame
                                                           Scale:scale
                                                          Points:pointString
                                                          Target:self
                                                          Action:@selector(handleTouch)
                                                       Parameter:nil];
    displayView.backgroundColor = [UIColor clearColor];
    [displayView startflicker];
    [_showView insertSubview:displayView atIndex:0];
    
    [_scrollView zoomToRect:CGRectMake(displayView.center.x, displayView.center.y, 0, 0) animated:YES];
}

#pragma mark - 点击屏幕上的视图触发的事件

- (void)handleTouch {
    if (!_infoView) {
        CGRect frame = self.view.frame;
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 150, frame.size.width, 150)];
        _infoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        _infoView.backgroundColor = [UIColor blackColor];
        _infoView.alpha = 0.7;
        [self.view insertSubview:_infoView aboveSubview:_scrollView];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_txtSearchKey resignFirstResponder];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_infoView];
    if (point.x<0 || point.y <0) {
        [_infoView removeFromSuperview];
        _infoView = nil;
    }
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
}

- (void)resetZoomScale {
    CGFloat Rw = _scrollView.frame.size.width / self.imageView.frame.size.width;
    CGFloat Rh = _scrollView.frame.size.height / self.imageView.frame.size.height;
    
    CGFloat scale = 1;
    
    if (_imageOrientation == ImageOrientationPortrait || _imageOrientation == ImageOrientationPortraitUpsideDown) {
        Rw = MAX(Rw, _imageView.image.size.width / (scale * _scrollView.frame.size.width));
        Rh = MAX(Rh, _imageView.image.size.height / (scale * _scrollView.frame.size.height));
    }else {
        Rw = MAX(Rw, _imageView.image.size.width / (scale * _scrollView.frame.size.height));
        Rh = MAX(Rh, _imageView.image.size.height / (scale * _scrollView.frame.size.width));
    }
    
    _scrollView.contentSize = _imageView.frame.size;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = MAX(MAX(Rw, Rh), 1);
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
        [_scrollView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
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
    CGFloat scale  = currentScale;
    [self imageDidChange];
    _scrollView.zoomScale = scale;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _searchType = SearchKeyword;
    [popTableViewController dismiss];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

@end

@implementation UIScrollView (TouchesEvent)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
