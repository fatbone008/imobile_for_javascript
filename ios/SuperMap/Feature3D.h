//
//  Feature3D.h
//  Realspace
//
//  版权所有 （c）2013 北京超图软件股份有限公司。保留所有权利。
//

#import <Foundation/Foundation.h>


///三维要素类。
@interface Feature3D : NSObject

/**@brief 返回三维要素对象指定字段序号对应的字段值。
 @param  index 指定的字段序号。
 @return  字段值。
 */
- (NSObject *)getFieldValueWithIndex:(NSInteger)index;

/**@brief 返回三维要素对象指定字段名称对应的字段值。
 @param  name 指定的字段名称。
 @return  字段值。
*/
- (NSObject *)getFieldValueWithString:(NSString *)name;
@end
