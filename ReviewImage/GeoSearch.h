//
//  GeoCoornidate.h
//  CustomMapDemo
//
//  Created by 李伟超 on 15/4/3.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoSearch : NSObject

+ (NSArray *)geoCoordinateWithArray:(NSArray *)array AtPoint:(CGPoint)point WithScale:(CGFloat)scale InRect:(CGRect)rect;

@end
