//
//  Question.h
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;
@class Person;
@interface Question : NSObject

@property   NSUInteger questionID;
@property   NSDate *date;
@property   NSString *title;
@property   NSInteger score;
@property   Person *asker;

- (void)addAnswer:(Answer *)answer;
- (NSArray *)answersList;

@end
