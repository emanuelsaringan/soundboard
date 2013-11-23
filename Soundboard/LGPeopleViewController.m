//
//  LGPeopleViewController.m
//  Soundboard
//
//  Created by Macbook Air on 11/20/13.
//  Copyright (c) 2013 Emanuel Saringan. All rights reserved.
//

#import "LGSound.h"
#import "LGPerson.h"
#import "LGSoundViewController.h"
#import "LGPeopleViewController.h"

@interface LGPeopleViewController ()

@property (nonatomic, strong) NSMutableArray* objects;

@end

@implementation LGPeopleViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Load fave sounds
    static NSString* favesFileName = @"faves.plist";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *favesFile = [documentsDirectory stringByAppendingPathComponent:favesFileName];
    
    NSMutableArray* favesArr = [[NSMutableArray alloc] initWithContentsOfFile: favesFile];
    NSMutableArray* faveCodesArr = [[NSMutableArray alloc] init];
    NSInteger favesArrCnt = [favesArr count];
    for (NSInteger i = 0; i < favesArrCnt; i++) {
        NSDictionary* faveDict = [favesArr objectAtIndex:i];
        [faveCodesArr addObject:[faveDict objectForKey:@"code" ]];
    }
    
    // Load people from plist
    [self.objects removeAllObjects];
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"people" ofType:@"plist"];
    NSArray* people = [NSArray arrayWithContentsOfFile:bundle];
    NSInteger cnt = [people count];
    for (NSInteger i = 0; i < cnt; i++) {
        NSDictionary* personDict = [people objectAtIndex:i];
        
        LGPerson* person = [[LGPerson alloc] init];
        person.name = [personDict objectForKey:@"name"];
        
        // Retrieve sounds
        NSArray* sounds = [personDict objectForKey:@"sounds"];
        NSInteger soundsCnt = [sounds count];
        
        for (NSInteger j = 0; j < soundsCnt; j++) {
            NSDictionary* soundDict = [sounds objectAtIndex:j];
            
            LGSound* sound = [[LGSound alloc] init];
            sound.code = [soundDict objectForKey:@"code"];
            sound.label = [soundDict objectForKey:@"label"];
            sound.isFave = [faveCodesArr containsObject:sound.code];
            
            [person.sounds addObject:sound];
        }
        
        [self insertNewObject:person];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
}

-(void) insertNewObject:(LGPerson*) person {
    [self.objects addObject:person];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
    
    LGPerson* person = [self.objects objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;
    cell.imageView.image = [UIImage imageNamed:@"pic.jpg"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"person_sound" isEqualToString:segue.identifier]) {
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        LGPerson* selectedPerson = [self.objects objectAtIndex:indexPath.row];
        
        LGSoundViewController* soundViewController = (LGSoundViewController*)segue.destinationViewController;
        soundViewController.person = selectedPerson;
    }
}


@end
