//
//  LGSoundViewController.m
//  Soundboard
//
//  Created by Macbook Air on 11/20/13.
//  Copyright (c) 2013 Emanuel Saringan. All rights reserved.
//

#import "LGSoundViewController.h"
#import "LGSound.h"

@interface LGSoundViewController ()

@property (nonatomic, strong) NSMutableArray* objects;

@end

@implementation LGSoundViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"people" ofType:@"plist"];
    NSArray* people = [NSArray arrayWithContentsOfFile:bundle];
    NSInteger peopleCnt = [people count];
    
    for (NSInteger i = 0; i < peopleCnt; i++) {
        NSDictionary* personDict = [people objectAtIndex:i];
        
        if ([self.person.code intValue] == [[personDict objectForKey:@"code"] intValue]) {
            NSArray* sounds = [personDict objectForKey:@"sounds"];
            NSInteger soundsCnt = [sounds count];
            
            for (NSInteger j = 0; j < soundsCnt; j++) {
                LGSound* sound = [[LGSound alloc] init];
                sound.label = [sounds objectAtIndex:j];
                
                [self insertNewObject:sound];
            }
            
            break;
        }
    }
}

-(void) insertNewObject:(LGSound*) sound {
    [self.objects addObject:sound];
}

-(NSMutableArray*) objects {
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    return _objects;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SoundCell" forIndexPath:indexPath];
    
    LGSound* sound = [self.objects objectAtIndex:indexPath.row];
    cell.textLabel.text = sound.label;
    
    return cell;
}

@end
