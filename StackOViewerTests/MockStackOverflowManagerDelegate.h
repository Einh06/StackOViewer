//
//  MockStackOverflowManagerDelegate.h
//  StackOViewer
//
//  Created by Florian Morel on 03/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManager.h"

@interface MockStackOverflowManagerDelegate : NSObject <StackOverflowManagerDelegate>

@property (nonatomic, strong) NSError *fetchError;
@property (nonatomic, strong) NSArray *receivedQuestions;

@end
