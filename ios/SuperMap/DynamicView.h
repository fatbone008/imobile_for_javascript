//
//  DynamicView.h
//  LibUGC
//
//  Created by iMobile2D on 14-8-11.
//  Copyright (c) 2014年 beijingchaotu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Map.h"
#import "DynamicElement.h"



@interface DynamicView : UIView

-(id)initWithMapControl:(MapControl*)mapControl;

-(void)addElement:(DynamicElement*)element;
-(void)removeElementWithIDs:(NSArray*)IDs;
-(void)removeElementWithTag:(NSString*)tag;
-(void)clear;

-(NSArray*)queryWithIDs:(NSArray*)IDs;
-(NSArray*)queryWithTag:(NSString*)tag;
-(NSArray*)queryWithBounds:(Rectangle2D*)bounds;

-(void)startAnimation;//开始动画
-(void)refresh;

//是否开启聚合功能
@property(nonatomic,assign)BOOL isPolymerize;
@end
