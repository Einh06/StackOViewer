//
//  Person.m
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTests : XCTestCase
{
    Person *person;
}
@end

@implementation PersonTests

- (void)setUp
{
    [super setUp];
    person = [[Person alloc] initWithName:@"Prince" imageLocation:@"prince-image"];
}

- (void)tearDown
{
    person = nil;
    [super tearDown];
}

- (void)testPersonHasAvatarName
{
    XCTAssertEqualObjects(person.avatarName, @"Prince", @"The person should have a name");
}

- (void)testPersonHasAvatarImageUrl
{
    XCTAssertEqualObjects([person.avatarImageUrl absoluteString], @"prince-image", @"the person should provide the avatar image URL");
}

@end
