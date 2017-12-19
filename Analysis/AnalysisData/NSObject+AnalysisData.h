//
//  NSObject+AnalysisData.h
//  Analysis
//
//  Created by lsh726 on 2017/12/18.
//  Copyright © 2017年 liusonghong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (AnalysisData)

//解析对象数据
+ (id)analysisObj:(NSDictionary *)dic;

//解析数组数据
+ (id)analysisArray:(NSArray *)dataArray;

+ (NSDictionary *)replaceKey;//key 替换

//+ (NSDictionary *)containClass;// 数组包含的key
@end
