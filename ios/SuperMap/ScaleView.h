//
//  ScaleView.h
//  TestProject
//
//  Created by imobile on 15/6/24.
//  Copyright (c) 2015年 imobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapControl;
@interface ScaleView : UIView
//是否分级，默认分级
@property(nonatomic,assign)BOOL levelEnable;
//是否可见，默认可见
@property(nonatomic,assign)BOOL showEnable;

//用于用户设置X轴比例尺位置，默认在左下角
@property(nonatomic)double xOffset;
//用于用户设置y轴比例尺位置，默认在左下角
@property(nonatomic)double yOffset;

-(id)initWithMapControl:(MapControl*)mapcontrol;
@end
