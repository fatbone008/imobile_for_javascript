//
//  JSWorkspace.m
//  iMobileRnIos
//
//  Created by imobile-xzy on 16/5/12.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "JSObjManager.h"
#import "JSWorkspace.h"
#import "SuperMap/Workspace.h"
#import "SuperMap/Datasources.h"
#import "SuperMap/Maps.h"
#import "JSWorkspaceConnectionInfo.h"
#import "JSDatasourceConnectionInfo.h"
#import "JSDatasources.h"
#import "JSMaps.h"

@implementation JSWorkspace
@synthesize bridge = _bridge;
//注册为Native模块
RCT_EXPORT_MODULE();



#pragma mark - Public APIs

RCT_REMAP_METHOD(createObj,resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Workspace* workspace = [[Workspace alloc]init];
  NSLog(@"%@",NSHomeDirectory());
  if(workspace){
     NSInteger key = (NSInteger)workspace;
    [JSObjManager addObj:workspace];
    resolve(@{@"workspaceId":@(key).stringValue});
  }else{
    reject(@"WorkSpaceInfo",@"create workSaceInfo failed!!!",nil);
  }
}
RCT_REMAP_METHOD(destroyObj,destroyJSObjKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Workspace* workspace = [JSObjManager getObjWithKey:key];
  if(workspace){
    [workspace close];
    [workspace dispose];
    [JSObjManager removeObj:key];
    resolve(@"1");
  }else
    reject(@"workspace",@"destroy obj failed!!!",nil);
}

RCT_REMAP_METHOD(getDatasources,getDatasourcesKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    if(workspace){
        Datasources* dataSource = workspace.datasources;
        [JSObjManager addObj:dataSource];
        NSInteger nsDataSource = (NSInteger)dataSource;
        resolve(@{@"datasourcesId":@(nsDataSource).stringValue});
    }else{
        reject(@"workspace",@"workspace not exeist!!!",nil);
    }
}

#pragma mark - 原datasources类方法
RCT_REMAP_METHOD(openDatasourceConnectionInfo, openDatasourceConnectionInfoByKey:(NSString*)key datasourceConnectionInfo:(NSString*)info resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Workspace* workspace = [JSObjManager getObjWithKey:key];
  DatasourceConnectionInfo* infoObj = [JSObjManager getObjWithKey:info];
  if(workspace&&infoObj){
      Datasource* datasource = [workspace.datasources open:infoObj];
      [JSObjManager addObj:datasource];
      NSInteger nsDatasource = (NSInteger)datasource;
      resolve(@{@"datasourceId":@(nsDatasource).stringValue});
  }else{
      reject(@"workspace",@"open DatasourceConnectionInfo failed!!!",nil);
  }
}

RCT_REMAP_METHOD(getDatasource, getDatasourceByKey:(NSString*)key andIndex:(int)index resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    if(workspace){
        Datasource* datasource = [workspace.datasources get:index];
        [JSObjManager addObj:datasource];
        NSInteger nsDatasource = (NSInteger)datasource;
        resolve(@{@"datasourceId":@(nsDatasource).stringValue});
    }else{
        reject(@"workspace",@"get Datasource failed!!!",nil);
    }
}

RCT_REMAP_METHOD(getDatasourceByName, getDatasourceByKey:(NSString*)key andName:(NSString*)name resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    if(workspace){
        Datasource* datasource = [workspace.datasources getAlias:name];
        [JSObjManager addObj:datasource];
        NSInteger nsDatasource = (NSInteger)datasource;
        resolve(@{@"datasourceId":@(nsDatasource).stringValue});
    }else{
        reject(@"workspace",@"get Datasource failed!!!",nil);
    }
}

#pragma mark - workspace类方法

RCT_REMAP_METHOD(open,openBykey:(NSString*)key andWorkspaceConnectionInfoId:(NSString*)infoId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    WorkspaceConnectionInfo* info = [JSObjManager getObjWithKey:infoId];
    if(workspace&&info){
        BOOL openBit = [workspace open:info];
        NSNumber* nsOpenBit = [NSNumber numberWithBool:openBit];
        resolve(@{@"isOpen":nsOpenBit});
    }else
        reject(@"workspace",@"open failed!!!",nil);
}

RCT_REMAP_METHOD(getMaps,geMapsByKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    if(workspace){
        Maps* maps = workspace.maps;
        [JSObjManager addObj:maps];
        NSInteger nsMaps = (NSInteger)maps;
        resolve(@{@"mapsId":@(nsMaps).stringValue});
    }else
        reject(@"workspace",@"get maps failed!",nil);
}

#pragma mark - maps类方法
RCT_REMAP_METHOD(getMapName,getMapNameByKey:(NSString*)key andMapIndex:(int)index resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    if(workspace){
        Maps* maps = workspace.maps;
        NSString* mapName = [maps get:index];
        resolve(@{@"mapName":mapName});
    }else
        reject(@"workspace",@"get mapName failed!",nil);
}
//*********************************************
RCT_REMAP_METHOD(openDatasource,openDatasourceByKey:(NSString*)key andMapIndex:(int)index resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    if(workspace){
        Maps* maps = workspace.maps;
        NSString* mapName = [maps get:index];
        resolve(@{@"mapName":mapName});
    }else
        reject(@"workspace",@"get mapName failed!",nil);
}

RCT_REMAP_METHOD(save,saveKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  
  Workspace* workspace = [JSObjManager getObjWithKey:key];
  if(workspace){
    [workspace save];
    resolve(@"1");
  }else
    reject(@"workspace",@"save failed!!!",nil);
}

RCT_REMAP_METHOD(close,closeKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  
  Workspace* workspace = [JSObjManager getObjWithKey:key];
  if(workspace){
    [workspace close];
    resolve(@"1");
  }else
    reject(@"workspace",@"save failed!!!",nil);
}

RCT_REMAP_METHOD(dispose,disposeKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  
  Workspace* workspace = [JSObjManager getObjWithKey:key];
  if(workspace){
    [workspace dispose];
    resolve(@"1");
  }else
    reject(@"workspace",@"save failed!!!",nil);
}



@end
