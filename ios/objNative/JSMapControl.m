//
//  JSMapControl.m
//  rnTest
//
//  Created by imobile-xzy on 16/7/11.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "JSMapControl.h"
#import "SuperMap/MapControl.h"
#import "SuperMap/Action.h"
#import "JSObjManager.h"

#import <React/RCTEventDispatcher.h>

#import <React/RCTConvert.h>
#import <React/UIView+React.h>
#import <objc/runtime.h>
#import <React/RCTUIManager.h>
#import <React/RCTWebView.h>

@interface MapControl(ReactCategory)

@property (nonatomic, strong) JSMapControl *jsMapControl;
@property (nonatomic, copy) RCTBubblingEventBlock onChange;
@end

@implementation MapControl (ReactCategory)


-(void)setJsMapControl:(JSMapControl *)jsMapControl{
  objc_setAssociatedObject(self, @selector(jsMapControl), jsMapControl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(JSMapControl*)jsMapControl{
  return (JSMapControl *)objc_getAssociatedObject(self, @selector(jsMapControl));
}

-(void)setOnChange:(RCTBubblingEventBlock)onChange{
  objc_setAssociatedObject(self, @selector(onChange), onChange, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  if(self.onChange)
  {
    self.onChange(@{@"mapViewId":@((NSUInteger)self).stringValue});
  }
}
-(RCTBubblingEventBlock)onChange{
  return (RCTBubblingEventBlock)objc_getAssociatedObject(self, @selector(onChange));
}
@end

@implementation JSMapControl
//注册为Native模块
RCT_EXPORT_MODULE(RCTMapView)
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)

- (instancetype)init
{
  self = [super init];
  if (self) {
  }
  return self;
}
- (UIView *)view
{
  MapControl* mapControl = [[MapControl alloc]init];
  mapControl.jsMapControl = self;
  [JSObjManager addObj:mapControl];

  return mapControl;
}

@end
