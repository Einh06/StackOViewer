//
//  QuestionTests.m
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"
#import "Answer.h"

@interface QuestionTests : XCTestCase
{
    Question *question;
    Answer *lowScoreAnswer;
    Answer *highScoreAnswer;
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
    
    Answer *acceptedAnswer = [[Answer alloc] init];
    acceptedAnswer.accepted = YES;
    acceptedAnswer.score = 1;
    [question addAnswer:acceptedAnswer];
    
    lowScoreAnswer = [[Answer alloc] init];
    lowScoreAnswer.score = -4;
    [question addAnswer:lowScoreAnswer];
    
    highScoreAnswer = [[Answer alloc] init];
    highScoreAnswer.score = 4;
    [question addAnswer:highScoreAnswer];
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

- (void)testQuestionCanHaveAnswerAdded
{
    Answer *answer = [[Answer alloc] init];
    XCTAssertNoThrow([question addAnswer:answer], @"Question can have answer added");
}

- (void)testAcceptedAnswerComesFirst
{
    Answer *firstAnswer = [[question answersList] firstObject];
    XCTAssertTrue([firstAnswer isAccepted], @"Accepted Answer should come first");
}

- (void)testHighScoreComesBeforeLow
{
    NSArray *answersList = [question answersList];
    NSUInteger highScoreIndex = [answersList indexOfObject:highScoreAnswer];
    NSUInteger lowScoreIndex = [answersList indexOfObject:lowScoreAnswer];
    XCTAssertTrue(highScoreIndex < lowScoreIndex, @"High Score answer should come first");
}

@end
