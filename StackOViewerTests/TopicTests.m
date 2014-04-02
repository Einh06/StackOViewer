//
//  TopicTests.m
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Topic.h"
#import "Question.h"
@interface TopicTests : XCTestCase
{
    Topic *topic;
}
@end

@implementation TopicTests

- (void)setUp
{
    [super setUp];
    topic = [[Topic alloc] initWithName:@"TopicName"
                                    tag:@"TheTag"];
}

- (void)tearDown
{
    topic = nil;
    [super tearDown];
}

- (void)testThatTopicExists
{
    XCTAssertNotNil(topic, @"we should be able to create a topic instance");
}

- (void)testThatTopicCanBeNamed
{
    XCTAssertEqualObjects(topic.name, @"TopicName", @"The name should be the same as the one I gave to it");
}

- (void)testThatTopicHasTags
{
    XCTAssertEqualObjects(topic.tag, @"TheTag", @"topics need to have a tag");
}

- (void)testShouldProvideAListOfRecentQuestion
{
    XCTAssertTrue([[topic recentQuestions] isKindOfClass:[NSArray class]], @"topic should provide a list of recent question");
}

- (void)testForInitiallyEmptyQuestionList
{
    XCTAssertEqual([[topic recentQuestions] count], (NSUInteger)0, @"The recent question list should be empty");
}

- (void)testForAddingAQuestionInTheList
{
    Question *question = [[Question alloc] init];
    [topic addQuestion:question];
    XCTAssertEqual([[topic recentQuestions] count], (NSUInteger)1, @"the recent question");
}

- (void)testQuestionAreListedChronologically
{
    Question *q1 = [[Question alloc] init];
    q1.date = [NSDate distantPast];
    
    Question *q2 = [[Question alloc] init];
    q2.date = [NSDate distantFuture];
    
    [topic addQuestion:q1];
    [topic addQuestion:q2];
    
    NSArray *questions = [topic recentQuestions];
    Question *firstQuestion = questions[0];
    Question *secondQuestion = questions[1];
    
    XCTAssertEqualObjects([firstQuestion.date laterDate:secondQuestion.date], firstQuestion.date, @"The recent question should be listed chronologically");
}

- (void)testQuestionsListCountIsNotOverTwenty
{
    Question *q = [[Question alloc] init];
    for (int i = 0; i < 25; i++) {
        
        [topic addQuestion:q];
    }
    
    XCTAssertTrue([[topic recentQuestions] count] < 21, @"Recent question list should not be over 20");
}

@end
