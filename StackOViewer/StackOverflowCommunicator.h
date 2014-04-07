//
//  StackOverflowCommunicator.h
//  StackOViewer
//
//  Created by Florian Morel on 03/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowCommunicator : NSObject

- (void)searchForQuestionsWithTags:(NSString *)tags;
- (void)searchBodyForQuestionID:(NSUInteger)identifier;

@end
