//
//  ViewController.m
//  TabbarTestdemo
//
//  Created by Mini001 on 2023/4/24.
//

#import "ViewController.h"
#import "PushViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Hello Windows";
    
    self.view.backgroundColor = UIColor.orangeColor;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    PushViewController *VC = [[PushViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}


@end
