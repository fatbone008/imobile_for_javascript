//
//  JSNavigation.m
//  Supermap
//
//  Created by 王子豪 on 2017/3/15.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "JSNavigation.h"
#import "JSObjManager.h"
#import "SuperMap/Navigation.h"
@implementation JSNavigation
RCT_EXPORT_MODULE();
RCT_REMAP_METHOD(connectNaviData,connectNaviDataById:(NSString*)naviId withDataPath:(NSString*)path resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Navigation* navi = [JSObjManager getObjWithKey:naviId];
    if(navi){
        NSString* firstStr = [path substringToIndex:1];
        if ([firstStr isEqualToString:@"/"]) {
            path = [NSHomeDirectory() stringByAppendingString:path];
        }
        BOOL success = [navi connectNaviData:path];
        NSNumber* nsSuccess = [NSNumber numberWithBool:success];
        resolve(@{@"success":nsSuccess});
    }else{
        reject(@"Navigation",@"connect NaviData failed!!!",nil);
    }
}

RCT_REMAP_METHOD(routeAnalyst,routeAnalystById:(NSString*)naviId withMode:(int)mode resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Navigation* navi = [JSObjManager getObjWithKey:naviId];
    if(navi){
        int success = [navi routeAnalyst:mode];
        NSNumber* nsSuccess = [NSNumber numberWithInt:success];
        resolve(@{@"result":nsSuccess});
    }else{
        reject(@"Navigation",@"routeAnalyst failed!!!",nil);
    }
}

RCT_REMAP_METHOD(setStartPoint,setStartPointById:(NSString*)naviId withPointX:(double)pointX withPointY:(double)pointY withMapId:(NSString*)mapId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Navigation* navi = [JSObjManager getObjWithKey:naviId];
    if(navi){
        [navi setStartPoint:pointX sPointY:pointY];
        resolve(@"startPoint setted");
    }else{
        reject(@"Navigation",@"set StartPoint failed!!!",nil);
    }
}

RCT_REMAP_METHOD(setDestinationPoint,setDestinationPointById:(NSString*)naviId withPointX:(double)pointX withPointY:(double)pointY withMapId:(NSString*)mapId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Navigation* navi = [JSObjManager getObjWithKey:naviId];
    if(navi){
        [navi setDestinationPoint:pointX dPointY:pointY];
        resolve(@"destinationPoint setted");
    }else{
        reject(@"Navigation",@"set destinationPoint failed!!!",nil);
    }
}

RCT_REMAP_METHOD(startGuide,startGuideById:(NSString*)naviId withStatus:(int)status resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Navigation* navi = [JSObjManager getObjWithKey:naviId];
    if(navi){
        BOOL start = [navi startGuide:status];
        NSNumber* nsStart = [NSNumber numberWithBool:start];
        resolve(@{@"guiding":nsStart});
    }else{
        reject(@"Navigation",@"start Guide failed!!!",nil);
    }
}
@end
