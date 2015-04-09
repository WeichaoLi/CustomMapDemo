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
#import "Area.h"
#import "GeoSearch.h"

@implementation CustomMapViewController {
    PopTableViewController *popTableViewController;
    
    NSString *initalFloor;
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
        
        initalFloor = @"L1";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _entityName = @"Area";
    self.fetchController = [[FetchController alloc] initWithEntity:_entityName WithSortKey:@"a_id"];
    
    _showArray = [NSMutableArray array];
}

- (void)setFloor:(NSString *)floor {
    if (floor && ![_floor isEqualToString:floor]) {
        
        CATransition *transition = [CATransition animation];
        [transition setDuration:1.f];
        transition.type = kCATransitionFade;
        [_containerView.layer addAnimation:transition forKey:@"changeImage"];
        
        _floor = floor;
        self.imageView.image = nil;
        
        if ([_floor isEqualToString:@"L1"]) {
            [self loadImage:@"groundOne.png"];
        }else {
            [self loadImage:@"groundTwo.png"];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _scrollView.bounds = self.view.bounds;

    if (!_floor) {
        [self setFloor:initalFloor];
    }
    
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
//        [_txtSearchKey sizeToFit];
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
    _floor = nil;
}

- (void)loadView {
    [super loadView];
    
    self.view.clipsToBounds = YES;
    self.view.contentMode = UIViewContentModeScaleAspectFill;
    
    [self createUI];
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
- (void)loadImage:(NSString *)imageName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@""];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:imageData];
    image = [self compressImageWith:image];
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] init];
    }
    [self.imageView setImage:image];
    [self imageDidChange];
}

- (UIImage *)compressImageWith:(UIImage *)image {
    NSLog(@"%@",NSStringFromCGSize(image.size));
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;

//    CGSize size = image.size;
    CGFloat ratio;
//
//    if (_imageOrientation == ImageOrientationPortrait || _imageOrientation == ImageOrientationPortraitUpsideDown) { //判断图片是不是正的
//        ratio = MIN(_scrollView.frame.size.width / size.width, _scrollView.frame.size.height / size.height);
//    }else {
//        ratio = MIN(_scrollView.frame.size.width / size.height, _scrollView.frame.size.height / size.width);
//    }
    
    ratio = 1;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(imageWidth * ratio, imageHeight * ratio));
    
    [image drawInRect:CGRectMake(0, 0, imageWidth * ratio, imageHeight * ratio)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return newImage;
    
}

#pragma mark- 属性设置

