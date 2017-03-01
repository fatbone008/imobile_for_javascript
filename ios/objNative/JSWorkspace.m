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
#import "SuperMap/DatasourceConnectionInfo.h"
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

RCT_REMAP_METHOD(openLocalDatasource,openLocalDatasourceByKey:(NSString*)key andPath:(NSString*)path andEngineType:(int)type resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    Datasources* dataSources = workspace.datasources;
    DatasourceConnectionInfo* info = [[DatasourceConnectionInfo alloc]init];
    if(workspace&&info){
        info.server = path;
        info.engineType = type;
        Datasource* dataSource = [dataSources open:info];
        resolve(@"open");
    }else
        reject(@"workspace",@"open LocalDatasource failed!",nil);
}

RCT_REMAP_METHOD(openDatasource,openDatasourceByKey:(NSString*)key andPath:(NSString*)path andEngineType:(int)type andDriverStr:(NSString*)driver resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    Datasources* dataSources = workspace.datasources;
    DatasourceConnectionInfo* info = [[DatasourceConnectionInfo alloc]init];
    if(workspace&&info){
        info.server = path;
        info.engineType = type;
        info.driver = driver;
        Datasource* dataSource = [dataSources open:info];
        resolve(@"open");
    }else
        reject(@"workspace",@"open LocalDatasource failed!",nil);
}
/////////!!!!!!!!!!!!!
//RCT_REMAP_METHOD(openWMSDatasource,openDatasourceByKey:(NSString*)key andServer:(NSString*)server andEngineType:(int)type andDriverStr:(NSString*)driver andVersionStr:(NSString*)version andVisableLayers:(NSString*)vLayers andWebBox:(NSString*)w resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
//    Workspace* workspace = [JSObjManager getObjWithKey:key];
//    Datasources* dataSources = workspace.datasources;
//    DatasourceConnectionInfo* info = [[DatasourceConnectionInfo alloc]init];
//    if(workspace&&info){
//        info.server = path;
//        info.engineType = type;
//        info.driver = driver;
//        Datasource* dataSource = [dataSources open:info];
//        resolve(@"open");
//    }else
//        reject(@"workspace",@"open LocalDatasource failed!",nil);
//}

RCT_REMAP_METHOD(saveWorkspace,saveWorkspaceByKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Workspace* workspace = [JSObjManager getObjWithKey:key];
  if(workspace){
    BOOL saved = [workspace save];
      NSNumber* nsSaved = [NSNumber numberWithBool:saved];
      resolve(@{@"saved":nsSaved});
  }else
    reject(@"workspace",@"save failed!!!",nil);
}

RCT_REMAP_METHOD(closeWorkspace,closeWorkspaceByKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  Workspace* workspace = [JSObjManager getObjWithKey:key];
  if(workspace){
    [workspace close];
      NSNumber* nsClosed = [NSNumber numberWithBool:TRUE];
    resolve(@{@"closed":nsClosed});
  }else
    reject(@"workspace",@"close failed!!!",nil);
}

#pragma mark - 原datasources类放法

RCT_REMAP_METHOD(createDatasource,createDatasourceByKey:(NSString*)key andFilePath:(NSString*)path andEngineType:(int)type resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    Datasources* dataSources = workspace.datasources;
    if(dataSources){
        DatasourceConnectionInfo* info = [[DatasourceConnectionInfo alloc]init];
        info.server = path;
        info.engineType = type;
        Datasource* dataSource = [dataSources create:info];
        [JSObjManager addObj:dataSource];
        NSInteger jsKey = (NSInteger)dataSource;
        resolve(@{@"datasourceId":@(jsKey).stringValue});
    }else
        reject(@"workspace",@"create Datasource failed!!!",nil);
}

RCT_REMAP_METHOD(closeDatasource,closeDatasourceByKey:(NSString*)key andDatasourceName:(NSString*)name resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    Datasources* dataSources = workspace.datasources;
    if(dataSources){
        BOOL closed = [dataSources closeAlias:name];
        NSNumber* nsClosed = [NSNumber numberWithBool:closed];
        resolve(@{@"closed":nsClosed});
    }else
        reject(@"workspace",@"close Datasource failed!!!",nil);
}

RCT_REMAP_METHOD(closeAllDatasource,closeAllDatasourceByKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    Datasources* dataSources = workspace.datasources;
    if(dataSources){
        [dataSources closeAll];
        resolve(@"closed");
    }else
        reject(@"workspace",@"close all Datasource failed!!!",nil);
}

#pragma mark - 原maps类方法

RCT_REMAP_METHOD(removeMap,removeMapByKey:(NSString*)key andMapName:(NSString*)name resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    Maps* maps = workspace.maps;
    if(maps){
        BOOL removed = [maps removeMapName:name];
        NSNumber* nsRemoved = [NSNumber numberWithBool:removed];
        resolve(@{@"removed":nsRemoved});
    }else
        reject(@"workspace",@"remove map by name failed!!!",nil);
}

RCT_REMAP_METHOD(clearMap,clearMapByKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    Workspace* workspace = [JSObjManager getObjWithKey:key];
    Maps* maps = workspace.maps;
    if(maps){
        [maps clear];
        resolve(@"cleared");
    }else
        reject(@"workspace",@"clear map failed!!!",nil);
}

#pragma mark - ios
RCT_REMAP_METHOD(dispose,disposeKey:(NSString*)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  
  Workspace* workspace = [JSObjManager getObjWithKey:key];
  if(workspace){
    [workspace dispose];
    resolve(@"1");
  }else
    reject(@"workspace",@"save failed!!!",nil);
}



@end
