//
//  Topic.h
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface Topic : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *tag;

- (instancetype)initWithName:(NSString *)name tag:(NSString *)tag;

- (NSArray *)recentQuestions;
- (void)addQuestion:(Question *)question;

@end
