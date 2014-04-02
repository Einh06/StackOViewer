//
//  Person.m
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize avatarImageUrl = _avatarImageUrl;
@synthesize avatarName = _avatarName;

- (instancetype)initWithName:(NSString *)name imageLocation:(NSString *)location
{
    self = [super init];
    if (self) {
        
        _avatarName = name;
        _avatarImageUrl = [NSURL URLWithString:location];
    }
    return self;
}

@end
