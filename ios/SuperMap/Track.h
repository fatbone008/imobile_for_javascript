//
//  Track.h
//  LibUGC
//
//  Created by iMobile2D on 14-8-16.
//  Copyright (c) 2014年 beijingchaotu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatasetVector.h"

@interface Track : NSObject

// 设置轨迹数据集
@property (nonatomic, strong) DatasetVector* dataset;

// 设置匹配的线数据集集合
@property (nonatomic, strong) NSArray* matchDatasets;

// 设置获取定位点的时间间隔,单位:秒。
// 小于20秒设置失败，设置成功则20秒开启一次定位，以节省电量。
// 如果设置时间间隔成功，则不抓路。
@property (nonatomic,assign) int timeInterval;

// 设置存入数据集的定位点的距离间隔，单位为米。
@property (nonatomic,assign) double distanceInterval;


// 创建符合记录轨迹点规则的数据集
+(DatasetVector*)creatDataset:(Datasource*)datasource DatasetName:(NSString*)datasetName;

-(id)init;

-(BOOL)startTrack;
-(void)stopTrack;


@end
