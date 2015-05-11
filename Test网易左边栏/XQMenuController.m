//
//  XQMenuController.m
//  Test网易左边栏
//
//  Created by SunSet on 15-5-11.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import "XQMenuController.h"

typedef void (^AASResponderEndBlock)(NSSet *touches);
@interface AASResponderView : UIView

// 结束响应block
@property(nonatomic, copy) AASResponderEndBlock touchBlock;

@end

@interface XQMenuController ()
{
    __weak UIView *_leftView;                       //左侧视图
    __weak UIView *_surfaceView;                    //浮层视图
    
    
    BOOL _allowBeginScroll;                         //从左侧开始触摸的话 是否允许左侧视图滑动
    
    BOOL _isLeftViewExists;                         //左侧视图是否已存在
}
@end

@implementation XQMenuController

- (void)dealloc
{
    [self.leftViewController removeFromParentViewController];
    [self.mainViewController removeFromParentViewController];
    self.leftViewController = nil;
    self.mainViewController = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithLeftViewController:(UIViewController *)leftViewController
              mainViewController:(UIViewController *)mainViewController
{
    if (self = [super init]) {
        
        _leftViewController = leftViewController;
        _mainViewController = mainViewController;
        
        // 添加视图
        UIView *mainView = mainViewController.view;
        mainView.frame = self.view.bounds;
        [self.view addSubview:mainView];
        
        // 左侧视图
        CGFloat heigth = [UIScreen mainScreen].bounds.size.height;
        UIView *leftView = leftViewController.view;
        leftView.frame = CGRectMake(-AASLeftViewControllerWidth,0, AASLeftViewControllerWidth, heigth);
        [self.view addSubview:leftView];
        _leftView = leftView;
        
        //添加子控制器
        [self addChildViewController:leftViewController];
        [self addChildViewController:mainViewController];
        
        //滑动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
        [self.view addGestureRecognizer:pan];
    }
    return self;
}


#pragma mark - 隐藏视图
// 显示左侧视图
- (void)showLeftView
{
    [UIView animateWithDuration:0.25 animations:^{
        _leftView.frame = CGRectMake(0, 0, _leftView.frame.size.width, _leftView.frame.size.height);
        _surfaceView.alpha = 0.5;
    }];
    
    _isLeftViewExists = YES;
}


//显示右侧视图
- (void)hideLeftView
{
    [UIView animateWithDuration:0.25 animations:^{
        _leftView.frame = CGRectMake(-_leftView.frame.size.width, 0, _leftView.frame.size.width, _leftView.frame.size.height);
        _surfaceView.alpha = 0;
    }];
    
    _isLeftViewExists = NO;
}



#pragma mark - 手势方法
- (void)panGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint transtion = [gestureRecognizer translationInView:gestureRecognizer.view];
    
    CGPoint currentPoint = [gestureRecognizer locationInView:gestureRecognizer.view];
    
    // 优化
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:         //开始的时候
            
            //两种情况允许滑动--左侧视图未展示从左侧开始和左侧视图展示从右侧开始
            if ((currentPoint.x <= 50 && !_isLeftViewExists) || (_isLeftViewExists && transtion.x < 0 && currentPoint.x >= self.view.frame.size.width/2)) {
                _allowBeginScroll = YES;
                
                //建立浮层视图
                if (_surfaceView == nil) {
                    AASResponderView *surfaceView = [[AASResponderView alloc]initWithFrame:self.view.bounds];
                    surfaceView.backgroundColor = [UIColor lightGrayColor];
                    surfaceView.alpha = 0;
                    [self.view insertSubview:surfaceView belowSubview:_leftView];
                    __weak typeof(self) weakself = self;
                    surfaceView.touchBlock = ^(NSSet *touches){
                        [weakself hideLeftView];
                    };
                    _surfaceView = surfaceView;
                }
            }
            break;
        case UIGestureRecognizerStateChanged:       //位置改变的时候
            if (_allowBeginScroll) {
                // 左侧视图允许滑动
                if (_leftView.frame.origin.x <= 0 && _leftView.frame.origin.x+transtion.x <= 0) {
                    
                    // 改变浮层视图
                    _leftView.frame = CGRectMake(_leftView.frame.origin.x+transtion.x, 0, _leftView.frame.size.width, _leftView.frame.size.height);
                    
                    // 改变浮层视图的颜色
                    _surfaceView.alpha = 0.5+(CGFloat)_leftView.frame.origin.x/300;
                }
            }
            break;
            
        case UIGestureRecognizerStateFailed:        //手势失败的时候
            NSLog(@" 手势失败 ");
            [self hideLeftView];
            break;
        case UIGestureRecognizerStateEnded:         //手势结束的时候
            NSLog(@" 手势结束 ");
            
            if (_allowBeginScroll) {
                //如果移动的距离超过最小距离  则直接弹出左侧视图
                //移动的距离超过100 则直接展示左侧视图
                if (_leftView.frame.origin.x > -AASLeftViewControllerWidth/2) {
                    [self showLeftView];
                }
                else{
                    [self hideLeftView];
                }
                
                //在一次滑动结束后 清空状态
                _allowBeginScroll = NO;
            }
            break;
            
        default:
            break;
    }
    
    // 将转化致为0
    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:gestureRecognizer.view];
}





@end




@implementation AASResponderView

- (void)dealloc
{
    self.touchBlock = nil;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@" 点击浮层效果 ");
    _touchBlock(touches);
}

@end







