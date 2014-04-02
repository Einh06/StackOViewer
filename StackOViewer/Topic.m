//
//  Topic.m
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "Topic.h"
#import "Question.h"

@implementation Topic
{
    NSArray *questions;
}


@synthesize name = _name;
@synthesize tag = _tag;

- (instancetype)initWithName:(NSString *)name tag:(NSString *)tag
{
    self = [super init];
    if (self) {
        
        _name = name;
        _tag = tag;
        questions = [NSArray array];
    }
    return self;
}

- (NSArray *)recentQuestions
{
    return [self sortedQuestionsArrayLatestFirst:questions];
}

- (void)addQuestion:(Question *)question
{
    NSArray *newQuestions = [questions arrayByAddingObject:question];
    if ([newQuestions count] > 20) {
        
        newQuestions = [self sortedQuestionsArrayLatestFirst:newQuestions];
        newQuestions = [newQuestions subarrayWithRange:NSMakeRange(0, 20)];
    }
    questions = newQuestions;
}

- (NSArray *)sortedQuestionsArrayLatestFirst:(NSArray *)questionArray
{
    return [questionArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Question *q1 = (Question *)obj1;
        Question *q2 = (Question *)obj2;
        return [q2.date compare:q1.date];
    }];
}

@end
