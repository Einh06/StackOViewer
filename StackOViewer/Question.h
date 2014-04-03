//
//  Question.h
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;

@interface Question : NSObject

@property   NSDate *date;
@property   NSString *title;
@property   NSInteger score;

- (void)addAnswer:(Answer *)answer;
- (NSArray *)answersList;

@end
