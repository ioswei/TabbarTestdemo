//
//  AWCustomTabBar.h
//  AWnewsDoTabBarExample
//
//  Created by iOS_awei on 15-4-8.
//  Copyright © 2023年 iOS_awei. All rights reserved.

#import <UIKit/UIKit.h>

@interface AWCustomTabBarButton : UIButton

@end

@class AWCustomTabBar;
@protocol AWCustomTabBarDelegate <NSObject>
@optional

/**
 tabBar 点击事件回调

 @param tabBar   tabBar
 @param viewController 选中的viewController
 */
- (void)awTabBar:(AWCustomTabBar *)tabBar didSelectViewController:(UIViewController *)viewController;

@end

@interface AWCustomTabBar : UITabBarController

@property(nonatomic,assign) id<AWCustomTabBarDelegate>awTabBarDelegate;


/**
 *  初始化
 *
 *  @param controllerArray 控制器数组
 *  @param titleArray      标题数组
 *  @param imageArray      图片数组
 *  @param selImageArray   选中图片数组
 *  @param height          tabBar 高度(传nil或<49.0均按49.0处理))
 *
 *  @return self
 */
- (instancetype)initWithControllerArray:(NSArray *)controllerArray titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray selImageArray:(NSArray *)selImageArray height:(CGFloat )height;

/*
 隐藏TabBar 调用系统方法
 VC.hidesBottomBarWhenPushed = YES;
 */

/**
 *  设置tabBar显示指定控制器
 *
 *  @param index 位置
 */
- (void)showControllerIndex:(NSInteger)index;

/**
 *  数字角标
 *
 *  @param num   所要显示数字
 *  @param index 位置
 */
- (void)showBadgeMark:(NSInteger)badge index:(NSInteger)index;

/**
 *  小红点
 *
 *  @param index 位置
 */
- (void)showPointMarkIndex:(NSInteger)index;

/**
 *  影藏指定位置角标
 *
 *  @param index 位置
 */
- (void)hideMarkIndex:(NSInteger)index;

@end
