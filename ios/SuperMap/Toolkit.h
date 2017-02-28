//
//  Toolkit.h
//  Visualization
//
//  版权所有 （c）2013 北京超图软件股份有限公司。保留所有权利。
//

#import "Geometry.h"
#import "EncodeType.h"
@class Geometry;
@class Workspace;
//@class UIImage;
const double DBL_MAX_VALUE = 1.7976931348623157e+308;

const double DBL_MIN_VALUE = -1.7976931348623157e+308;

const float FLT_MAX_VALUE = (float) 3.4028235e+038;

const  float FLT_MIN_VALUE = (float) -3.4028235e+038;

/**   工具包类。
*
* <P>提供一些辅助计算功能。例如：判断给定值是否为零的重载方法等。</p>
*/
@interface Toolkit : NSObject

/** 判断 value 是否为零值， 使用  <Environment> 里设定的容限。
* 
* <P>其中 <Environment>  类中定义的判断精度有零值判断精度和默认零值判断精度，这里使用的是默认零值判断精度，就是系统给定的零值判断精度。详细信息请参见 <Environment>  类型。</p>
* @param value 要测试的值。
* @return 如果 value 为零值，返回 true;否则返回 false。
*/
+(BOOL)isZero:(double)value;

/**
* 判断给定的value是否为零值，使用 precision 做为判断精度。
* @param value 要测试的值。
* @param precision 用户给定的零值判断精度。
* @return 一个布尔值，true 表示 value 值为零值，false 表示为非零值。
*/
+(BOOL)isZero:(double)value Precision:(double)precision; 

/**
* 判断 value 是否为零值，使用最小判断精度（minPrecision）和最大判断精度（maxPrecision）作为判断容限。
* @param value 要测试的值。
* @param minPrecision 指定的最小判断精度，即左判断精度，为判断容限的下限。
* @param maxPrecision 指定的最大判断精度，即右判断精度，为判断容限是上限。
* @return 一个布尔值，true 表示 value 值为零值，false 表示为非零值。
*/
+(BOOL)isZero:(double)value Min:(double)minPrecision Max:(double)maxPrecision;

//+(UIImage *)draw:(Geometry *)geometry Workspace:(Workspace *)workspace ImageSize:(CGSize)imagesize;

+(BOOL) isValidEncodeType:(BOOL)isVector encodeType:(EncodeType)encodeType;

@end
