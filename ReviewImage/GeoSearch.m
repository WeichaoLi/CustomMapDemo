//
//  GeoCoornidate.m
//  CustomMapDemo
//
//  Created by 李伟超 on 15/4/3.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "GeoSearch.h"
#import "Area.h"

@implementation GeoSearch

+ (NSArray *)geoCoordinateWithArray:(NSArray *)array AtPoint:(CGPoint)point WithScale:(CGFloat)scale InRect:(CGRect)rect {
//    NSMutableArray *result = [NSMutableArray array];
//    for (Area *area in array) {
//        NSMutableArray *points = nil;
//        CGRect Mrect = CGRectZero;
//        
//        CGMutablePathRef pathRef = CGPathCreateMutable();
//        
//        Mrect = CGRectFromString(area.);
//        Mrect = CGRectMake(Mrect.origin.x * scale, Mrect.origin.y * scale, Mrect.size.width * scale, Mrect.size.height * scale);
//        CGPathAddRect(pathRef, NULL, Mrect);
//        }
//        CGPathCloseSubpath(pathRef);
//        
//        if (CGPathContainsPoint(pathRef, NULL, point, NO)) {
//            [result addObject:obj];
//        }
//        CGPathRelease(pathRef);
//    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"a_originX < %f AND a_originY < %f AND a_endX > %f AND a_endY > %f", point.x/scale, point.y/scale, point.x/scale, point.y/scale];

    return [array filteredArrayUsingPredicate:predicate];
}

@end
