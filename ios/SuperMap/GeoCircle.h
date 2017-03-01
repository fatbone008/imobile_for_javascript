//
//  GeoCircle.h
//  LibUGC
//
//  Created by zyd on 16/11/21.
//  Copyright © 2016年 beijingchaotu. All rights reserved.
//

#import "Geometry.h"

@class Point2D;

@interface GeoCircle : Geometry

/**
 * @brief 获取或设置圆的圆心。
 *
 * @return 圆的圆心。
 */
@property (strong, nonatomic) Point2D *center;

/**
 * @brief 获取或设置圆的半径。
 *
 * @return 圆的半径。
 */
@property (assign, nonatomic) double radius;

/**
 * @brief 根据圆心和半径构造圆对象。
 * @param center 指定的 圆心。
 * @param radius 指定的 半径。
 */
- (id)initWithCenter:(Point2D *)center radius:(double)radius;

@end
