//
//  JSSystemUtil.m
//  Supermap
//
//  Created by 王子豪 on 2017/3/28.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "JSSystemUtil.h"

@implementation JSSystemUtil
RCT_EXPORT_MODULE();
RCT_REMAP_METHOD(getHomeDirectory,getHomeDirectoryWithresolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
    NSString* home = NSHomeDirectory();
    if (home) {
        resolve(@{@"homeDirectory":home});
    }else{
        reject(@"systemUtil",@"get home directory failed",nil);
    }
}
@end
