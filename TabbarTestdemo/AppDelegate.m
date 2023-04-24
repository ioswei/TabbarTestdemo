//
//  AppDelegate.m
//  TabbarTestdemo
//
//  Created by Mini001 on 2023/4/24.
//

#import "AppDelegate.h"
#import "AWCustomTabBar.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //控制器数组
    NSArray *controllerArray = @[@"ViewController",@"MsgViewController",@"FriendViewController",@"MineViewController"];
    //title数组
    NSArray * titleArray = @[@"首页",@"消息",@"朋友",@"我的"];
    //默认图片数组
    NSArray *imageArray= @[@"home_tabbar",@"msg_tabbar",@"friend_tabbar",@"me_tabbar"];
    //选中图片数组
    NSArray *selImageArray = @[@"home_tabbar_sel",@"msg_tabbar_sel",@"friend_tabbar_sel",@"me_tabbar_sel"];
    //tabBar高度
    CGFloat tabBarHeight = 88.0;
    
    //初始化(height:传nil或<49.0均按49.0处理)
    AWCustomTabBar *tabbar = [[AWCustomTabBar alloc] initWithControllerArray:controllerArray titleArray:titleArray imageArray:imageArray selImageArray:selImageArray height:tabBarHeight];

    //设置为根控制器
    self.window.rootViewController = tabbar;
    
    //设置数字角标(可选)
    [tabbar showBadgeMark:100 index:1];
    //设置小红点(可选)
    [tabbar showPointMarkIndex:2];
    //不显示角标(可选)
    //[tabbar hideMarkIndex:3];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
