//
//  QuestionBuilderTests.m
//  StackOViewer
//
//  Created by Florian Morel on 04/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

static NSString *questionJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"questions\": ["
@"{"
@"\"tags\": ["
@"\"iphone\","
@"\"security\","
@"\"keychain\""
@"],"
@"\"answer_count\": 1,"
@"\"accepted_answer_id\": 3231900,"
@"\"favorite_count\": 1,"
@"\"question_timeline_url\": \"/questions/2817980/timeline\","
@"\"question_comments_url\": \"/questions/2817980/comments\","
@"\"question_answers_url\": \"/questions/2817980/answers\","
@"\"question_id\": 2817980,"
@"\"owner\": {"
@"\"user_id\": 23743,"
@"\"user_type\": \"registered\","
@"\"display_name\": \"Graham Lee\","
@"\"reputation\": 13459,"
@"\"email_hash\": \"563290c0c1b776a315b36e863b388a0c\""
@"},"
@"\"creation_date\": 1273660706,"
@"\"last_activity_date\": 1278965736,"
@"\"up_vote_count\": 2,"
@"\"down_vote_count\": 0,"
@"\"view_count\": 465,"
@"\"score\": 2,"
@"\"community_owned\": false,"
@"\"title\": \"Why does Keychain Services return the wrong keychain content?\","
@"\"body\": \"<p>I've been trying to use persistent keychain references.</p>\""
@"}"
@"]"
@"}";

@interface QuestionBuilderTests : XCTestCase
{
    QuestionBuilder *questionBuilder;
    Question *question;
}
@end

@implementation QuestionBuilderTests

- (void)setUp
{
    [super setUp];
    questionBuilder = [[QuestionBuilder alloc] init];
    question = [questionBuilder questionsFromJSON:questionJSON error:NULL][0];
}

- (void)tearDown
{
    questionBuilder = nil;
    [super tearDown];
}

- (void)testThatNilIsNotAnAcceptableParameter
{
    XCTAssertThrows([questionBuilder questionsFromJSON:nil error:NULL], @"Nil parameter for JSON feed is not an acceptable parameter");
}

- (void)testNilReturnsWithErrorWhenStringIsNotJSON
{
    NSError *error;
    XCTAssertNil([questionBuilder questionsFromJSON:@"Fake JSON" error:&error], @"nil should be returned when String is not JSON");
    XCTAssertNotNil(error, @"Error should be notified when string is not JSON");
}

- (void)testPassingNullToErrorDoesNotCrash
{
    XCTAssertNoThrow([questionBuilder questionsFromJSON:@"Fake JSON" error:NULL], @"Pssing NULL to error should not crash is case of error");
}

- (void)testRealJSONWithNoQuestionsReturnsMissingDataError
{
    NSString *jsonString = @"{ \"noquestions\":true}";
    NSError *error;
    XCTAssertNil([questionBuilder questionsFromJSON:jsonString error:&error], @"No questions to parse in this JSON");
    XCTAssertEqual([error code], QuestionBuilderErrorCodeMissingData, @"Missing data error should be returned when data is missing");
}

- (void)testThatJsonWithOneQuestionGiveAnArrayOfOneQuestion
{
    NSError *error;
    NSArray *questionsArray = [questionBuilder questionsFromJSON:questionJSON error:&error];
    XCTAssertEqual([questionsArray count], (NSInteger)1, @"JSON with 1 question should give an array of 1 question");
}

- (void)testQuestionCreatedFromJSONHasPropertiesPresentedInJSON
{
    XCTAssertEqual(question.questionID, 2817980, @"the question ID should match the one from the JSON");
    XCTAssertEqual([question.date timeIntervalSince1970], (NSTimeInterval)1273660706, @"the date should match the one from JSON");
    XCTAssertEqualObjects(question.title, @"Why does Keychain Services return the wrong keychain content?", @"the title should be the same as the JSON");
    XCTAssertEqual(question.score, (NSInteger)2, @"Score should be the same as JSON");
    Person *asker = question.asker;
    XCTAssertEqualObjects(asker.avatarName, @"Graham Lee", @"Name should ne the same as JSON");
    XCTAssertEqualObjects([asker.avatarImageUrl absoluteString], @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c", @"the avatar URL should be based on the supplied email hash");
}

- (void)testQuestionCreatedFromEmptyObjectIsStillValidObject
{
    NSString *emptyQuestion = @"{ \"questions\": [ { } ] }";
    NSArray *questions = [questionBuilder questionsFromJSON:emptyQuestion error:NULL];
    XCTAssertEqual([questions count], (NSInteger)1, @"QuestionBuilder must handle Partial input");
}

@end
