//
//  QuestionCreationTests.m
//  StackOViewer
//
//  Created by Florian Morel on 03/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Topic.h"
#import "Question.h"
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockStackOverflowCommunicator.h"
#import "FakeQuestionBuilder.h"

@interface QuestionCreationWorkflowTests : XCTestCase
{
    StackOverflowManager *mgr;
    MockStackOverflowManagerDelegate *delegate;
    MockStackOverflowCommunicator *communicator;
    FakeQuestionBuilder *fakeQuestionBuilder;
    Question *questionToFetch;
    NSArray *questionsArray;
    NSError *underlyingError;
}
@end

@implementation QuestionCreationWorkflowTests

- (void)setUp
{
    [super setUp];
    
    communicator = [[MockStackOverflowCommunicator alloc] init];

    mgr = [[StackOverflowManager alloc] init];
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    fakeQuestionBuilder = [[FakeQuestionBuilder alloc] init];
    mgr.questionBuilder = fakeQuestionBuilder;
    mgr.delegate = delegate;
    mgr.communicator = communicator;
    underlyingError = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
    
    Question *question = [[Question alloc] init];
    questionsArray = [NSArray arrayWithObject:question];
    
    questionToFetch = [[Question alloc] init];
    questionToFetch.questionID = 1234;
}

- (void)tearDown
{
    mgr = nil;
    delegate = nil;
    underlyingError = nil;
    communicator = nil;
    fakeQuestionBuilder = nil;
    questionToFetch = nil;
    [super tearDown];
}

- (void)testNonConformingObjectCannotBeDelagate
{
    XCTAssertThrows(mgr.delegate = (id<StackOverflowManagerDelegate>)[NSNull null], @"NSNull should not be used as delegate as it does not conform the StackOverflowManagerDelegate protocol");
}

- (void)testConfirmingObjectCanBeDelegate
{
    XCTAssertNoThrow(mgr.delegate = delegate, @"Confirming object can be delegate");
}

- (void)testDelegateCanBeNil
{
    XCTAssertNoThrow(mgr.delegate = nil, @"Delegate can be nil");
}

- (void)testAskingForQuestionsMeansRequestForData
{
    mgr.communicator = communicator;
    Topic *topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [mgr fetchQuestionsOnTopic:topic];
    XCTAssertTrue([communicator wasAskedForQuestions], @"The Communicator should have asked for question");
}

- (void)testErrorReturnedByManagerIsNotErrorNotifiedByCommunicator
{
    [mgr searchForQuestionsFailedWithError:underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentUnderlyingError
{
    [mgr searchForQuestionsFailedWithError:underlyingError];
    NSError *delegateError = [delegate fetchError];
    XCTAssertEqualObjects(underlyingError, [delegateError userInfo][NSUnderlyingErrorKey], @"Error should be at the correct level of abstraction");

}

- (void)testQuestionJSONIsPassedToQuestionBuilder
{
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqual(fakeQuestionBuilder.JSON, @"Fake JSON", @"the builder should receive the JSON");
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFailes
{
    fakeQuestionBuilder.arrayToReturn = nil;
    fakeQuestionBuilder.errorToSet = underlyingError;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNotNil([[delegate fetchError] userInfo][NSUnderlyingErrorKey], @"The delegate should have been notified about the error");
}

- (void)testDelegateNotToldAboutErrorWhenQuestionsReceived
{
    fakeQuestionBuilder.arrayToReturn = questionsArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNil([delegate fetchError], @"Delegate should not be told about an error when questions are received");
}

- (void)testDelegateReceivesTheQuestionDiscoveredByManager
{
    fakeQuestionBuilder.arrayToReturn = questionsArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects(questionsArray, [delegate receivedQuestions], @"The delgate should receiver questions from manager");
}

- (void)testEmptyArrayPassedToDelegate
{
    fakeQuestionBuilder.arrayToReturn = [NSArray array];
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], [NSArray array], @"Receive Emtpy array is not an error");
}

- (void)testAskingForQuestionBodyMeansRequestingData
{
    [mgr fetchBodyForQuestion:questionToFetch];
    XCTAssertTrue([communicator wasAskedForQuestionBody], @"The communicator should be asked to fetch the question body");
}

- (void)testDelegateNotifiedOfFailureToFetchQuestion
{
    [mgr fetchingBodyForQuestionsFailedWithError:underlyingError];
    XCTAssertNotNil([[delegate fetchError] userInfo][NSUnderlyingErrorKey], @"Delegate should have found about the error");
}

- (void)testManagerPassesRetrivedQuestionBodyToQuestionBuilder
{
    [mgr receivedQuestionBodyJSON:@"Fake JSON"];
    XCTAssertEqualObjects(fakeQuestionBuilder.JSON, @"Fake JSON", @"the builder shoud have received JSON");
}

- (void)testManagerPassesQuestionItWasSentToQuestionBuilder
{
    [mgr fetchBodyForQuestion:questionToFetch];
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects(fakeQuestionBuilder.questionToFill, questionToFetch, @"The question should have been passed to the builder");
}



@end
