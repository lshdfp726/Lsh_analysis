//
//  TestModel.h
//  Analysis
//
//  Created by lsh726 on 2017/12/18.
//  Copyright © 2017年 liusonghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubModel: NSObject
@property (nullable, nonatomic, strong) NSString *test;
@end


@interface TestModel : NSObject
@property (nullable, nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL sex;
@property (nonatomic, assign) float height;
@property (nullable, nonatomic, strong) NSString *age;
@property (nullable, nonatomic, strong) NSString *address;
@property (nullable, nonatomic, strong) SubModel *subModel;
//@property (nullable, nonatomic, strong) NSArray  *subModel;
@end



