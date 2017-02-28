//
//  Routes.h
//  Realspace
//
//  版权所有 （c）2013 北京超图软件股份有限公司。保留所有权利。
//

#import <Foundation/Foundation.h>


 ///路线集合类。路线集合包含了零个或多个路线对象。 
@interface Routes : NSObject 

///获取或设置当前选中的路线，默认没有 Route 时为 -1，添加 Route 后则不再是非法值。
@property(nonatomic)NSInteger currentRouteIndex;

/// 获取路线集合中路线的个数。
@property(nonatomic,readonly)NSInteger count;

/**@brief 从指定的文件中导入路线集合对象。
 @param  filePath 指定的文件全路径。
 @return  导入成功返回 true，否则返回 false。
 */
- (BOOL)fromFile:(NSString *)filePath;

/**@brief 获取指定索引的Route的名字
 @param  index 路线索引。
 @return  返回路线名称
 */
- (NSString*) getRouteNameWithIndex:(NSInteger) index;

///清除路线集合中所有路线。
- (void)clear;
@end
