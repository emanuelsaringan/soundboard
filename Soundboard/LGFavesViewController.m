//
//  LGFavesViewController.m
//  Soundboard
//
//  Created by Macbook Air on 11/23/13.
//  Copyright (c) 2013 Emanuel Saringan. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "LGSound.h"
#import "LGFavesViewController.h"
#import "LGPeopleViewController.h"
#import "LGSoundViewController.h"

@interface LGFavesViewController ()

@property (nonatomic, strong) NSMutableArray* objects;

@end

@implementation LGFavesViewController {
    AVAudioPlayer* player;
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Load faves
    [self.objects removeAllObjects];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *favesFile = [documentsDirectory stringByAppendingPathComponent:@"faves.plist"];
    
    NSMutableArray* favesArr = [NSMutableArray arrayWithContentsOfFile: favesFile];
    NSInteger favesCnt = [favesArr count];
    
    for (NSInteger i = 0; i < favesCnt; i++) {
        NSDictionary* soundDict = [favesArr objectAtIndex:i];
        
        LGSound* sound = [[LGSound alloc] init];
        sound.code = [soundDict objectForKey:@"code"];
        sound.label = [soundDict objectForKey:@"label"];
        
        [self insertNewObject:sound];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) insertNewObject:(LGSound*) object {
    [self.objects addObject:object];
}

-(NSMutableArray*) objects {
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    return _objects;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FaveCell" forIndexPath:indexPath];
    
    LGSound* sound = [self.objects objectAtIndex:indexPath.row];
    cell.textLabel.text = sound.label;
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSString*) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LGSound* sound = [self.objects objectAtIndex:indexPath.row];
    
    NSString* soundFilePath = [[NSBundle mainBundle] pathForResource:sound.code ofType:@"mp3"];
    NSURL* soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    player.volume = 1.0;
    [player play];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadData];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.objects removeObjectAtIndex:indexPath.row];
        
        // Serialize list
        [self serializeFaves];
        
        // Delete the row from the view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}

-(void) serializeFaves {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *favesFile = [documentsDirectory stringByAppendingPathComponent:@"faves.plist"];
    
    //Load the sounds
    NSMutableArray* favesArr = [[NSMutableArray alloc] init];
    
    NSInteger cnt = [self.objects count];
    for (NSInteger i = 0; i < cnt; i++) {
        LGSound* sound = [self.objects objectAtIndex:i];
        NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
        
        [dict setObject:sound.code forKey:@"code"];
        [dict setObject:sound.label forKey:@"label"];
        
        [favesArr addObject:dict];
    }
    
    //Save the array
    [favesArr writeToFile:favesFile atomically:YES];
}

@end
