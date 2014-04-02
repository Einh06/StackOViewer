//
//  QuestionTests.m
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"

@interface QuestionTests : XCTestCase
{
    Question *question;
}
@end

@implementation QuestionTests

- (void)setUp
{
    [super setUp];
    question = [[Question alloc] init];
    question.date = [NSDate distantFuture];
    question.title = @"Title here";
    question.score = 42;
}

- (void)tearDown
{
    question = nil;
    [super tearDown];
}

- (void)testQuestionHasDate
{
    XCTAssertTrue([question.date isKindOfClass:[NSDate class]], @"the question must have a date");
}

- (void)testQuestionHasTitle
{
    XCTAssertEqualObjects(question.title, @"Title here", @"the question should provide a title");
}

- (void)testQuestionKeepScore
{
    XCTAssertEqual(question.score, 42, @"Question should keep score");
}

@end
