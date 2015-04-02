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

@property (nonatomic, retain) NSString * wd_info;   //窗口信息
@property (nonatomic, retain) NSString * wd_name;   //窗口名称
@property (nonatomic, retain) NSString * wd_point;  //窗口位置，如：{x,y}
@property (nonatomic, retain) Department *dept;     //窗口 n -----> 1  部门

@end
