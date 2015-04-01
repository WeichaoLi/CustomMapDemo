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

@property (nonatomic, retain) NSString * rm_info;
@property (nonatomic, retain) NSString * rm_name;
@property (nonatomic, retain) NSString * rm_frame;
@property (nonatomic, retain) Department *dept;

@end
