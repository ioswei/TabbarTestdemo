//
//  AWCustomTabBar.m
//  AWCustomTabBarExample
//
//  Created by iOS_awei on 23-4-24.
//  Copyright © 2023年 iOS_awei. All rights reserved.

#import "AWCustomTabBar.h"

//RGB颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//title默认颜色
#define TitleColor   [UIColor grayColor]
//title选中颜色
#define TitleColor_Sel  RGBCOLOR(41, 167, 245)
//title字体大小
#define TitleFontSize 12.0
//TabBar背景色
#define TabBarBackgroundColor [UIColor whiteColor]

//数字角标直径
#define NumMark_W_H 20
//小红点直径
#define PointMark_W_H 12


//TabBarButton中 图片与文字上下所占比
static const float scale=0.55;

#pragma mark-@interface AWCustomTabBarButton
@interface AWCustomTabBarButton()

@end

@implementation AWCustomTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = TabBarBackgroundColor;
    }
    
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat newX = 0;
    CGFloat newY =5;
    CGFloat newWidth = contentRect.size.width;
    CGFloat newHeight = contentRect.size.height*scale-newY;
    return CGRectMake(newX, newY, newWidth, newHeight);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat newX = 0;
    CGFloat newY = contentRect.size.height*scale;
    CGFloat newWidth = contentRect.size.width;
    CGFloat newHeight = contentRect.size.height-contentRect.size.height*scale;
    return CGRectMake(newX, newY, newWidth, newHeight);
}

@end

#pragma mark-@interface AWCustomTabBar
@interface AWCustomTabBar ()
@property(nonatomic,strong)UIButton *seleBtn;
@property(nonatomic,strong)UIView *tabBarView;
@property(nonatomic,assign)CGFloat tabBarHeight;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)NSArray *selImageArray;
@property(nonatomic,strong)NSArray *controllerArray;
@end
@implementation AWCustomTabBar
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initData];
        [self initTabBar];
    }
    return self;
}
- (instancetype)initWithControllerArray:(NSArray *)controllerArray titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray selImageArray:(NSArray *)selImageArray height:(CGFloat )height
{
    self = [super init];
    if (self) {
        
        self.controllerArray =controllerArray;
        self.titleArray = titleArray;
        self.imageArray = imageArray;
        self.selImageArray = selImageArray;
        self.tabBarHeight = height;
        
        [self  initTabBar];
        
    }
    return self;
}
/**
 *  若想外部代码更简洁,可调alloc init 初始化tabbar : AWCustomTabBar *tabbar = [[AWCustomTabBar alloc] init];但必须在这里初始化相关数据,如下:
 */
-(void)initData
{
    /*
    //控制器数组(不需要导入控制器头文件)
    self.controllerArray = @[@"MainVC",@"MsgVC",@"FriendVC",@"MeVC"];
    //title数组
    self.titleArray = @[@"首页",@"消息",@"朋友",@"我的"];
    //默认图片数组
    self.imageArray = @[@"home_tabbar",@"msg_tabbar",@"friend_tabbar",@"me_tabbar"];
    //选中图片数组
    self.selImageArray = @[@"home_tabbar_sel",@"msg_tabbar_sel",@"friend_tabbar_sel",@"me_tabbar_sel"];
    //tabBar高度
    self.tabBarHeight = 49.0;
     */
}

- (void)initTabBar{
 
    //处理tabbar顶部黑线问题
    [self clearBlackLineView];
    //创建VC
    [self createControllerBycontrollerArrayay:self.controllerArray];
    //创建tabBarView
    [self createTabBarView];
    //设置TabbarLine
    [self setTabBarShadowView];
    
}

- (void)clearBlackLineView{
    
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance * appearnce = [UITabBarAppearance new];
        [appearnce configureWithTransparentBackground];
        appearnce.backgroundColor = [UIColor clearColor];
        appearnce.shadowImage = [UIImage new];
        self.tabBar.standardAppearance = appearnce;
        if (@available(iOS 15.0, *)) {
            self.tabBar.scrollEdgeAppearance = appearnce;
        }
    } else {
        self.tabBar.shadowImage = [UIImage new];
        self.tabBar.backgroundImage = [UIImage new];
    }
    
}


