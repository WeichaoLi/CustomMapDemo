//
//  GeoCoornidate.m
//  CustomMapDemo
//
//  Created by 李伟超 on 15/4/3.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "GeoSearch.h"
#import "Department.h"
#import "Room.h"
#import "Window.h"

@implementation GeoSearch

+ (NSArray *)geoCoordinateWithArray:(NSArray *)array AtPoint:(CGPoint)point WithScale:(CGFloat)scale InRect:(CGRect)rect {
    NSMutableArray *result = [NSMutableArray array];
    for (id obj in array) {
        NSMutableArray *points = nil;
        CGRect Mrect = CGRectZero;
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        if ([obj isMemberOfClass:[Department class]]) {
            Department *dept = (Department *)obj;
            Mrect = CGRectFromString(dept.dp_frame);
            if (dept.dp_points.length) {
                points = [NSMutableArray arrayWithArray:[dept.dp_points componentsSeparatedByString:@"-"]];
                
                CGPoint initalPoint = CGPointZero;
                for (int i = 0; i < points.count; i++) {
                    CGPoint point = CGPointFromString(points[i]);
                    point = CGPointMake(point.x + Mrect.origin.x, point.y + Mrect.origin.y);
                    point = CGPointMake(point.x * scale, point.y * scale);
                    if (i==0) {
                        CGPathMoveToPoint(pathRef, NULL, point.x, point.y);
                        initalPoint = point;
                    }else {
                        CGPathAddLineToPoint(pathRef, NULL, point.x, point.y);
                    }
                }
                
                CGPathAddLineToPoint(pathRef, NULL, initalPoint.x, initalPoint.y);
            }else {
                Mrect = CGRectFromString(dept.dp_frame);
                Mrect = CGRectMake(Mrect.origin.x * scale, Mrect.origin.y * scale, Mrect.size.width * scale, Mrect.size.height * scale);
                CGPathAddRect(pathRef, NULL, Mrect);
                
            }
        }else if ([obj isMemberOfClass:[Window class]]) {
            Window *window = (Window *)obj;
            Mrect = CGRectFromString(window.wd_frame);
            Mrect = CGRectMake(Mrect.origin.x * scale, Mrect.origin.y * scale, Mrect.size.width * scale, Mrect.size.height * scale);
            CGPathAddRect(pathRef, NULL, Mrect);
        }else {
            Room *room = (Room *)obj;
            Mrect = CGRectFromString(room.rm_frame);
            Mrect = CGRectMake(Mrect.origin.x * scale, Mrect.origin.y * scale, Mrect.size.width * scale, Mrect.size.height * scale);
            CGPathAddRect(pathRef, NULL, Mrect);
        }
        CGPathCloseSubpath(pathRef);
        
        if (CGPathContainsPoint(pathRef, NULL, point, NO)) {
            [result addObject:obj];
        }
        CGPathRelease(pathRef);
    }
    
    
    return result;
}

@end
