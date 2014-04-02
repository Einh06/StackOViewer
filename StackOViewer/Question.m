//
//  Question.m
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "Question.h"

@implementation Question
@synthesize date = _date;

- (instancetype)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self) {
        
        _date = date;
    }
    return self;
}
@end
