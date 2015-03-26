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
    _fetchController = [[FetchController alloc] initWithEntity:@"Department"];
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
        Department *department1 = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:_fetchController.managedObjectContext];
        
        department1.dp_frame = [NSString stringWithFormat:@"{{45, 53},{268, 145}}"];
        department1.dp_points = @"{0,0}-{0,147}-{60,147}-{60,23}-{270,23}-{270,0}";
        department1.dp_name = @"房地产交易中心";
        department1.dp_info = @"房地产";
        
        NSArray *array1 = @[@"34",@"35",@"36",@"37",@"38",@"39"];
        NSArray *arr = @[@"{{309, 95},{11, 10}}",
                         @"{{295, 95},{11, 10}}",
                         @"{{281, 95},{11, 10}}",
                         @"{{268, 95},{11, 10}}",
                         @"",@""];
        for (int i=0 ; i < arr.count; i++) {
            Window *window = [NSEntityDescription insertNewObjectForEntityForName:@"Window" inManagedObjectContext:_fetchController.managedObjectContext];
            window.wd_name = array1[i];
            window.wd_frame = arr[i];
            window.dept = department1;
        }
        
        
        
        Department *department2 = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:_fetchController.managedObjectContext];
        
        department2.dp_frame = [NSString stringWithFormat:@"{{497, 378},{165, 108}}"];
//        department1.dp_points = @"{0,0}-{0,147}-{60,147}-{60,23}-{270,23}-{270,0}";
        department2.dp_name = @"婚姻（收养）登记中心";
        department2.dp_info = @"婚姻、收养";
        
        NSArray *array2 = @[@"结婚登记", @"收养登记", @"离婚登记"];
        for (NSString *str in array2) {
            Window *window = [NSEntityDescription insertNewObjectForEntityForName:@"Window" inManagedObjectContext:_fetchController.managedObjectContext];
            window.wd_name = str;
            window.dept = department2;
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
        
        if (error) {
            NSLog(@"%@",error);
        }else {
            NSLog(@"%@",array);
            
            NSPredicate *filter = [NSPredicate predicateWithFormat:@"dept.dp_name == '婚姻（收养）登记中心'"];
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
