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
        NSURL *url = [NSURL URLWithString:@"http://192.168.16.104:8888/111.csv"];
        NSError *error = nil;
        NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if (str.length) {
            NSArray *array = [str componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            for (str in array) {
                if (!str.length) {
                    continue;
                }
                NSArray *temp = [str componentsSeparatedByString:@","];
                NSLog(@"%@",temp);
                Area *area = [NSEntityDescription insertNewObjectForEntityForName:@"Area" inManagedObjectContext:_fetchController.managedObjectContext];
                area.a_id =         [NSNumber numberWithInt:[temp[0] intValue]];
                area.a_name =       temp[1];
                area.a_type =       [NSNumber numberWithInt:[temp[2] intValue]];
                area.a_number =     temp[3];
                area.a_floor =      temp[4];
                area.a_originX =    [NSNumber numberWithFloat:[temp[5] floatValue]];
                area.a_originY =    [NSNumber numberWithFloat:[temp[6] floatValue]];
                area.a_endX =       [NSNumber numberWithFloat:[temp[7] floatValue]];
                area.a_endY =       [NSNumber numberWithFloat:[temp[8] floatValue]];
                area.a_organization = temp[9];
                if (temp.count > 10) {
                    area.a_info =       temp[10];
                }
            }
            
            //保存
            if (![_fetchController.managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }else {
                NSLog(@"保存成功");

            }
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
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Window"];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wd_name like '收养登记'"];
//        [fetchRequest setPredicate:predicate];
//        NSError *error = nil;
//        NSArray *array = [_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//        [fetchRequest release];
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
