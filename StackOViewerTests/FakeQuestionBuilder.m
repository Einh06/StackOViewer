//
//  FakeQuestionBuilder.m
//  StackOViewer
//
//  Created by Florian Morel on 04/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "FakeQuestionBuilder.h"
#import "Question.h"

@implementation FakeQuestionBuilder

@synthesize JSON = _JSON;
@synthesize arrayToReturn = _arrayToReturn;
@synthesize errorToSet = _errorToSet;
@synthesize questionToFill = _questionToFill;

- (NSArray *)questionsFromJSON:(NSString *)JSONString
                         error:(NSError *__autoreleasing *)error
{
    self.JSON = JSONString;
    if (error != NULL) {
        *error = _errorToSet;
    }
    return _arrayToReturn;
}

- (NSString *)questionBodyWithJSONString:(NSString *)JSONString error:(NSError *__autoreleasing *)error
{
    self.JSON = JSONString;
    if (error != NULL) {
        *error = _errorToSet;
    }
    return nil;
}

@end