- (void)setImageView:(UIImageView *)imageView {
    if(imageView != _imageView){
//        [_imageView removeObserver:self forKeyPath:@"image"];
        [_imageView removeFromSuperview];
        
        _imageView = imageView;
        _imageView.frame = _imageView.bounds;
        
//        [_imageView addObserver:self forKeyPath:@"image" options:0 context:nil];
        
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

    NSPredicate *predicate = nil;
    if (button.tag == 110) {
        _searchType = SearchDepartment;
//        popTableViewController.headerTitle = NSLocalizedString( @"请选择部门", nil);
        predicate = [NSPredicate predicateWithFormat:@"a_type == '1' AND a_number == '0'"];
    }
    
    if (button.tag == 111) {
        _searchType = SearchWindow;
//        popTableViewController.headerTitle = NSLocalizedString(@"请选择窗口", nil);
        predicate = [NSPredicate predicateWithFormat:@"a_type == '3' AND a_number == '0'"];
        
    }
     popTableViewController.dataArray = [_fetchController queryDataWithPredicate:predicate InEntity:_entityName SortByKey:@"a_id"];
    [popTableViewController showInView:self.view];
}

/**
 *  显示窗口、部门查询结果
 *
 *  @param para 部门或窗口对象
 */
- (void)displayWithPara:(id)para {
    NSLog(@"%@",para);
    //清空显示列表
    _showArray = [NSMutableArray array];
    
    Area *area = (Area *)para;
    [self setFloor:area.a_floor];
    if ([area.a_type intValue] == 1) {
        //部门
        [_showArray addObjectsFromArray:[_fetchController queryDataWithPredicate:[NSPredicate predicateWithFormat:@"a_organization == %@",area.a_organization]
                                                                        InEntity:_entityName
                                                                       SortByKey:@"a_id"]];
    }else if ([area.a_type intValue] == 3){
        //窗口
        [_showArray addObject:para];
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
        _showView = [[BaseView alloc] init];
        _showView.backgroundColor = [UIColor clearColor];
        _showView.delegate = self;
        [_containerView insertSubview:_showView aboveSubview:_imageView];
    }
    _showView.frame = _containerView.bounds;
}

- (void)showAllView {
    [_infoView setHidden:YES];
    [_scrollView setZoomScale:_scrollView.minimumZoomScale];
    CGPoint point = CGPointZero;
    [_showView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (_showArray.count) {
        for (Area *area in _showArray) {
            
            CGFloat ox = [area.a_originX floatValue];
            CGFloat oy = [area.a_originY floatValue];
            CGFloat ex = [area.a_endX floatValue];
            CGFloat ey = [area.a_endY floatValue];
            
            point = CGPointMake((ex + ox)/2, (ey + oy)/2);
            
            if ([area.a_type intValue] == 3) {
                //显示窗口按钮
                if (ex && ey) {
//                    [self addDisplayViewWithFrame:CGRectMake(ox, oy, ex - ox, ey - oy) Scale:initalScale Points:nil Parameter:area];
                    [_showView createButtonAtPoint:point Scale:initalScale WithPara:area];
                }
                
            }else if ([area.a_type intValue] == 1) {
                //显示部门区域
                if (ex && ey) {
                    [self addDisplayViewWithFrame:CGRectMake(ox, oy, ex - ox, ey - oy) Scale:initalScale Points:nil Parameter:area];
                }
            }else if ([area.a_type intValue] == 2) {
                
            }
        }
    }
    [_scrollView zoomToRect:[self getRectWithScale:3 andCenter:CGPointMake(point.x * initalScale, point.y * initalScale)] animated:YES];
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
    [self handleTouch:para];
}

- (void)handleTouch:(id)para {
    NSLog(@"%@",para);
    [_infoView setHidden:NO];
    if (!_infoView) {
        CGRect frame = self.view.frame;
        _infoView = [[DetailView alloc] initWithFrame:CGRectMake(0, frame.size.height - 150, frame.size.width, 150)];
        _infoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        _infoView.backgroundColor = [UIColor blackColor];
        _infoView.alpha = 0.7;
        [self.view insertSubview:_infoView aboveSubview:_scrollView];
        [_infoView layoutIfNeeded];
    }
    if (para) {
        Area *area = (Area *)para;
        _infoView.lable_1.text = [NSString stringWithFormat:@"部门名称：%@", area.a_organization];
        if ([area.a_type intValue] == 3) {
            _infoView.lable_2.text = [NSString stringWithFormat:@"窗口号：%@", area.a_name];
        }else if ([area.a_type intValue] == 2) {
            _infoView.lable_2.text = [NSString stringWithFormat:@"房间号：%@", area.a_name];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_txtSearchKey resignFirstResponder];
    UITouch *touch = [touches anyObject];

//    if (_infoView && !_infoView.hidden && ![touch.view isMemberOfClass:[DetailView class]]) {
//        [_infoView setHidden:YES];
//    }else {
//        if ([touch.view isMemberOfClass:[BaseView class]]) {
//            [self geoCoordinateWithPoint:[touch locationInView:_showView]];
//        }
//    }
    
    if (![self geoCoordinateWithPoint:[touch locationInView:_showView]]) {
        if (_infoView && !_infoView.hidden && ![touch.view isMemberOfClass:[DetailView class]]) {
            [_infoView setHidden:YES];
        }
    }
}

#pragma mark - 坐标反查

- (BOOL)geoCoordinateWithPoint:(CGPoint)point {
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:_fetchController.fetchedResultsController.fetchedObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"a_floor == %@", _floor];
    
    array = [NSMutableArray arrayWithArray:[GeoSearch geoCoordinateWithArray:[array filteredArrayUsingPredicate:predicate]
                                                                     AtPoint:point
                                                                   WithScale:initalScale
                                                                      InRect:_showView.bounds]];
    if (array.count) {
        
        NSLog(@"\n\n\n\n ================坐标反查");
        NSLog(@"%@",NSStringFromCGPoint(point));
        
        id para = [array firstObject];
        [self handleTouch:para];
        return YES;
    }
    return NO;
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
    CGPoint touchPoint = [gesture locationInView:_containerView];
    NSLog(@"%@",NSStringFromCGPoint(touchPoint));
    if (_scrollView.zoomScale != _scrollView.minimumZoomScale) {
        [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:YES];
    }else {
        [_scrollView zoomToRect:[self getRectWithScale:3 andCenter:touchPoint] animated:YES];
    }
}

- (CGRect)getRectWithScale:(float)scale andCenter:(CGPoint)center{
    CGRect newRect;
    newRect.size.width=_scrollView.frame.size.width/scale;
    newRect.size.height=_scrollView.frame.size.height/scale;
    newRect.origin.x=center.x-newRect.size.width/2;
    newRect.origin.y=center.y-newRect.size.height/2;
    return newRect;
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
    
    
    NSArray *array = [NSArray arrayWithArray:[_fetchController queryDataWithKeywords:keyWords
                                                                              InEntitys:@{@"Area": @[@"a_name", @"a_organization", @"a_info"]}
                                                                           SortByKey:@{@"Area": @"a_id"}]];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"a_floor == %@", _floor];
//    
//    popTableViewController.dataArray = [array filteredArrayUsingPredicate:predicate];
    popTableViewController.dataArray = array;
//    popTableViewController.headerTitle = NSLocalizedString(@"搜索结果", nil);
    
    if (popTableViewController.dataArray.count) {
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
