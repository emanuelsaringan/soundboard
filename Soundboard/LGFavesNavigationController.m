//
//  LGFaveNavigationController.m
//  Soundboard
//
//  Created by Macbook Air on 11/23/13.
//  Copyright (c) 2013 Emanuel Saringan. All rights reserved.
//

#import "LGFavesViewController.h"
#import "LGFavesNavigationController.h"

@interface LGFavesNavigationController ()

@end

@implementation LGFavesNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.31 green:0.86 blue:1.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
