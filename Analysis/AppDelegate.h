//
//  AppDelegate.h
//  Analysis
//
//  Created by lsh726 on 2017/12/18.
//  Copyright © 2017年 liusonghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

