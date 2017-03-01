//
//  JSMap.m
//  rnTest
//
//  Created by imobile-xzy on 16/7/5.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "JSMap.h"
#import "SuperMap/Map.h"
#import "SuperMap/Layers.h"
#import "JSObjManager.h"

@implementation JSMap
//注册为Native模块
RCT_EXPORT_MODULE();

RCT_REMAP_METHOD(setWorkspace,userKey:(NSString*)key workSpaceKey:(NSString*)workSpaceKey resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Map* map = [JSObjManager getObjWithKey:key];
  Workspace* workspace = [JSObjManager getObjWithKey:workSpaceKey];
  if(map && workspace){
    [map setWorkspace:workspace];
    resolve(@"set workspace seccessfully");
  }else
    reject(@"Map",@"setWorkspace: Map or workspace not exeist!!!",nil);
}

RCT_REMAP_METHOD(refresh,userKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Map* map = [JSObjManager getObjWithKey:key];
  if(map){
    [map refresh];
    resolve(@"map refresh successfully");
  }else
    reject(@"Map",@"refresh:Map or workspace not exeist!!!",nil);
}

#pragma mark - 原Layers类方法
/**
 根据图层序号获取图层

 @param key get description
 @param index map键值
 @return promise
 */
RCT_REMAP_METHOD(getLayer,getLayerByKey:(NSString*)key andlayerIndex:(int)index resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Map* map = [JSObjManager getObjWithKey:key];
    if(map){
        Layers* layers = map.layers;
        Layer* layer = [layers getLayerAtIndex:index];
        NSInteger key = (NSInteger)layer;
        [JSObjManager addObj:layer];
        resolve(@{@"layerId":@(key).stringValue});
    }else
        reject(@"Map",@"getLayer:get layer failed !",nil);
}

RCT_REMAP_METHOD(getLayerByName,getLayerByKey:(NSString*)key andName:(NSString*)name resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Map* map = [JSObjManager getObjWithKey:key];
    if(map){
        Layers* layers = map.layers;
        Layer* layer = [layers getLayerWithName:name];
        NSInteger key = (NSInteger)layer;
        [JSObjManager addObj:layer];
        resolve(@{@"layerId":@(key).stringValue});
    }else
        reject(@"Map",@"getLayerByName:get layer failed !",nil);
}

RCT_REMAP_METHOD(addDataset,addDatasetByKey:(NSString*)key andDataSetId:(NSString*)id withHeadBool:(bool)ToHead resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Map* map = [JSObjManager getObjWithKey:key];
    Dataset* dataset = [JSObjManager getObjWithKey:id];
    if(map&&dataset){
        Layers* layers = map.layers;
        [layers addDataset:dataset ToHead:ToHead];
        resolve(@"successfully add dataset!");
    }else
        reject(@"Map",@"addDataset:Map or Dataset not exeist!",nil);
}

RCT_REMAP_METHOD(getLayers,getLayersUserKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Map* map = [JSObjManager getObjWithKey:key];
  if(map){
    Layers* layers = map.layers;
    NSInteger key = (NSInteger)layers;
    [JSObjManager addObj:layers];
    resolve(@{@"layersId":@(key).stringValue});
  }else
    reject(@"Map",@"getLayers:Map not exeist!!!",nil);
}

RCT_REMAP_METHOD(getLayersCount,getLayersCountByKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Map* map = [JSObjManager getObjWithKey:key];
    if(map){
        Layers* layers = map.layers;
        int layerCount = [layers getCount];
        NSNumber* nsLayerCount = [NSNumber numberWithInt:layerCount];
        resolve(@{@"count":nsLayerCount});
    }else
        reject(@"Map",@"getLayersCount:Map not exeist!",nil);
}

RCT_REMAP_METHOD(open,openKey:(NSString*)key mapName:(NSString*)mapName resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  
  Map* map = [JSObjManager getObjWithKey:key];
  if(map){
    if(![map open:mapName]){
      NSLog(@"OPen map %@ failed",mapName);
    }
     resolve(@"1");
  }else
    reject(@"Map",@"getLayers:Map not exeist!!!",nil);
}

