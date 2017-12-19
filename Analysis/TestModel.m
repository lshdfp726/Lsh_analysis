//
//  TestModel.m
//  Analysis
//
//  Created by lsh726 on 2017/12/18.
//  Copyright © 2017年 liusonghong. All rights reserved.
//

#import "TestModel.h"
#import "NSObject+AnalysisData.h"

@implementation TestModel
+ (NSDictionary *)replaceKey {
    return @{@"subModel" : @"SubModel"};
}
@end


@implementation SubModel
+ (NSDictionary *)replaceKey {
    return @{@"test" : @"Test"};
}
@end
