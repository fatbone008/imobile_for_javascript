//
//  Layer3Ds.h
//  Realspace
//
//  版权所有 （c）2013 北京超图软件股份有限公司。保留所有权利。
//

#import <Foundation/Foundation.h>
#import "Layer3DType.h"

@class Layer3D;

/** 三维图层集合类。
 <p> 该类对一个三维场景中的所有三维图层进行管理。
 <p> 一个三维场景窗口对应一个三维场景，即一个三维场景窗口中只能显示一个三维场景，一个三维场景相应的有一个三维图层集合，由三维图层集合负责管理三维场景中显示的所有三维图层。
 <p> 三维图层集合类提供了三维图层的添加，删除，移动，查找等方法，可以实现向三维场景中添加各种类型的三维图层，将不需要显示在三维场景中的三维图层移除，查找三维场景中是否包含指定名称的三维图层以及调整三维场景中各个三维图层的叠放次序等。
 */
@interface Layer3Ds : NSObject

/**@brief 返回三维图层集合中指定索引的三维图层对象，三维图层集合中三维图层的索引从0开始编号。
 @param  index 要查找的三维图层对象的索引。
 @return  三维图层集合中指定索引的三维图层对象。
 */
- (Layer3D *)getLayerWithIndex:(NSInteger)index;

/**@brief 返回三维图层集合中指定名称的三维图层对象。
 @param  name 要查找的三维图层对象的名称。
 @return  三维图层集合中指定名称的三维图层对象。
 */
- (Layer3D *)getLayerWithName:(NSString *)name;

/**@brief 返回给定的三维图层集合中三维图层对象的总数。
 @return  给定的三维图层集合中三维图层对象的总数。
 */
- (NSInteger)count;
@end
