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
@interface NSObject (SpaceConvertor)
+(Camera)convertUGCamera:(UGC::UGCameraState&)ugCamera;
+(void)ConvertCamera:(Camera)camera UGCamera:(UGC::UGCameraState&)ugCamera;
+(double)ComputeAltitude:(double)distance Tilt:(double)tilt;
+(double)ComputeDistance:(double) altitude Tilt:(double) tilt;
@end
