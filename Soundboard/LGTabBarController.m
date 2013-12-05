//
//  LGTabBarController.m
//  Soundboard
//
//  Created by Emanuel Saringan on 12/5/13.
//  Copyright (c) 2013 Emanuel Saringan. All rights reserved.
//

#import "LGTabBarController.h"

@interface LGTabBarController ()

@end

@implementation LGTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.31 green:0.86 blue:1.0 alpha:1.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
