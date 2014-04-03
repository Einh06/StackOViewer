//
//  AnswerTests.m
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Answer.h"

@interface AnswerTests : XCTestCase
{
    Answer *answer;
    Answer *otherAnswer;
}
@end

@implementation AnswerTests

- (void)setUp
{
    [super setUp];
    answer = [[Answer alloc] init];
    answer.text = @"Some Text in answer";
    answer.person = [[Person alloc] initWithName:@"Jose" imageLocation:@"jose-image"];
    answer.score = 42;
    
    otherAnswer = [[Answer alloc] init];
    otherAnswer.text = @"Some different text in answer";
    otherAnswer.score = 42;
}

- (void)tearDown
{
    answer = nil;
    otherAnswer = nil;
    [super tearDown];
}

- (void)testAcceptedAnswerShouldComeFirst
{
    otherAnswer.accepted = YES;
    otherAnswer.score = answer.score - 10;
    
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending, @"Accepted answer should come first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending, @"Unaccepted answer should come last");
}

- (void)testAnswerWithSameScoreCompareEquality
{
    otherAnswer.score = answer.score;
    
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedSame, @"Both answer of equal rank");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedSame, @"Each answer has the same ranking");
}

- (void)testAnswerWithHigherScroreComesFirst
{
    otherAnswer.score = answer.score - 10;
    
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedAscending, @"Higher score comes first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedDescending, @"Lower score comes last");
}

- (void)testAnswerHasSomeText
{
    XCTAssertEqualObjects(answer.text, @"Some Text in answer", @"The answer should have some text");
}

- (void)testSomeoneProvideTheAnswer
{
    XCTAssertTrue([answer.person isKindOfClass:[Person class]], @"A person should be provided");
}

- (void)testAnswerHasScore
{
    XCTAssertEqual(answer.score, (NSUInteger)42, @"A answer should have a score");
}

- (void)testAnswerIsNotAccpetedByDefault
{
    XCTAssertFalse(answer.accepted, @"Answer not accepted by default");
}

- (void)testAnswerCanBeAccepted
{
    XCTAssertNoThrow(answer.accepted = YES, @"Answer can be accepted");
}

@end
