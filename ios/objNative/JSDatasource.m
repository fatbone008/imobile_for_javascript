//
//  JSDatasource.m
//  rnTest
//
//  Created by imobile-xzy on 16/7/5.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "JSDatasource.h"
#import "SuperMap/Datasource.h"
#import "SuperMap/Datasets.h"
#import "JSObjManager.h"

@implementation JSDatasource
//注册为Native模块
RCT_EXPORT_MODULE();

#pragma mark - 属性获取方法

RCT_REMAP_METHOD(getDatasets,getUserKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Datasource* datasource = [JSObjManager getObjWithKey:key];
  Datasets* datasets = datasource.datasets;
  if(datasets){
    NSInteger key = (NSInteger)datasets;
    [JSObjManager addObj:datasets];
    resolve(@{@"datasetsId":@(key).stringValue});
  }else
    reject(@"dataSource",@"get datasets failed",nil);
}

#pragma mark - 原Datasets类方法

RCT_REMAP_METHOD(getDataset,getDatasetByKey:(NSString*)key andNum:(int)num resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Datasource* datasource = [JSObjManager getObjWithKey:key];
    Datasets* datasets = datasource.datasets;
    Dataset* dataset = [datasets get:num];
    if(dataset){
        NSInteger key = (NSInteger)dataset;
        [JSObjManager addObj:dataset];
        resolve(@{@"datasetId":@(key).stringValue});
    }else
        reject(@"dataSource",@"get dataset failed",nil);
}

RCT_REMAP_METHOD(getDatasetByName,getDatasetByKey:(NSString*)key andName:(NSString*)name resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Datasource* datasource = [JSObjManager getObjWithKey:key];
    Datasets* datasets = datasource.datasets;
    Dataset* dataset = [datasets getWithName:name];
    if(dataset){
        NSInteger key = (NSInteger)dataset;
        [JSObjManager addObj:dataset];
        resolve(@{@"datasetId":@(key).stringValue});
    }else
        reject(@"dataSource",@"get dataset failed",nil);
}

RCT_REMAP_METHOD(getAvailableDatasetName,getAvailableNameByKey:(NSString*)key andName:(NSString*)name resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Datasource* datasource = [JSObjManager getObjWithKey:key];
    Datasets* datasets = datasource.datasets;
    NSString* outPutName = [datasets availableDatasetName:name];
    if(outPutName){
        resolve(@{@"datasetName":outPutName});
    }else
        reject(@"dataSource",@"get dataset failed",nil);
}

#pragma mark - 原datasetVectorInfo类方法


@end
