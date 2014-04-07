//
//  FakeQuestionBuilder.h
//  StackOViewer
//
//  Created by Florian Morel on 04/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "QuestionBuilder.h"

@class Question;

@interface FakeQuestionBuilder : QuestionBuilder

@property (nonatomic, copy) NSString *JSON;
@property (nonatomic, copy) NSArray *arrayToReturn;
@property (nonatomic, copy) NSError *errorToSet;
@property (nonatomic, strong) Question *questionToFill;

@end
