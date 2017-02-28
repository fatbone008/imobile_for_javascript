//
//  NaviStep.h
//  ProNavigationDemo
//
//  Created by imobile-xzy on 15/9/2.
//  Copyright (c) 2015年 imobile-xzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Point2D;
@interface NaviStep : NSObject

//!< 道路长度，单位m
@property(nonatomic,assign)double length;
//!< 转弯方向贴图编号
@property(nonatomic,assign)double toSwerve;
//!< 道路名称
@property(nonatomic,strong)NSString* name;
 //!< 路口点
@property(nonatomic,strong)Point2D* point;
//!< 道路时间，单位分钟
@property(nonatomic,assign)double time;
@end
