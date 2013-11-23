//
//  LGSoundViewController.m
//  Soundboard
//
//  Created by Macbook Air on 11/20/13.
//  Copyright (c) 2013 Emanuel Saringan. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "LGSoundViewController.h"
#import "LGSound.h"

@interface LGSoundViewController ()

@end

@implementation LGSoundViewController {
    AVAudioPlayer* player;
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.person.sounds count];
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        LGSound* sound = [self.person.sounds objectAtIndex:indexPath.row];
        sound.isFave = YES;
        
        [self saveFaveSound:sound];
    }
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

-(void) saveFaveSound:(LGSound*) sound {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *favesFile = [documentsDirectory stringByAppendingPathComponent:@"faves.plist"];
    
    //Load the sounds
    NSMutableArray* favesArr = [NSMutableArray arrayWithContentsOfFile: favesFile];
    
    if(!favesArr) {
        favesArr = [[NSMutableArray alloc] init];
    }
    
    NSMutableDictionary* soundDict = [[NSMutableDictionary alloc] init];
    [soundDict setObject:sound.code forKey:@"code"];
    [soundDict setObject:sound.label forKey:@"label"];
    
    // Add fave sound code
    [favesArr addObject:soundDict];
    
    //Save the array
    [favesArr writeToFile:favesFile atomically:YES];
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    LGSound* sound = [self.person.sounds objectAtIndex:indexPath.row];
    
    return !sound.isFave;
}

-(NSString*) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    LGSound* sound = [self.person.sounds objectAtIndex:indexPath.row];
    
    if (!sound.isFave) {
        return @"Add to Faves";
    }
    
    // Should not happen
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SoundCell" forIndexPath:indexPath];
    
    LGSound* sound = [self.person.sounds objectAtIndex:indexPath.row];
    cell.textLabel.text = sound.label;
    
    if (sound.isFave) {
        cell.detailTextLabel.text = @"Fave";
    } else {
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LGSound* sound = [self.person.sounds objectAtIndex:indexPath.row];
    
    NSString* soundFilePath = [[NSBundle mainBundle] pathForResource:sound.code ofType:@"mp3"];
    NSURL* soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    player.volume = 1.0;
    [player play];
}

@end