//RCT_REMAP_METHOD(pixelToMap,pixelToMapKey:(NSString*)key pointId:(NSString*)pointId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
//  Map* map = [JSObjManager getObjWithKey:key];
//  NSArray* pointArr = [JSObjManager getObjWithKey:pointId];
//  double pointx = [pointArr[0] doubleValue];
//  double pointy = [pointArr[1] doubleValue];
//  CGPoint point = CGPointMake((CGFloat)pointx, (CGFloat)pointy);
//  if(map){
//    Point2D* point2D = [map pixelTomap:point];
//    NSInteger key = (NSInteger)point2D;
//    [JSObjManager addObj:point2D];
//    resolve(@{@"point2DId":@(key).stringValue});
//  }else{
//  reject(@"Map",@"pixelToMap failed!!!",nil);
//  }
//}

//RCT_REMAP_METHOD(pixelToMap,pixelToMapKey:(NSString*)key xNum:(double)xNum yNum:(double)yNum resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
//  Map* map = [JSObjManager getObjWithKey:key];
//  CGPoint point = CGPointMake((CGFloat)xNum, (CGFloat)yNum);
//  if(map){
//    Point2D* point2D = [map pixelTomap:point];
//    NSInteger key = (NSInteger)point2D;
//    [JSObjManager addObj:point2D];
//    resolve(@{@"point2DId":@(key).stringValue});
//  }else{
//    reject(@"Map",@"pixelToMap failed!!!",nil);
//  }
//}

RCT_REMAP_METHOD(pixelToMap,pixelToMapByKey:(NSString*)key andPointId:(NSString*)pointId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Map* map = [JSObjManager getObjWithKey:key];
    NSDictionary* pointDic = [JSObjManager getObjWithKey:pointId];
    if(map&&pointDic){
        //抽出根据pointId构造cgpoint方法
        NSNumber* nsX = [pointDic objectForKey:@"x"];
        NSNumber* nsY = [pointDic objectForKey:@"y"];
        double pointX = nsX.doubleValue;
        double pointY = nsY.doubleValue;
        CGPoint point = CGPointMake(pointX, pointY);
        Point2D* point2D = [map pixelTomap:point];
        NSInteger key = (NSInteger)point2D;
        [JSObjManager addObj:point2D];
        resolve(@{@"point2DId":@(key).stringValue});
    }else{
        reject(@"Map",@"pixelToMap failed!!!",nil);
    }
}

RCT_REMAP_METHOD(setCenter,setCenterKey:(NSString*)key point2DId:(NSString*)point2DId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Map* map = [JSObjManager getObjWithKey:key];
  Point2D* point = [JSObjManager getObjWithKey:point2DId];
  if(map&&point){
    map.center = point;
    resolve(@"1");
  }else{
    reject(@"Map",@"setCenter failed!!!",nil);
  };
}

RCT_REMAP_METHOD(getTrackingLayer,getTrackingLayerKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Map* map = [JSObjManager getObjWithKey:key];
  if(map.trackingLayer){
    NSInteger trackingKey = (NSInteger)map.trackingLayer;
    [JSObjManager addObj:map.trackingLayer];
    resolve(@{@"trackingLayerId":@(trackingKey).stringValue});
  }else{
    reject(@"Map",@"getTrackingLayer failed!!!",nil);
  }
}

RCT_REMAP_METHOD(getPrjCoordSys,getPrjCoordSysKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Map* map = [JSObjManager getObjWithKey:key];
  if(map.prjCoordSys){
    NSInteger projKey = (NSInteger)map.prjCoordSys;
    [JSObjManager addObj:map.prjCoordSys];
    resolve(@{@"prjCoordSysId":@(projKey).stringValue});
  }else{
    reject(@"Map",@"getProjSys failed!!!",nil);
  }
}

//RCT_REMAP_METHOD(setPrjCoordSys,setPrjCoordSysKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
//  Map* map = [JSObjManager getObjWithKey:key];
//  if(map.prjCoordSys){
//    NSInteger projKey = (NSInteger)map.prjCoordSys;
//    [JSObjManager addObj:map.prjCoordSys];
//    resolve(@{@"prjCoordSysId":@(projKey).stringValue});
//  }else{
//    reject(@"Map",@"getProjSys failed!!!",nil);
//  }
//}
@end
