//
//  NSObject+AnalysisData.m
//  Analysis
//
//  Created by lsh726 on 2017/12/18.
//  Copyright © 2017年 liusonghong. All rights reserved.
//

#import "NSObject+AnalysisData.h"
#import "IsFoundationClass.h"
#import <objc/runtime.h>

@implementation NSObject (AnalysisData)

//解析对象字典数据
+ (id)analysisObj:(NSDictionary *)dic {
    NSAssert(dic != 0, @"字典空");
    NSDictionary *replaceKey = [self replaceKey];
    dic = [[NSDictionary alloc] initWithDictionary:[self analysisReplaceKey:dic]];
    id model = [[self alloc] init];
    NSArray *propertyArray = [self getProperty];
    for (NSString *obj in propertyArray) {
        id value = [dic valueForKey:obj];
        if ([replaceKey.allKeys containsObject:obj]) {//若果存在替换key的情况
            value = [dic valueForKey:replaceKey[obj]];
        }
        if ([value isKindOfClass:[NSDictionary class]]) {//这里解释一下，可能存在model 包含model情况，那么这个被包含的model 其实也是字典对象，那么就还需要解析一层
            if ([self analysisClassProperty:class_getProperty(self, obj.UTF8String)]) {//是foudation的类
                [self analysisObj:value];
            } else {//理解为自定义的类
                Class c = NSClassFromString(obj);
                if ([replaceKey.allKeys containsObject:obj]) {//若果存在替换key的情况
                    c = NSClassFromString(replaceKey[obj]);
                }
                [model setValue:[c analysisObj:value] forKey:obj];//[c analysisObj:value]函数递归!
            }
        } else if ([value isKindOfClass:[NSArray class]]) {
            Class c = NSClassFromString(obj);
            if ([replaceKey.allKeys containsObject:obj]) {//若果存在替换key的情况
                c = NSClassFromString(replaceKey[obj]);
            }
            if (c) [model setValue:[c analysisArray:value] forKey:obj];
        }  else if (value != nil) {
            [model setValue:value forKey:obj];
        }
    }
    return model;
}


//解析对象数组数据
+ (id)analysisArray:(NSArray *)dataArray {
    NSAssert(dataArray.count != 0, @"数据源空");
    NSMutableArray *modelArray = [NSMutableArray array];
    for (id values in dataArray) {
        if ([values isKindOfClass:[NSArray class]]) {
            [self analysisArray:values];//递归
        } else {
            [modelArray addObject:[self analysisObj:values]];
        }
    }
    return modelArray;
}


//获取属性列表
+ (NSArray *)getProperty{
    NSMutableArray *array = [NSMutableArray array];
    unsigned count = 0;
    objc_property_t *p = class_copyPropertyList(self, &count);
    for (NSInteger i = 0; i < count ; i ++) {
        const char *property_char = property_getName(p[i]);
        NSString *property_objc = [NSString stringWithUTF8String:property_char];
        [array addObject:property_objc];
    }
    free(p);
    return [NSArray arrayWithArray:array];
}


//判断属性是自定义的model 还是foudation 的
+ (BOOL)analysisClassProperty:(objc_property_t)p {
    BOOL result = NO;
    const char *c = property_getAttributes(p);
    NSString *attr = [NSString stringWithCString:c encoding:NSUTF8StringEncoding];
    Class cls = NSClassFromString(attr);
    result = [IsFoundationClass isClassFromFoundation:cls];
    return result;
}


//替换key
+ (NSDictionary *)analysisReplaceKey:(NSDictionary *)dic {
    NSDictionary *replaceKey = [self replaceKey];
    if (replaceKey.allKeys.count == 0) {
        return dic;
    }

    NSMutableDictionary *mutableD = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([replaceKey.allKeys containsObject:key]) {
            [mutableD removeObjectForKey:key];
            [mutableD setObject:obj forKey:replaceKey[key]];
        }
    }];
    return mutableD;
}

//避免编译器警告
+ (NSDictionary *)replaceKey {
    return @{};
}
@end
