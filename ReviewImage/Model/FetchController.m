//
//  FetchController.m
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/24.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "FetchController.h"
#import "ContextSetup.h"
#import "Department.h"
#import "Window.h"
#import "Room.h"

@implementation FetchController

- (id)initWithEntity:(NSString *)entity {
    if (self = [super init]) {
        [self setEntityName:entity];
        ContextSetup *contextSetup = [[ContextSetup alloc] initWithStoreURL:[self storeURL] modelURL:[self modelURL]];
        self.managedObjectContext = contextSetup.managedObjectContext;
        [self setFetchedResultsController];
        
//        [self addObserver:self forKeyPath:@"entityName" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"entityName"];
    _entityName = nil;
    _fetchedResultsController = nil;
    _managedObjectContext = nil;
}

/**
 * 设置FetchedResultsController
 */
- (void)setFetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return ;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:_entityName inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    //设置排序，按 key 排序
    NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dp_id" ascending:YES];
    NSArray *sortDescriptors = @[ nameSortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

/**
 *  数据库保存路径
 *
 *  @return 数据库保存路径
 */
- (NSURL*)storeURL {
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    
    NSLog(@"数据库路径----\n\n%@\n\n",[documentsDirectory URLByAppendingPathComponent:@"data/db.sqlite"]);
    [[NSFileManager defaultManager] createDirectoryAtURL:[documentsDirectory URLByAppendingPathComponent:@"data"] withIntermediateDirectories:YES attributes:nil error:nil];
    
    return [documentsDirectory URLByAppendingPathComponent:@"data/db.sqlite"];
    
    //    NSString *path = [[NSArray arrayWithObjects:NSHomeDirectory(), @"Documents", @"data", nil] componentsJoinedByString:@"/"];
    //    NSLog(@"%@",[path stringByAppendingString:@"/db.sqlite"]);
    //    NSLog(@"%@",[NSURL URLWithString:path]);
    //    return [NSURL URLWithString:[path stringByAppendingString:@"/db.sqlite"]];
}

/**
 *  momd文件
 *
 *  @return momd文件
 */
- (NSURL*)modelURL{
    return [[NSBundle mainBundle] URLForResource:@"Plane" withExtension:@"momd"];
}

#pragma mark - 数据库操作
#pragma mark 增
- (void)insertData {
    
}

#pragma mark 删
- (void)deleteData {
    
}

#pragma mark 改
- (void)updateData {
    
}

#pragma mark 查

- (NSArray *)queryDataWithPredicate:(NSPredicate *)predicate InEntity:(NSString *)entityName SortByKey:(NSString *)key {
    if (entityName.length) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        
        if (predicate) {
            [fetchRequest setPredicate:predicate];
        }
        
        NSError *error = nil;
        NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects == nil) {
            return nil;
        }
        
        NSSortDescriptor *sort = nil;
        if (key.length) {
            sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:YES];
        }
        
//        if([entityName isEqualToString:NSStringFromClass([Department class])]) {
//            sort = [NSSortDescriptor sortDescriptorWithKey:@"dp_name" ascending:YES];
//        }
//        if ([entityName isEqualToString:NSStringFromClass([Window class])]) {
//            sort = [NSSortDescriptor sortDescriptorWithKey:@"wd_name" ascending:YES];
//        }

        return [fetchedObjects sortedArrayUsingDescriptors:@[sort]];
    }
    return nil;
}

- (NSArray *)queryDataWithKeywords:(NSString *)keywords InEntitys:(NSDictionary *)entitys SortByKey:(NSString *)key {
    if (keywords.length) {
        @autoreleasepool {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSMutableArray *array = [NSMutableArray array];
            for (NSString *entityName in entitys) {
                NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext];
                [request setEntity:entity];

                NSString *predicateString = [[NSString alloc] init];
                static BOOL sign = NO;
                for (NSString *matchString in [entitys objectForKey:entityName]) {
                    if (sign) {
                        predicateString = [predicateString stringByAppendingString:@" OR "];
                    }
                    predicateString = [predicateString stringByAppendingFormat:@"%@ like[c] '*%@*'",matchString,keywords];
                    
                    sign = YES;
                }
                sign = NO;
                NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
                [request setPredicate:predicate];
                
                if (key) {
                    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:YES];
                    [request setSortDescriptors:@[sort]];
                }                
                
                [array addObjectsFromArray:[_managedObjectContext executeFetchRequest:request error:nil]];
            }
            return array;
        }
    }
    return nil;
}

#pragma mark -- 增加 Undo 支持
//现在，这个功能可以被任何抖动触发，程序将会向 first responder 请求 undo manager，
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (NSUndoManager*)undoManager
{
    return self.managedObjectContext.undoManager;
}


@end
