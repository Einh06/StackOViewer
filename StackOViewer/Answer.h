//
//  Answer.h
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Answer : NSObject

@property NSString *text;
@property Person *person;
@property NSInteger score;
@property BOOL accepted;

- (NSComparisonResult)compare:(Answer *)otherAnswer;
- (BOOL)isAccepted;

@end
