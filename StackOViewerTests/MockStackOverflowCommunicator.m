//
//  MockStackOverflowCommunicator.m
//  StackOViewer
//
//  Created by Florian Morel on 03/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator
{
    BOOL wasAskedForQuestion;
    BOOL wasAskedForQuestionBody;
}

- (BOOL)wasAskedForQuestions
{
    return wasAskedForQuestion;
}

- (void)searchForQuestionsWithTags:(NSString *)tags
{
    wasAskedForQuestion = YES;
}

- (void)searchBodyForQuestionID:(NSUInteger)identifier
{
    wasAskedForQuestionBody = YES;
}

- (BOOL)wasAskedForQuestionBody
{
    return wasAskedForQuestionBody;
}
@end
