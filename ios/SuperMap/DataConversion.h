//
//  DataConversion.h
//  LibUGC
//
//  Created by R3 on 14-8-12.
//  Copyright (c) 2014年 beijingchaotu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Datasource.h"
#import "Charset.h"
/**
 * 文件转换类。
 *
 *<p> 该类为文件导入导出提供方法。
 * <p> 这些方法针对具体的数据文件类型（目前支持shape和mif型文件），用于将该类文件倒入数据源和将数据源中一数据集导出成该类型文件。
 * 文件转换类方法均为静态方法，调用时无需创建该类实例
 */



@interface DataConversion : NSObject

/**
 * @brief 设置文件字符集。
 @param  value 导出生成文件或倒入源文件的字符集。默认为GB18030。
               导出时该字段（即设置的导出生成文件的字符集）与被导出数据的字符集不匹配，在导出生成文件中将会出现文字乱码情况。
               导入时该字段（即设置的读取导人文件的字符集）与导入文件本身的字符集不匹配，在倒入后的数据集中会出现文字乱码情况
  */
+(void)setConvertCharset:(Charset)value;

/**
 * @brief shape文件倒入方法。将指定路径对应的shape文件倒入成指定数据源中的同名数据集。
    @param  filePath 指定倒入的shape文件路径。
    @param  datasource 将文件倒入到的数据源。
 */
+(BOOL)importSHPFile:(NSString *)filePath toDatasource:(Datasource *)datasource;

/**
 * @brief shape文件倒出方法。将指定数据集导出到沙盒目录下生成／覆盖名为指定名称的文件。
 @param  fileName 指定倒出文件名，若无.shp后缀，方法将自动添加。
 @param  dataset 指定导出的数据集。
 */
+(BOOL)exportSHPNamed:(NSString *)fileName fromDataset:(Dataset *)dataset;

/**
 * @brief mif文件倒入方法。将指定路径对应的mif文件倒入成指定数据源中的同名数据集。
 @param  filePath 指定倒入的mif文件路径。
 @param  datasource 将文件倒入到的数据源。
 */
+(BOOL)importMIFFile:(NSString *)filePath toDatasource:(Datasource *)datasource;

/**
 * @brief mif文件倒出方法。将指定数据集导出到沙盒目录下生成／覆盖名为指定名称的文件。
 @param  fileName 指定倒出文件名，若无.mif后缀，方法将自动添加。
 @param  dataset 指定导出的数据集。
 */
+(BOOL)exportMIFNamed:(NSString *)fileName fromDataset:(Dataset *)dataset;

@end