- (void)createControllerBycontrollerArrayay:(NSArray *)controllerArrayay
{
    if(controllerArrayay.count==0) NSLog(@"控制器数组为nil,请初始化");
    NSMutableArray *tabBarArr = [[NSMutableArray alloc]init];
    for (NSString *className in controllerArrayay) {
        Class class = NSClassFromString(className);
        UIViewController *viewcontroller = [[class alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
        [tabBarArr addObject:nav];
        
    }
    self.viewControllers = tabBarArr;
}

/// 设置tabbarView圆角
- (void)setTabBarShadowView
{
    self.tabBarView.layer.masksToBounds = NO;
    self.tabBarView.backgroundColor     = [UIColor whiteColor];
    self.tabBarView.layer.shadowColor   = [UIColor blackColor].CGColor;
    self.tabBarView.layer.shadowOffset  = CGSizeMake(0,4);   //0,0围绕阴影四周  0,4向下有4个像素的偏移
    self.tabBarView.layer.shadowOpacity = 0.15;   //设置阴影透明度
    self.tabBarView.layer.shadowRadius  = 5;      //设置阴影圆角
}

- (void)createTabBarView
{
    if(!self.tabBarHeight||self.tabBarHeight<49.0) self.tabBarHeight=49.0;
    
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, [UIScreen mainScreen].bounds.size.width,88.f)];
    self.tabBarView.backgroundColor = UIColor.whiteColor;
    

    if (@available(iOS 11.0, *))
    {
        // 设置 左上 右上 圆角
        self.tabBarView.layer.cornerRadius = 20.f;
        self.tabBarView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    }
    
    [self.tabBar addSubview:self.tabBarView];
    
    if(self.selImageArray.count==0) NSLog(@"选中图片数组为nil,请初始化");
    if(self.imageArray.count==0) NSLog(@"图片数组为nil,请初始化");
    if(self.titleArray.count==0) NSLog(@"title数组为nil,请初始化");

    int num = (int)self.controllerArray.count;
    for(int i=0;i<num;i++)
    {
        float width = [UIScreen mainScreen].bounds.size.width/num*i;
        AWCustomTabBarButton *button = [[AWCustomTabBarButton alloc] initWithFrame:CGRectMake(width + ([UIScreen mainScreen].bounds.size.width/num-44)/2.0, 14, 44, 44)];
        button.tag = 1000+i;
        
        //常态文字颜色
        [button setTitleColor:TitleColor forState:UIControlStateNormal];
        //选中文字颜色
        [button setTitleColor:TitleColor_Sel forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:TitleFontSize];
        [button setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.selImageArray[i]] forState:UIControlStateSelected];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView addSubview:button];
        if (i == 0)
        {
            //默认选中
            button.selected=YES;
            self.seleBtn = button;
        }
        //角标
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.size.width/2.0+6, 3, NumMark_W_H, NumMark_W_H)];
        numLabel.layer.masksToBounds = YES;
        numLabel.layer.cornerRadius = 10;
        numLabel.backgroundColor = [UIColor redColor];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.font = [UIFont systemFontOfSize:13];
        numLabel.tag = 1010+i;
        numLabel.hidden = YES;
        [button addSubview:numLabel];
    }
}

- (void)buttonAction:(UIButton *)button{
    
    NSInteger index = button.tag-1000;
    
    [self showControllerIndex:index];
}

/**
 *  切换显示控制器
 *
 *  @param index 位置
 */
- (void)showControllerIndex:(NSInteger)index
{
    if(index >= self.controllerArray.count)
    {
        NSLog(@"index取值超出范围");
        return;
    }
    
    self.seleBtn.selected = NO;
    UIButton *button = (UIButton *)[self.tabBarView viewWithTag:1000+index];
    button.selected = YES;
    self.seleBtn = button;
    self.selectedIndex=index;
    
    if([self.awTabBarDelegate respondsToSelector:@selector(awTabBar:didSelectViewController:)])
    {
        [self.awTabBarDelegate awTabBar:self didSelectViewController:self.viewControllers[index]];
    }
}

/**
 *  数字角标
 *
 *  @param num   所要显示数字
 *  @param index 位置
 */
- (void)showBadgeMark:(NSInteger)badge index:(NSInteger)index
{
    if(index >= self.controllerArray.count)
    {
        NSLog(@"index取值超出范围");
        return;
    }
    
    UILabel *numLabel = (UILabel *)[self.tabBarView viewWithTag:1010+index];
    numLabel.hidden=NO;
    CGRect nFrame = numLabel.frame;
    if(badge<=0)
    {
        //隐藏角标
        [self hideMarkIndex:index];
    }
    else
    {
        if(badge>0&&badge<=9)
        {
            nFrame.size.width = NumMark_W_H;
        }
        else if (badge>9&&badge<=19)
        {
            nFrame.size.width = NumMark_W_H+5;
        }
        else
        {
            nFrame.size.width = NumMark_W_H+10;
        }
        nFrame.size.height = NumMark_W_H;
        numLabel.frame = nFrame;
        numLabel.layer.cornerRadius = NumMark_W_H/2.0;
        numLabel.text = [NSString stringWithFormat:@"%ld",badge];
        if(badge>99)
        {
            numLabel.text =@"99+";
        }
    }
}

/**
 *  小红点
 *
 *  @param index 位置
 */
-(void)showPointMarkIndex:(NSInteger)index
{
    if(index >= self.controllerArray.count)
    {
        NSLog(@"index取值超出范围");
        return;
    }
    UILabel *numLabel = (UILabel *)[self.tabBarView viewWithTag:1010+index];
    numLabel.hidden=NO;
    CGRect nFrame = numLabel.frame;
    nFrame.size.height=PointMark_W_H;
    nFrame.size.width = PointMark_W_H;
    numLabel.frame = nFrame;
    numLabel.layer.cornerRadius = PointMark_W_H/2.0;
    numLabel.text = @"";
}

/**
 *  影藏指定位置角标
 *
 *  @param index 位置
 */
-(void)hideMarkIndex:(NSInteger)index
{
    if(index >= self.controllerArray.count)
    {
        NSLog(@"index取值超出范围");
        return;
    }
    
    UILabel *numLabel = (UILabel *)[self.tabBarView viewWithTag:1010+index];
    numLabel.hidden = YES;
}
@end
