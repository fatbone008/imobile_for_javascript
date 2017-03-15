//
//  JSAdoptMapView.m
//  GeometryInfo
//
//  Created by 王子豪 on 2017/1/4.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "JSAdoptMapView.h"
#import "JSObjManager.h"
#import "SuperMap/Geometry.h"
#import "SuperMap/Point2D.h"
@implementation JSAdoptMapView
RCT_EXPORT_MODULE(JSMapControl);

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"Supermap.MapControl.MapParamChanged.BoundsChanged", @"Supermap.MapControl.MapParamChanged.ScaleChanged"];
}

-(void) boundsChanged:(Point2D*) newMapCenter{
    double x = newMapCenter.x;
    NSNumber* nsX = [NSNumber numberWithDouble:x];
    double y = newMapCenter.y;
    NSNumber* nsY = [NSNumber numberWithDouble:y];
    [self sendEventWithName:@"Supermap.MapControl.MapParamChanged.BoundsChanged"
                       body:@{@"x":nsX,
                              @"y":nsY
                              }];
}

-(void) scaleChanged:(double) newscale{
    NSNumber* nsNewScale = [NSNumber numberWithDouble:newscale];
    [self sendEventWithName:@"Supermap.MapControl.MapParamChanged.ScaleChanged"
                       body:@{@"scale":nsNewScale
                              }];
}

RCT_REMAP_METHOD(getMap,geMapKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  MapControl* mapcontrol = [JSObjManager getObjWithKey:key];
  if(mapcontrol){
    Map* map = mapcontrol.map;
    [JSObjManager addObj:map];
    NSInteger key = (NSInteger)map;
    resolve(@{@"mapId":@(key).stringValue});
  }else
    reject(@"MapControl",@"getMap:mapcontrol not exeist!!!",nil);
}

RCT_REMAP_METHOD(setAction,mapControlId:(NSString*)Id actionType:(int)type resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    MapControl* mapControl = [JSObjManager getObjWithKey:Id];
    if (mapControl) {
        mapControl.action = type;
        resolve(@"1");
    }else{
        reject(@"mapControl",@"setAction failed!!!",nil);
    }
}

RCT_REMAP_METHOD(submit,submitByKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    MapControl* mapControl = [JSObjManager getObjWithKey:key];
    if (mapControl) {
        [mapControl submit];
        resolve(@"submit successful");
    }else{
        reject(@"mapControl",@"submit failed!!!",nil);
    }
}

RCT_REMAP_METHOD(setMapParamChangedListener,setMapParamChangedListenerByKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    MapControl* mapCtrl = [JSObjManager getObjWithKey:key];
    Map* map = mapCtrl.map;
    if(map){
        map.delegate =self;
        NSNumber* nsTrue = [NSNumber numberWithBool:TRUE];
        resolve(nsTrue);
    }else{
        reject(@"mapControl",@"set MapParamChangedListener failed!!!",nil);
    }
}

RCT_REMAP_METHOD(getNavigation2,getNavigation2BymapControlId:(NSString*)Id resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  MapControl* mapControl = [JSObjManager getObjWithKey:Id];
  Navigation2* navi2 = [mapControl getNavigation2];
  if(navi2){
    NSInteger key = (NSInteger)navi2;
    [JSObjManager addObj:navi2];
    resolve(@{@"navigation2Id":@(key).stringValue});
  }else{
    reject(@"mapControl",@"get navi2 failed!!!",nil);
  }
}

RCT_REMAP_METHOD(getTraditionalNavi,getTraditionalNaviBymapControlId:(NSString*)Id resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    MapControl* mapControl = [JSObjManager getObjWithKey:Id];
    Navigation2* navi = [mapControl getNavigation];
    if(navi){
        NSInteger key = (NSInteger)navi;
        [JSObjManager addObj:navi];
        resolve(@{@"traditionalNaviId":@(key).stringValue});
    }else{
        reject(@"mapControl",@"get traditionalNavi failed!!!",nil);
    }
}

RCT_REMAP_METHOD(getCurrentGeometry,getCurrentGeometryById:(NSString*)Id resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  MapControl* mapControl = [JSObjManager getObjWithKey:Id];
  Geometry *geo = [mapControl getCurrentGeometry];
    if (geo) {
      GeometryType type = [geo getType];
        NSString* typeStr = [NSNull null];
        switch (type) {
            case GT_GEOPOINT:
                typeStr = @"GeoPoint";
                break;
            case GT_GEOREGION:
                typeStr = @"GeoRegion";
                break;
            case GT_GEOLINE:
                typeStr = @"GeoLine";
                break;
            default:
                typeStr = @"otherGeoType";
                break;
        }
      NSInteger key = (NSInteger)geo;
      [JSObjManager addObj:geo];
      resolve(@{@"geometryId":@(key).stringValue,@"geoType":typeStr});
    }else{
        reject(@"mapControl",@"getCurrentGeometry failed!!!",nil);
    }
}

RCT_REMAP_METHOD(setRefreshListener,setRefreshListenerById:(NSString*)Id resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    if (Id) {
        resolve(@"1");
    }else{
        reject(@"mapControl",@"setRefreshListener failed!!!",nil);
    }
}
@end
