//
//  JSLayer.m
//  rnTest
//
//  Created by imobile-xzy on 16/7/5.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "JSLayer.h"
#import "SuperMap/Layer.h"
#import "JSObjManager.h"

@implementation JSLayer
//注册为Native模块
RCT_EXPORT_MODULE();

RCT_REMAP_METHOD(setEditable,setEditableKey:(NSString*)key  editable:(BOOL)editable resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Layer* layer = [JSObjManager getObjWithKey:key];
  if(layer){
    layer.editable = editable;
    resolve(@"editable have been setted");
  }else{
    reject(@"Layer",@"set editable failed!",nil);
  }
}

RCT_REMAP_METHOD(getName,getNameByKey:(NSString*)key andIndex:(int)index resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Layer* layer = [JSObjManager getObjWithKey:key];
  if(layer.name){
    resolve(@{@"layerName":layer.name});
  }else{
  reject(@"Layer",@"get name failed!",nil);
  }
}

RCT_REMAP_METHOD(getDataset,getDatasetByKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Layer* layer = [JSObjManager getObjWithKey:key];
  if(layer.dataset){
    NSInteger key = (NSInteger)layer.dataset;
    [JSObjManager addObj:layer.dataset];
    resolve(@{@"datasetId":@(key).stringValue});
  }else{
  reject(@"Layer",@"get dataset failed!",nil);
  }
}

RCT_REMAP_METHOD(setDataset,setDatasetByKey:(NSString*)key andDatasetId:(NSString*)datasetId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Layer* layer = [JSObjManager getObjWithKey:key];
  Dataset* dataset = [JSObjManager getObjWithKey:datasetId];
  if(dataset){
    layer.editable = TRUE;
//    layer.dataset = dataset;
      // read only propety
    NSInteger key = (NSInteger)layer.dataset;
    [JSObjManager addObj:layer.dataset];
    resolve(@{@"datasetId":@(key).stringValue});
  }else
  reject(@"Layer",@"get dataset failed!!!",nil);
}

RCT_REMAP_METHOD(getSelection,getSelectionByKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Layer* layer = [JSObjManager getObjWithKey:key];
  Selection* selection = [layer getSelection];
  if(selection){
    NSInteger key = (NSInteger)selection;
    [JSObjManager addObj:selection];
    resolve(@{@"selectionId":@(key).stringValue});
  }else{
  reject(@"Layer",@"get selection failed!",nil);
  }
}

RCT_REMAP_METHOD(setSelectable,setSelectableByKey:(NSString*)layerId boolBit:(BOOL)boolBit resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Layer* layer = [JSObjManager getObjWithKey:layerId];
    if(layer){
        layer.selectable = boolBit;
        resolve(@"selectable have been setted!");
    }else{
        reject(@"Layer",@"set selectable failed!",nil);
    }
}

RCT_REMAP_METHOD(setVisible,setVisibleByKey:(NSString*)layerId boolBit:(BOOL)boolBit resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Layer* layer = [JSObjManager getObjWithKey:layerId];
    if(layer){
        layer.visible = boolBit;
        resolve(@"visable have been setted!");
    }else{
        reject(@"Layer",@"set visable failed!",nil);
    }
}
@end
