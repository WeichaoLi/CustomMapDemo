//
//  Room.h
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/26.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSString * rm_info;   //房间信息
@property (nonatomic, retain) NSString * rm_name;   //房间名
@property (nonatomic, retain) NSString * rm_frame;  //房间坐标，如：{{45, 53},{268, 145}}，包括原点和大小
@property (nonatomic, retain) Department *dept;     //房间 n ----> 1  部门

@end
