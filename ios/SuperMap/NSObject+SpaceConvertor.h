//
//  NSObject+SpaceConvertor.h
//  LibUGC6R
//
//  Created by zhaoshuyu on 13-3-20.
//
//

#import <Foundation/Foundation.h>
#import "Camera.h"
#include "Render/UGCameraWorld.h"
#include "Base3D/UGCommon3D.h"
#import "MultiViewportMode.h"

@interface NSObject (SpaceConvertor)
+ (Camera)eyeCamera:(UGC::UGCameraState&)ugCamera;
+ (void)convertEyeCamera:(Camera)camera UGCamera:(UGC::UGCameraState&)ugCamera;
+(Camera)convertUGCamera:(UGC::UGCameraState&)ugCamera;
+(void)ConvertCamera:(Camera)camera UGCamera:(UGC::UGCameraState&)ugCamera;
+(double)ComputeAltitude:(double)distance Tilt:(double)tilt;
+(double)ComputeDistance:(double) altitude Tilt:(double) tilt;

/**
 *  组件多视口枚举和底层多视口枚举类型转换方法
 */

+ (UGC::MultiViewportMode)modeWithViewPortMode:(RealspaceMultiViewportMode)mode;
+ (RealspaceMultiViewportMode)modeWithUGCViewportMode:(UGC::MultiViewportMode)mode;

@end
