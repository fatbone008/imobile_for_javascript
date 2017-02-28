//
//  SceneControl+touch.h
//  LibUGC6R
//
//  Created by zhaoshuyu on 12-12-5.
//
//

#import "SceneControl.h"
#include "Scene/UGRoot3D.h"
#include "Scene/UGScene3D.h"
#include "Scene/UGFlyRoutes.h"
#include "Scene/UGLayer3DManager.h"
#include "Render/UGCameraWorld.h"
#include "Render/UGTerrainAccessor.h"
#include "Graphics3D/UGRenderTarget.h"
#include "Graphics3D/UGGraphics3D.h"
#include "SceneEditor/UGSceneEditorWnd.h"
#include "Stream/ugdefs.h"
#include "Render/UGRenderParameter.h"
#include "Scene/UGRoot3D.h"
#include "Scene/UGScene3D.h"
#include "Scene/UGFlyRoutes.h"
#include "Scene/UGLayer3DManager.h"
#include "Render/UGCameraWorld.h"
#include "Render/UGTerrainAccessor.h"
#include "Graphics3D/UGRenderTarget.h"
#include "Graphics3D/UGGraphics3D.h"
#include "Geometry3D/UGGeoPoint3D.h"
#include "SceneEditor/UGSceneEditorWnd.h"
#include "Stream/ugdefs.h"
#include "Render/UGRenderParameter.h"
#include "Layer3DFile/UGLayer3DVector.h"
@interface SceneControl () {
    UGC::UGRoot3D m_root3D;
    UGC::UGCameraWorld *pCamera;
    UGC::UGSceneEditorWnd *m_pSceneEditorWnd;
    UGC::UGFlyManager *flyManager;
    double _lastTotalLength;     // 此处记录上一次的量算长度，方便计算当前量算节点的长度
    CGRect rect;
    NSString *xmlPath;
    UITouch *_firstTouch;
    UITouch *_secondTouch;
    double _scale;
}

@property(nonatomic)double lastTotalLength;
@property(nonatomic)UGC::UGSceneEditorWnd *pSceneEditorWnd;
@end

@interface SceneControl (touch)
//{
//@public
//    UGC::UGSceneEditorWnd *mySceneEditorWnd;
//}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
