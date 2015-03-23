//
//  ReviewImageViewController.m
//  ReviewImage
//
//  Created by 李伟超 on 14-10-27.
//  Copyright (c) 2014年 LWC. All rights reserved.
//

#import "ReviewImageViewController.h"
#import "SVProgressHUD.h"
#import "KxMenu.h"

#define __IPHONE_SYSTEM_VERSION [[UIDevice currentDevice] systemVersion].floatValue
#define IOS7 __IPHONE_SYSTEM_VERSION > 7.0

@implementation ReviewImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!_buttonType) {
        _buttonType = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_buttonType setFrame:CGRectMake(0, 0, 80, 44)];
//        [_buttonType sizeToFit];
        _buttonType.tag = 110;
        [_buttonType setTitle:@"检索类型" forState:UIControlStateNormal];
        [_buttonType setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_buttonType addTarget:self action:@selector(ClickButton:Event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *typeButton  = [[UIBarButtonItem alloc] initWithCustomView:_buttonType];
    self.navigationItem.leftBarButtonItems = @[typeButton];
    
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
    //    self.navigationItem.rightBarButtonItem = keyButtonItem;
    self.navigationItem.rightBarButtonItems = @[keyButtonItem];
}

- (void)ClickButton:(id)sender Event:(UIEvent *)event{
    NSLog(@"点击了按钮");
    [_txtSearchKey resignFirstResponder];
    showFrame = [[event.allTouches anyObject] view].frame;
    showFrame.origin.y = -40;
    if (!_typeArray) {
        _typeArray = [NSMutableArray arrayWithCapacity:1];
        [_typeArray addObject:[KxMenuItem menuItem:@"窗口" image:nil target:self action:@selector(typeItemClick:)]];
        [_typeArray addObject:[KxMenuItem menuItem:@"部门" image:nil target:self action:@selector(typeItemClick:)]];
        [_typeArray addObject:[KxMenuItem menuItem:@"关键字" image:nil target:self action:@selector(typeItemClick:)]];
        
    }
    [KxMenu showMenuInView:self.view fromRect:showFrame menuItems:_typeArray];
    
}

- (void)typeItemClick:(id)sender {
    
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
    _containerView.backgroundColor = [UIColor yellowColor];
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

- (void)loadImage {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"groundOne" ofType:@".jpg"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:imageData];

    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self imageDidChange];
}

#pragma mark- Properties

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

#pragma mark - 当图片改变:例如旋转

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
    
    NSString *pointString = @"{0,0}-{0,53}-{60,53}-{60,23}-{170,23}-{170,0}";
    [self addShowViewWithFrame:CGRectMake(43, 52, 170, 53) Scale:initalScale Points:pointString];
}

- (void)addShowViewWithFrame:(CGRect)frame Scale:(CGFloat)scale Points:(NSString *)pointString {
    [_showView removeFromSuperview];
    _showView = nil;

    if (!_showView) {
        _showView  = [[CoverView alloc] initWithFrame:frame Scale:scale Points:pointString];
        _showView.backgroundColor = [UIColor clearColor];
        __weak ReviewImageViewController *VC = self;
        [_showView setHandleTouch:^{
            [VC handleTouch];
        }];
        [_showView setUserInteractionEnabled:YES];
        [_containerView insertSubview:_showView aboveSubview:_imageView];
        
        [_showView startflicker];
    }
    
    [_scrollView zoomToRect:CGRectMake(_showView.center.x, _showView.center.y, 0, 0) animated:YES];
}

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
    [self.view endEditing:YES];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_infoView];
    if (point.x<0 || point.y <0) {
        [_infoView removeFromSuperview];
        _infoView = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"========== %@", NSStringFromCGRect(self.view.frame));
    _scrollView.bounds = self.view.bounds;
    
    NSLog(@"scrollview.frame:========== %@", NSStringFromCGRect(_scrollView.frame));
    
    [self loadImage];
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
    
    if (scrollView.zoomScale >= scrollView.maximumZoomScale) {
//        [self showPrompt:@"已放大到最大比例"];
    }
    currentScale = scrollView.zoomScale;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"\n");
//    NSLog(@"%@",NSStringFromCGSize(scrollView.contentSize));
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
//    NSLog(@"%@",NSStringFromUIEdgeInsets(scrollView.contentInset));
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.center));
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

- (void)handleTap:(UITapGestureRecognizer *)gesture {

}

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
        [_scrollView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, _scrollView.maximumZoomScale, _scrollView.maximumZoomScale) animated:YES];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

#pragma mark prompt

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
}

#pragma mark - Rotation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    CGFloat scale  = currentScale;
    [self imageDidChange];
    _scrollView.zoomScale = scale;
}

#pragma -
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    NSLog(@"开始搜索");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

}

@end

@implementation UIScrollView (TouchesEvent)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
