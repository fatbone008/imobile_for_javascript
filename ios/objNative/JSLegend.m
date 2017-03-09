//
//  JSLegend.m
//  Supermap
//
//  Created by 王子豪 on 2017/3/8.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "JSLegend.h"
#import "JSObjManager.h"
#import "SuperMap/Legend.h"
#import "SuperMap/Map.h"
#import "SuperMap/LegendView.h"
@implementation JSLegend
RCT_EXPORT_MODULE();
RCT_REMAP_METHOD(createObjWithMap,createWithMapId:(NSString*)mapId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Map* map = [JSObjManager getObjWithKey:mapId];
    if(map){
        Legend* legend = map.legend;
        [JSObjManager addObj:legend];
        NSInteger key = (NSInteger)legend;
        resolve(@{@"legendId":@(key).stringValue});
    }else
    reject(@"legend",@"create Obj With MapId failed!!!",nil);
}

RCT_REMAP_METHOD(show,showWithLegendId:(NSString*)legendId andShowEnable:(BOOL)enable resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Legend* legend = [JSObjManager getObjWithKey:legendId];
    if(legend){
        LegendView* legendView = legend.legendView;
        BOOL show = !enable;
        legendView.hidden = show;
        resolve(@"setted");
    }else
    reject(@"legend",@"show legend failed!!!",nil);
}
@end
