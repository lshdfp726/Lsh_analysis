//
//  IsFoundationClass.m
//  Analysis
//
//  Created by lsh726 on 2017/12/19.
//  Copyright © 2017年 liusonghong. All rights reserved.
//

#import "IsFoundationClass.h"

static NSSet *foundationClasses_;

@implementation IsFoundationClass
//借鉴MJ
+ (BOOL)isClassFromFoundation:(Class)c
{
    if (c == [NSObject class]) return YES;

    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([c isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}


+ (NSSet *)foundationClasses
{
    if (foundationClasses_ == nil) {
        // 集合中没有NSObject，因为几乎所有的类都是继承自NSObject，具体是不是NSObject需要特殊判断
        foundationClasses_ = [NSSet setWithObjects:
                              [NSURL class],
                              [NSDate class],
                              [NSValue class],
                              [NSData class],
                              [NSError class],
                              [NSArray class],
                              [NSDictionary class],
                              [NSString class],
                              [NSAttributedString class], nil];
    }
    return foundationClasses_;
}
@end
