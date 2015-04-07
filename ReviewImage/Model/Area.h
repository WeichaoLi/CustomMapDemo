//
//  Area.h
//  Pods
//
//  Created by 李伟超 on 15/4/7.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Area : NSManagedObject

@property (nonatomic, retain) NSNumber * a_id;
@property (nonatomic, retain) NSString * a_name;
@property (nonatomic, retain) NSNumber * a_type;
@property (nonatomic, retain) NSString * a_number;
@property (nonatomic, retain) NSString * a_floor;
@property (nonatomic, retain) NSNumber * a_originX;
@property (nonatomic, retain) NSNumber * a_originY;
@property (nonatomic, retain) NSNumber * a_endX;
@property (nonatomic, retain) NSNumber * a_endY;
@property (nonatomic, retain) NSString * a_organization;
@property (nonatomic, retain) NSString * a_info;

@end
