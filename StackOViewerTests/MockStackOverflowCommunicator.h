//
//  MockStackOverflowCommunicator.h
//  StackOViewer
//
//  Created by Florian Morel on 03/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator : StackOverflowCommunicator

- (BOOL)wasAskedForQuestions;
- (BOOL)wasAskedForQuestionBody;

@end
