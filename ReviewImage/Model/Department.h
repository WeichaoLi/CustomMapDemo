//
//  Department.h
//  Pods
//
//  Created by 李伟超 on 15/3/25.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Window;

@interface Department : NSManagedObject

@property (nonatomic, retain) NSString * dp_department;
@property (nonatomic, retain) NSString * dp_info;
@property (nonatomic, retain) NSString * dp_frame;
@property (nonatomic, retain) NSString * dp_points;
@property (nonatomic, retain) NSNumber * dp_id;
@property (nonatomic, retain) NSString * dp_room;
@property (nonatomic, retain) NSSet *windows;
@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addWindowsObject:(Window *)value;
- (void)removeWindowsObject:(Window *)value;
- (void)addWindows:(NSSet *)values;
- (void)removeWindows:(NSSet *)values;

@end
