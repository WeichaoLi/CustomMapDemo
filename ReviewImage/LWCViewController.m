//
//  LWCViewController.m
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/24.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "LWCViewController.h"
#import "Department.h"
#import "Window.h"

@interface LWCViewController ()

@end

@implementation LWCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fetchController = [[FetchController alloc] initWithEntity:@"Department"];
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
        Department *department = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:_fetchController.managedObjectContext];
        
        department.dp_frame = [NSString stringWithFormat:@"{{600, 52},{60, 98}}"];
        department.dp_department = @"外地劳动力管理所";
        department.dp_info = @"劳动力管理";
        
        NSArray *array = @[@"20",@"21",@"22",@"23"];
        for (NSString *str in array) {
            Window *window = [NSEntityDescription insertNewObjectForEntityForName:@"Window" inManagedObjectContext:_fetchController.managedObjectContext];
            window.wd_name = str;
            window.department = department;
        }
        NSLog(@"%@",department.objectID);
        
        //保存
        NSError *error = nil;
        if (![_fetchController.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }else {
            NSLog(@"保存成功");
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Department"];
            NSLog(@"%@",[_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error]);
        }
    }else {
        /**
         *  方法一
         */
        
//        NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:_fetchController.managedObjectContext];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dp_department = %@",@"婚姻（收养）登记中心"];
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
        
        NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Window" inManagedObjectContext:_fetchController.managedObjectContext];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wd_name like '收养登记'"];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entityDes];
        [fetchRequest setPredicate:predicate];
        NSError *error = nil;
        NSArray *array = [_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        if (error) {
            NSLog(@"%@",error);
        }else {
            NSLog(@"%@",array);
            
            NSPredicate *filter = [NSPredicate predicateWithFormat:@"department.dp_department == '婚姻（收养）登记中心'"];
            NSArray *resArr = [array filteredArrayUsingPredicate:filter];

            for (Window *window in resArr) {
                NSLog(@"%@",window.wd_name);
            }
            
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
