//
//  JSScaleView.m
//  Supermap
//
//  Created by 王子豪 on 2017/3/7.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "JSScaleView.h"
#import "JSObjManager.h"
#import "SuperMap/ScaleView.h"
@implementation JSScaleView
RCT_EXPORT_MODULE();
RCT_REMAP_METHOD(createObjWithMapControlId,initWithMapControlId:(NSString*)mapControlId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    MapControl* mapcontrol = [JSObjManager getObjWithKey:mapControlId];
    if(mapcontrol){
        ScaleView* scaleView = [[ScaleView alloc]initWithMapControl:mapcontrol];
        [JSObjManager addObj:scaleView];
        NSInteger key = (NSInteger)scaleView;
        resolve(@{@"scaleViewId":@(key).stringValue});
    }else
        reject(@"scaleView",@"create Obj With MapControlId failed!!!",nil);
}

RCT_REMAP_METHOD(setLevelEnable,setLevelEnableWithId:(NSString*)scaleviewId andLevelEnable:(BOOL)enable resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    ScaleView* scaleView = [JSObjManager getObjWithKey:scaleviewId];
    if(scaleView){
        scaleView.levelEnable = enable;
        resolve(@"levelenable setted");
    }else
        reject(@"scaleView",@"set levelenable failed!!!",nil);
}

RCT_REMAP_METHOD(getLevelEnable,getLevelEnableWithId:(NSString*)scaleviewId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    ScaleView* scaleView = [JSObjManager getObjWithKey:scaleviewId];
    if(scaleView){
        NSNumber* nsLevelEnable = [NSNumber numberWithBool:scaleView.levelEnable];
        resolve(@{@"levelEnable":nsLevelEnable});
    }else
        reject(@"scaleView",@"set levelenable failed!!!",nil);
}

RCT_REMAP_METHOD(setShowEnable,setShowEnableWithId:(NSString*)scaleviewId andShowEnable:(BOOL)enable resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    ScaleView* scaleView = [JSObjManager getObjWithKey:scaleviewId];
    if(scaleView){
        scaleView.showEnable = enable;
        resolve(@"showEnable setted");
    }else
        reject(@"scaleView",@"set levelenable failed!!!",nil);
}

RCT_REMAP_METHOD(getShowEnable,getShowEnableWithId:(NSString*)scaleviewId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    ScaleView* scaleView = [JSObjManager getObjWithKey:scaleviewId];
    if(scaleView){
        NSNumber* nsShowEnable = [NSNumber numberWithBool:scaleView.showEnable];
        resolve(@{@"showEnable":nsShowEnable});
    }else
        reject(@"scaleView",@"set showenable failed!!!",nil);
}

RCT_REMAP_METHOD(setxOffset,setxOffsetWithId:(NSString*)scaleviewId andxOffset:(double)xOffset resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    ScaleView* scaleView = [JSObjManager getObjWithKey:scaleviewId];
    if(scaleView){
        scaleView.xOffset = xOffset;
        resolve(@"xOffset setted");
    }else
        reject(@"scaleView",@"set xOffset failed!!!",nil);
}

RCT_REMAP_METHOD(setyOffset,setyOffsetWithId:(NSString*)scaleviewId andyOffset:(double)yOffset resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    ScaleView* scaleView = [JSObjManager getObjWithKey:scaleviewId];
    if(scaleView){
        scaleView.yOffset = yOffset;
        resolve(@"showEnable setted");
    }else
        reject(@"scaleView",@"set levelenable failed!!!",nil);
}
@end
