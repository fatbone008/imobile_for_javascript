/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  ListView,
  TouchableHighlight,
  DeviceEventEmitter
} from 'react-native';
import {
  SMMapView,
  Workspace,
  Point2D,
  Rectangle2D,
  QueryParameter,
  ScaleView,
  Legend,
} from 'imobile_for_javascript';
//范围查询：查询指定图层在指定范围内的几何对象
export default class JSimobilePackageProject extends Component {
  constructor(props) {
    super(props);
    var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
    this.state = {
    dataSource: ds.cloneWithRows(['row 1', 'row 2']),
    isList:false,
      selectText : "-- 请选择图层 --",
    }
  }
  
  _onGetInstance = (mapView) => {
    this.mapView = mapView;
    this._addMap();
  }
  
  render() {
    return (
            <View style={styles.container}>
            <SMMapView ref="mapView" style={styles.map} onGetInstance={this._onGetInstance}/>
            <View style={styles.controlPanel}>
            <TouchableHighlight style={styles.layer_button} onPress={this._openListView}>
            <Text style={styles.button_text}>{this.state.selectText}</Text>
            </TouchableHighlight>
            {this.state.isList &&
            <ListView style={styles.listView}
            dataSource={this.state.dataSource}
            renderRow={(rowData) => <Text style={styles.button_text}
            onPress={()=>this._layerSelected(rowData)}>
            {rowData}
            </Text>
            }
            />
            
            }
            {!this.state.isList &&
            <TouchableHighlight style={styles.search_button} onPress={this._search}>
            <Text style={styles.button_text}>查询</Text>
            </TouchableHighlight>
            }
            </View>
            </View>
            );
  }
  
  _addMap = () => {
    var workspaceModule = new Workspace();
    var scaleviewModule = new ScaleView();
    var legendMoudle = new Legend();
    (async function() {
     this.workspace = await workspaceModule.createObj();
     this.mapControl = await this.mapView.getMapControl();
     /* 比例尺添加*/
     this.scaleview = await scaleviewModule.createObj(this.mapControl);
     await this.scaleview.setShowEnable('true');
      
     this.map = await this.mapControl.getMap();
     /* 地图加载完成回调测试
     this.map.setMapLoadedListener(
                                   function(){
                                   console.log('test success');
                                   }
     );
      */
     await this.map.setWorkspace(this.workspace);
     
     //打开工作空间
     await this.workspace.open("/Documents/World.smwu");
     //获取数据源(Datasets对象不再对外开放)
     this.datasource = await this.workspace.getDatasource(0);
     //打开地图
     var mapName = await this.workspace.getMapName(0);
     await this.map.open(mapName);
     /*添加图例
     this.legend = await legendMoudle.createObjWithMap(this.map);
     await this.legend.show('true');
      */
     
     //获取所有图层(Layers不再对外开放）
     var layer;
     var layerName;
     var layersArray = [];
     var nCount = await this.map.getLayersCount();
     console.log(nCount);
     
     for(var i = 0;i < nCount; i++) {
     layer = await this.map.getLayer(i);
     layerName = await layer.getName(i);
     layersArray[i] = layerName;
     }
     this.setState ({
                    dataSource: this.state.dataSource.cloneWithRows(layersArray),
                    });
     
     
     await this.map.refresh();
     }).bind(this)();
  }
  
  //在指定图层对应的数据集中查询在指定范围内的对象
  _search = async  () => {
    if(this.state.selectText == "-- 请选择图层 --") {
      console.log("未选择图层");
      return ;
    }
    
    
    try {
      var layer = await this.map.getLayer(this.state.selectText);
      var dataset = await layer.getDataset();
      var datasetVector = await dataset.toDatasetVector();
      var bounds = await this._getBounds();
      bounds.geometryId = bounds.rectangle2DId;
      
      var parameterMoudle = new QueryParameter();
      var parameter = await parameterMoudle.createObj();
//      await parameter.setSpatialQueryObject(bounds);
      await parameter.setAttributeFilter("SMID<=16");
      var recordset = await datasetVector.query(parameter);
      // var recordset = await datasetVector.queryInBuffer(bounds,2);
      console.log()
      var nCount = await recordset.getRecordCount();
      console.log(nCount);
      
    } catch (e) {
      console.error(e);
    }
  }
  
  _getBounds = async () => {
    var point = await new Point2D();
    var point1 = await point.createObj(86.342145,44.7582113);
    var point2 = await point.createObj(113.254687,28.325416);
    var rectangleObj = await new Rectangle2D();
    var bounds = await rectangleObj.createObj(point1,point2);
    return bounds;
  }
  _openListView = () => {
    this.setState({
                  isList: !this.state.isList,
                  });
  }
  
  _layerSelected = (text) => {
    this.setState ({
                   isList: false,
                   selectText: text,
                   });
  }
  
}

const styles = StyleSheet.create({
                                 container: {
                                 flex: 1,
                                 justifyContent: 'center',
                                 alignItems: 'center',
                                 backgroundColor: '#F5FCFF',
                                 },
                                 map: {
                                 //flex：flex＝2，则该组件的宽度为flex＝1组件宽度的两倍
                                 flex: 1,
                                 //alightSelf:设置单独组件的竖直对齐方式，与alighItem有点像。auto按照自身设置的宽高来显示，如果没设置，效果跟streth一样；flex－start与父容器顶部对齐；flex－end与父容器底部对齐；center位于垂直位置；stretch垂直拉伸
                                 alignSelf: 'stretch',
                                 //flexWrap：nowrap即使空间不够也不换行；wrap空间不够自动换行；
                                 },
                                 controlPanel:{
                                 position:'absolute',
                                 top:10,
                                 left:10,
                                 opacity:.6,
                                 },
                                 layer_button: {
                                 borderRadius: 5,
                                 backgroundColor: '#333333',
                                 height: 30,
                                 width: 250,
                                 padding: 2,
                                 marginBottom:2,
                                 },
                                 search_button: {
                                 borderRadius: 5,
                                 backgroundColor: '#333333',
                                 height: 30,
                                 width: 80,
                                 padding: 2,
                                 marginBottom:2,
                                 },
                                 button_text: {
                                 textAlign: 'center',
                                 color: '#ffffff',
                                 padding:3,
                                 },
                                 listView: {
                                 backgroundColor: '#333333',
                                 width: 250,
                                 },
                                 });

AppRegistry.registerComponent('JSimobilePackageProject', () => JSimobilePackageProject);
