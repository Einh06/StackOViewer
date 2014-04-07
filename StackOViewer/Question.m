//
//  Question.m
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "Question.h"
#import "Answer.h"


@implementation Question
{
    NSMutableSet *answersSet;
}
@synthesize date = _date, title = _title, score = _score, questionID = _questionID;



- (instancetype)init
{
    self = [super init];
    if (self) {
        answersSet = [NSMutableSet set];
    }
    return self;
}

- (void)addAnswer:(Answer *)answer
{
    [answersSet addObject:answer];
}

- (NSArray *)answersList
{
    return [[answersSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

@end
