//
//  JSCallOutManager.m
//  Supermap
//
//  Created by 王子豪 on 2017/3/15.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "JSCallOutManager.h"
#import "SuperMap/CallOut.h"
@implementation JSCallOutManager
RCT_EXPORT_MODULE(RCTCallOut);
-(UIView*)view{
    Callout* calloutView = [[Callout alloc]init];
    return (UIView*)calloutView;
}
@end
