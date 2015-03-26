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

@property (nonatomic, retain) NSString * dp_name;
@property (nonatomic, retain) NSString * dp_frame;
@property (nonatomic, retain) NSNumber * dp_id;
@property (nonatomic, retain) NSString * dp_info;
@property (nonatomic, retain) NSString * dp_points;
@property (nonatomic, retain) NSSet *windows;
@property (nonatomic, retain) NSSet *rooms;
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
