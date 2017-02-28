//
//  TerrainLayers.h
//  Realspace
//
//  版权所有 （c）2013 北京超图软件股份有限公司。保留所有权利。
//

#import <Foundation/Foundation.h>
@class TerrainLayer;
/**
 * @brief 三维地形图层集合类。
 */
@interface TerrainLayers : NSObject

/**
 * @brief 返回给定的三维地形图层集合中三维图地形层对象的总数。
 */
@property (nonatomic,readonly)NSInteger count;

/**
 * @brief 返回三维地形图层集合中指定索引的三维地形图层对象，三维地形图层集合中三维地形图层的索引从0开始编号。
 *
 * @param index 要查找的三维地形图层对象的索引。
 * @return 三维地形图层集合中指定索引的三维地形图层对象。
 */
- (TerrainLayer *)getLayerWithIndex:(NSInteger)index;

/**
 * @brief 返回三维地形图层集合中指定名称的三维地形图层对象。
 *
 * @param name 要查找的三维地形图层对象的名称。
 * @return 三维地形图层集合中指定名称的三维地形图层对象。
 */
- (TerrainLayer *)getLayerWithName:(NSString *)name;

@end
