//
//  LWCViewController.m
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/24.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "LWCViewController.h"
#import "Area.h"

@interface LWCViewController ()

@end

@implementation LWCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _fetchController = [[FetchController alloc] initWithEntity:@"Area" WithSortKey:@"a_id"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    _fetchController = nil;
    [_fetchController release];
    [super dealloc];
}

- (IBAction)ClickButton:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    if (button.tag == 0) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        NSDictionary *dic1 = @{@"a_id": @1,
                               @"a_name":           @"总工会",
                               @"a_organization":   @"总工会",
                               @"a_type":           @1,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @0,
                               @"a_originY":        @0,
                               @"a_endX":           @0,
                               @"a_endY":           @0,
                               };
        [array addObject:dic1];
        NSDictionary *dic2 = @{@"a_id": @2,
                               @"a_name":           @"1",
                               @"a_organization":   @"总工会",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2482.0,
                               @"a_originY":        @1308.0,
                               @"a_endX":           @2538.0,
                               @"a_endY":           @1351.0,
                               };
        [array addObject:dic2];
        NSDictionary *dic3 = @{@"a_id": @3,
                               @"a_name":           @"2",
                               @"a_organization":   @"总工会",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2482.0,
                               @"a_originY":        @1262.0,
                               @"a_endX":           @2538.0,
                               @"a_endY":           @1302.0,
                               };
        [array addObject:dic3];
        NSDictionary *dic4 = @{@"a_id": @4,
                               @"a_name":           @"3",
                               @"a_organization":   @"总工会",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2482.0,
                               @"a_originY":        @1214.0,
                               @"a_endX":           @2538.0,
                               @"a_endY":           @1255.0,
                               };
        [array addObject:dic4];
        
        for (NSDictionary *dic in array) {
            Area *area = [NSEntityDescription insertNewObjectForEntityForName:@"Area" inManagedObjectContext:_fetchController.managedObjectContext];
            [area setValuesForKeysWithDictionary:dic];
        }
        
        //保存
        NSError *error = nil;
        if (![_fetchController.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }else {
            NSLog(@"保存成功");
//            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Department"];
//            NSLog(@"%@",[_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error]);
        }
    }else {
        /**
         *  方法一
         */
        
//        NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:_fetchController.managedObjectContext];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dp_name = %@",@"婚姻（收养）登记中心"];
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        [fetchRequest setEntity:entityDes];
//        [fetchRequest setPredicate:predicate];
//        NSError *error = nil;
//        NSArray *array = [_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//        
//        if (error) {
//            NSLog(@"%@",error);
//        }else {
//            NSLog(@"%@",array);
//            for (Department *department in array) {
//                NSSet *result = department.windows;
//                NSPredicate *filter = [NSPredicate predicateWithFormat:@"wd_name = %@",@"收养登记"];
//                
//                Window *window = [[result filteredSetUsingPredicate:filter] anyObject];
//                NSLog(@"%@",window.wd_name);
//            }
//
//        }
        
        
        /**
         *  方法二
         */
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Window"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wd_name like '收养登记'"];
        [fetchRequest setPredicate:predicate];
        NSError *error = nil;
        NSArray *array = [_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        [fetchRequest release];
//        NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Window" inManagedObjectContext:_fetchController.managedObjectContext];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wd_name like '收养登记'"];
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        [fetchRequest setEntity:entityDes];
//        [fetchRequest setPredicate:predicate];
//        NSError *error = nil;
//        NSArray *array = [_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
//        if (error) {
//            NSLog(@"%@",error);
//        }else {
//            NSLog(@"%@",array);
//            
//            NSPredicate *filter = [NSPredicate predicateWithFormat:@"dept.dp_name == '婚姻（收养）登记中心'"];
//            NSArray *resArr = [array filteredArrayUsingPredicate:filter];
//
//            for (Window *window in resArr) {
//                NSLog(@"%@",window.wd_name);
//            }
//            
//        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
