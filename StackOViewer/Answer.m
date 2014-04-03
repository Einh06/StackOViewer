//
//  Answer.m
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "Answer.h"

@implementation Answer
@synthesize text = _text, score = _score, person = _person, accepted = _accepted;

- (NSComparisonResult)compare:(Answer *)otherAnswer
{
    if (self.accepted) return NSOrderedAscending;
    if (otherAnswer.accepted) return NSOrderedDescending;
    
    if (self.score > otherAnswer.score) {
        
        return NSOrderedAscending;
        
    } else if (self.score < otherAnswer.score) {
        
        return NSOrderedDescending;
        
    }
    
    return NSOrderedSame;
}

- (BOOL)isAccepted
{
    return _accepted;
}

@end
