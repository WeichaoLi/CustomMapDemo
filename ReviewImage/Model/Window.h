//
//  Window.h
//  CustomMapDemo
//
//  Created by 李伟超 on 15/4/1.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

@interface Window : NSManagedObject

@property (nonatomic, retain) NSString * wd_info;
@property (nonatomic, retain) NSString * wd_name;
@property (nonatomic, retain) NSString * wd_point;
@property (nonatomic, retain) Department *dept;

@end
