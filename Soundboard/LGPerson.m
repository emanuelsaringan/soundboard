//
//  LGPerson.m
//  Soundboard
//
//  Created by Macbook Air on 11/20/13.
//  Copyright (c) 2013 Emanuel Saringan. All rights reserved.
//

#import "LGPerson.h"

@implementation LGPerson

-(NSMutableArray*) sounds {
    if (!_sounds) {
        _sounds = [[NSMutableArray alloc] init];
    }
    
    return _sounds;
}

@end
