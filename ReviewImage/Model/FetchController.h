//
//  FetchController.h
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/24.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FetchController : NSObject<NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSString *entityName;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initWithEntity:(NSString *)entity;

- (NSArray *)queryDataWithPredicate:(NSPredicate *)predicate InEntity:(NSString *)entity;

@end
