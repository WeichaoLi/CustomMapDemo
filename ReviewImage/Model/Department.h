//
//  Department.h
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/26.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Room, Window;

@interface Department : NSManagedObject

@property (nonatomic, retain) NSString * dp_name;   //部门名称
@property (nonatomic, retain) NSString * dp_frame;  //部门坐标1，必须有，格式如：{{45, 53},{268, 145}}， {45, 53}表示区域的原点，{268, 145}表示区域的大小
@property (nonatomic, retain) NSNumber * dp_id;     //从服务器取数据时的标志
@property (nonatomic, retain) NSString * dp_info;   //部门信息
@property (nonatomic, retain) NSString * dp_points; //部门坐标2，可以有，格式如：{0,0}-{0,147}-{60,147}-{60,23}-{270,23}-{270,0}，以“ - ”分割点{x,y},至少要有3个点
@property (nonatomic, retain) NSSet *windows;       //部门  1————>n  窗口
@property (nonatomic, retain) NSSet *rooms;         //部门  1————>n  房间
@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addWindowsObject:(Window *)value;
- (void)removeWindowsObject:(Window *)value;
- (void)addWindows:(NSSet *)values;
- (void)removeWindows:(NSSet *)values;

- (void)addRoomsObject:(Room *)value;
- (void)removeRoomsObject:(Room *)value;
- (void)addRooms:(NSSet *)values;
- (void)removeRooms:(NSSet *)values;

@end
