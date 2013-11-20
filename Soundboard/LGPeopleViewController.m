//
//  LGPeopleViewController.m
//  Soundboard
//
//  Created by Macbook Air on 11/20/13.
//  Copyright (c) 2013 Emanuel Saringan. All rights reserved.
//

#import "LGPeopleViewController.h"
#import "LGPerson.h"
#import "LGSoundViewController.h"

@interface LGPeopleViewController ()

@property (nonatomic, strong) NSMutableArray* objects;
@property LGPerson* selectedPerson;

@end

@implementation LGPeopleViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Load people from plist
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"people" ofType:@"plist"];
    NSArray* people = [NSArray arrayWithContentsOfFile:bundle];
    NSInteger cnt = [people count];
    for (NSInteger i = 0; i < cnt; i++) {
        NSDictionary* personDict = [people objectAtIndex:i];
        
        LGPerson* person = [[LGPerson alloc] init];
        person.code = [personDict objectForKey:@"code"];
        person.name = [personDict objectForKey:@"name"];
        
        [self insertNewObject:person];
    }
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
    
    return cell;
}

//-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
////    self.selectedPerson = [self.objects objectAtIndex:indexPath.row];
////    [self performSegueWithIdentifier:@"person_sound" sender:self];
////    NSLog(@"NO");
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"person_sound" isEqualToString:segue.identifier]) {
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedPerson = [self.objects objectAtIndex:indexPath.row];
        
        LGSoundViewController* soundViewController = (LGSoundViewController*)segue.destinationViewController;
        soundViewController.person = self.selectedPerson;
    }
}


@end
