/**
 * Created by will on 2017/3/7.
 */
import React, {Component} from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    TouchableHighlight,
    ToastAndroid,
} from 'react-native';
import {EngineType} from '../NativeModule/EngineType';
import  Workspace from '../NativeModule/Workspace.js';
import ServerMapView from '../NativeModule/components/SMMapViewUI.js';
import Point2D from '../NativeModule/Point2D';
var Utility = require('./../NativeModule/utility/utility');
var Point2DFac = new Point2D();


export default class Navigation2 extends Component{
    state = {
        pointType:0
    };

    _onGetInstance = (mapView) => {
        this.mapView=mapView;
        this._addMap();
    }

    /**
     * 初始化地图
     * @private
     */
    _addMap = () => {
        try{
            console.log('start initialize map'+new Date().getTime());

            //创建workspace模块对象
            var workspaceModule = new Workspace();

            //加载工作空间等一系列打开地图的操作
            (async function () {
                try{
                    this.workspace = await workspaceModule.createObj();

                    var datasource = await this.workspace.openDatasource("http://supermapcloud.com",EngineType.SuperMapCloud);
                    var dataset = await datasource.getDataset(0);

                    this.mapControl = await this.mapView.getMapControl();
                    console.log("mapControl"+this.mapControl.mapControlId);
                    this.map = await this.mapControl.getMap();

                    await this.map.setWorkspace(this.workspace);
                    // var mapName = await this.workspace.getMapName(0);

                    // await this.map.open(mapName);
                    this.map.addLayer(dataset,true);

                    await this.map.zoom(5000);
                    var point2D = await Point2DFac.createObj(12953693.6950684, 4858067.04711915);
                    await this.map.setCenter(point2D);
                    await this.map.refresh();

                    this.traditionalNavi = await this.mapControl.getTraditionalNavi();
                    console.log("index:traditionalNavi:" + this.traditionalNavi.traditionalNaviId);
                    // 监听长按，设置图标
                    await this.mapControl.setGestureDetector({longPressHandler:(e) => {
                        var mapPoint = null;
                        (async function () {
                            try{
                                if(this.state.pointType === 0){
                                    var urlAsset = require('./../NativeModule/resource/startpoint.png');
                                    mapPoint = await this._longPressHandler(urlAsset,'startpoint',e.x,e.y);
                                    this.startpoint = {x:mapPoint.x,y:mapPoint.y}
                                }else if(this.state.pointType === 1){
                                    var urlAsset = require('./../NativeModule/resource/destpoint.png');
                                    mapPoint = await this._longPressHandler(urlAsset,'destpoint',e.x,e.y);
                                    this.destpoint = {x:mapPoint.x,y:mapPoint.y}
                                }
                            }catch (e){
                                console.error(e);
                            }
                        }).bind(this)();
                    }}) ;

                    // 加载路网数据
                    var connectSuccess = await this.traditionalNavi.connectNaviData("/SampleData/NaviData");
                    console.log("index:connectSuccess " + connectSuccess);

                    // await this.navigation2.setPathVisible(true);
                    // await this.navigation2.setNetworkDataset(roadworkDV);
                    // await this.navigation2.loadModel("/SampleData/Navigation2Data/netModel.snm");
                }catch(e){
                    console.error(e);
                }
            }).bind(this)();
        }catch (e){
            console.error(e);
        }
    }

    //设置起点
    _start = () => {
        this.setState({
            pointType:0,
        });
    }

    //设置终点
    _dest = () => {
        this.setState({
            pointType:1,
        })
    }

    //路径分析
    _route = async () => {
        try{
            await this.traditionalNavi.setStartPoint(this.startpoint.x,this.startpoint.y,this.map);
            await this.traditionalNavi.setDestinationPoint(this.destpoint.x,this.destpoint.y,this.map);
            await this.traditionalNavi.routeAnalyst(0);
        }catch (e){
            console.log(e);
        }
    }

    //开始导航
    _guide = async () => {
        try{
            await this.traditionalNavi.startGuide(1);
        }catch (e){
            console.error(e);
        }
    }
    /**
     * 长按出图效果
     * @param callout - 图片资源
     * @param x - X坐标
     * @param y - y坐标
     * @returns {Promise.<void>}
     */
    _longPressHandler = async (uriAsset,calloutName,x,y) => {
        try{
            var arr = this.refs['mapView'].state.callouts;
            var mapPoint = await Utility.Point2Map(this.map,x,y);
            this.state.pointType ? this.destpoint = {x:mapPoint.x,y:mapPoint.y} : this.startpoint = {x:mapPoint.x,y:mapPoint.y}
            var callout = {uri:uriAsset,name:calloutName,mapX:mapPoint.x,mapY:mapPoint.y}  //图片资源

            // 防止重复添加起点或终点
            var calloutIndex = null;
            arr.map(function (c,index) {
                if(c.name === callout.name) calloutIndex = index;
            });
            console.log('calloutIndex:' + calloutIndex);

            if(calloutIndex == null){
                arr.push(callout); //该点尚未存在，则新增
            }else {
                arr[calloutIndex] = callout;  //该点已经存在，则替换
            }

            console.log('arr:' + arr);
            this.refs['mapView'].setState({
                callouts:arr,
            });

            return mapPoint;
        }catch (e){
            console.error(e);
        }
    }


    render() {
        return (
            <View style={styles.container}>
                <ServerMapView ref="mapView" style={styles.map} onGetInstance={this._onGetInstance}/>
                <View style={styles.controlPanel}>
                    <TouchableHighlight style={styles.geoButton} onPress={this._start}>
                        <Text style={styles.textLabel}>start</Text>
                    </TouchableHighlight>
                    <TouchableHighlight style={styles.geoButton} onPress={this._dest}>
                        <Text style={styles.textLabel}>dest</Text>
                    </TouchableHighlight>
                    <TouchableHighlight style={styles.geoButton} onPress={this._route}>
                        <Text style={styles.textLabel}>route</Text>
                    </TouchableHighlight>
                    <TouchableHighlight style={styles.geoButton} onPress={this._guide}>
                        <Text style={styles.textLabel}>guide</Text>
                    </TouchableHighlight>
                    <TouchableHighlight style={styles.geoButton} onPress={this._stop}>
                        <Text style={styles.textLabel}>stop</Text>
                    </TouchableHighlight>
                </View>
            </View>
        );
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
        flex: .9,
        alignSelf: 'stretch',
    },
    controlPanel:{
        flex:.1,
        flexDirection:'row',
        alignItems:'stretch',
        position:'absolute',
        left:10,
        right:10,
        bottom:10,
        opacity:.6,
        height:40,
    },
    geoButton:{
        backgroundColor:'#000000',
        margin:5,
        borderRadius: 5,
        flex:1,
        flexDirection:'row',
        justifyContent:'center',
        alignItems:'center',
    },
    textLabel:{
        color:'white',
    }
});