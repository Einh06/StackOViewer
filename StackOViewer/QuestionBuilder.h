//
//  QuestionBuilder.h
//  StackOViewer
//
//  Created by Florian Morel on 04/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "StackOverflowCommunicator.h"

extern NSString * const QuestionBuilderErrorDomain;


typedef NS_ENUM(NSInteger, QuestionBuilderErrorCode) {
    QuestionBuilderErrorCodeInvalidJSON,
    QuestionBuilderErrorCodeMissingData
};

@interface QuestionBuilder : NSObject

- (NSArray *)questionsFromJSON:(NSString *)JSONString error:(NSError **)error;
- (NSString *)questionBodyWithJSONString:(NSString *)JSONString error:(NSError *__autoreleasing *)error;

@end
