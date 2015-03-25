//
//  Window.h
//  Pods
//
//  Created by 李伟超 on 15/3/25.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

@interface Window : NSManagedObject

@property (nonatomic, retain) NSString * wd_name;
@property (nonatomic, retain) Department *department;

@end
