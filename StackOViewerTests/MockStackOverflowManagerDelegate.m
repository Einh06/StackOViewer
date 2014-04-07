//
//  MockStackOverflowManagerDelegate.m
//  StackOViewer
//
//  Created by Florian Morel on 03/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate

- (void)fetchingFailedwithError:(NSError *)error
{
    self.fetchError = error;
}

- (void)didReceiveQuestions:(NSArray *)questions
{
    self.receivedQuestions = questions;
}

@end
