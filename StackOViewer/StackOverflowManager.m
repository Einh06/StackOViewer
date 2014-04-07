//
//  StackOverflowManager.m
//  StackOViewer
//
//  Created by Florian Morel on 03/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "Topic.h"
#import "Question.h"

NSString * const StackOverflowManagerError = @"StackOverflowManagerError";

@implementation StackOverflowManager

@synthesize delegate = _delegate;
@synthesize questionBuilder = _questionBuilder;

- (void)setDelegate:(id<StackOverflowManagerDelegate>)delegate
{
    if (delegate && ![delegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                reason:@"The delegate does not implement the protocol StackOverflowManagerDelegate"
                               userInfo:nil] raise];
    }
    _delegate = delegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic
{
    [self.communicator searchForQuestionsWithTags:topic.tag];
}

- (void)searchForQuestionsFailedWithError:(NSError *)error
{
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)receivedQuestionsJSON:(NSString *)JSONString
{
    NSError *error;
    NSArray *questionsArray = [self.questionBuilder questionsFromJSON:JSONString
                                                                error:&error];
    if (!questionsArray) {
        [self tellDelegateAboutQuestionSearchError:error];
        return;
    }
    
    [self.delegate didReceiveQuestions:questionsArray];
}

- (void)tellDelegateAboutQuestionSearchError:(NSError *)underlyingError
{
    NSDictionary *userInfo = nil;
    if (underlyingError) {
        userInfo = @{NSUnderlyingErrorKey : underlyingError};
    }
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError
                                                   code:StackOverflowManagerErrorQuestionFetching
                                               userInfo:userInfo];
    [self.delegate fetchingFailedwithError:reportableError];

}

- (void)fetchBodyForQuestion:(Question *)question
{
    [self.communicator searchBodyForQuestionID:question.questionID];
}

- (void)fetchingBodyForQuestionsFailedWithError:(NSError *)error
{
    NSDictionary *userInfo = nil;
    if (error) {
        userInfo = @{NSUnderlyingErrorKey : error};
    }
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError
                                                   code:StackOverflowManagerErrorQuestionBodyFetching
                                               userInfo:userInfo];
    [self.delegate fetchingFailedwithError:reportableError];
}

- (void)receivedQuestionBodyJSON:(NSString *)jsonString
{
    NSError *error;
    NSString *questionBody = [self.questionBuilder questionBodyWithJSONString:jsonString error:&error];
    [self.delegate didReceiveQuestionBody:questionBody];
}

@end
