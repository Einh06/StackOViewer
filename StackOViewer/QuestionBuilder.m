//
//  QuestionBuilder.m
//  StackOViewer
//
//  Created by Florian Morel on 04/04/14.
//  Copyright (c) 2014 Piraya Mobile. All rights reserved.
//

#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

NSString * const QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";
NSString * const AvatarURLBase = @"http://www.gravatar.com/avatar/";

@implementation QuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)JSONString error:(NSError **)error
{
    NSParameterAssert(JSONString != nil);
    
    NSData *unicodeNotation = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    
    NSDictionary *parsedObject = (NSDictionary *)jsonObject;
    
    if (!parsedObject) {
        
        if (error != NULL) {
            
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderErrorCodeInvalidJSON userInfo:@{NSUnderlyingErrorKey : localError}];
        }
        return nil;
    }
    NSArray *questions = parsedObject[@"questions"];
    if (!questions) {
        
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderErrorCodeMissingData userInfo:nil];
        }
        return nil;
    }
    NSMutableArray *finalQuestionsArray = [NSMutableArray array];
    for (NSDictionary *questionDic in questions) {
        
        Question *question = [[Question alloc] init];
        question.questionID = [questionDic[@"question_id"] integerValue];
        question.score = [questionDic[@"score"] integerValue];
        question.date = [NSDate dateWithTimeIntervalSince1970:[questionDic[@"creation_date"] doubleValue]];
        question.title = questionDic[@"title"];
        
        NSDictionary *ownerInfo = questionDic[@"owner"];
        question.asker = [[Person alloc] initWithName:ownerInfo[@"display_name"]
                                        imageLocation:[NSString stringWithFormat:@"%@%@",AvatarURLBase,ownerInfo[@"email_hash"]]];
        
        [finalQuestionsArray addObject:question];
    }
    
    return [NSArray arrayWithArray:finalQuestionsArray];
}

- (NSString *)questionBodyWithJSONString:JSONString error:(NSError **)error
{
    return nil;
}

@end
