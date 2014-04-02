//
//  Person.h
//  StackOViewer
//
//  Created by Florian Morel on 02/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (readonly) NSString *avatarName;
@property (readonly) NSURL *avatarImageUrl;

- (instancetype)initWithName:(NSString *)name imageLocation:(NSString *)location;

@end
