//
//  StackOverflowManager.h
//  StackOViewer
//
//  Created by Florian Morel on 03/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionBuilder.h"

@class StackOverflowManager;
@class StackOverflowCommunicator;
@class Topic;
@class Question;

extern NSString * const StackOverflowManagerError;

typedef NS_ENUM(NSInteger, StackOverflowManagerErrorCode) {
    StackOverflowManagerErrorQuestionFetching,
    StackOverflowManagerErrorQuestionBodyFetching
};

@protocol StackOverflowManagerDelegate <NSObject>

- (void)fetchingFailedwithError:(NSError *)error;
- (void)didReceiveQuestions:(NSArray *)questions;
- (void)didReceiveQuestionBody:(NSString *)questionBody;

@end

@interface StackOverflowManager : NSObject

@property (nonatomic, weak) id<StackOverflowManagerDelegate> delegate;
@property (nonatomic, strong) StackOverflowCommunicator *communicator;
@property (nonatomic, strong) QuestionBuilder *questionBuilder;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)searchForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)JSONString;

- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchingBodyForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionBodyJSON:(NSString *)jsonString;

@end
