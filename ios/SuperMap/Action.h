//
//  Action.h
//  Visualization
//
//  版权所有 （c）2013 北京超图软件股份有限公司。保留所有权利。
//

/** 该类定义了地图操作状态类型常量。
*
*  完成与地图显示有关的操作设置。通常与地图显示有关的操作包括地图的漫游以及简单的编辑操作如画点、画线、画面等。
*/
typedef enum {
    /// 空操作。
    NONEACTION = 0,   
    
	/** 地图漫游。
	*
	*  在对地图进行漫游操作时，首先将显示窗口内的地图转换成位图，在操作过程中，使用位图显示，操作结束后，使用真实数据显示。这种漫游速度较快。
	*/ 
	PAN = 1,
    
	///  在编辑模式下，长按选择对象，可对选中的对象进行编辑。
	SELECT = 8,
    
    /// 在可编辑图层中编辑对象的节点。
	VERTEXEDIT = 54,
    
    /// 在可编辑图层中为对象添加节点。
    VERTEXADD = 55,
    
    /// 在可编辑图层中删除对象的节点。
    DELETENODE= 500,
    
    /// 在可编辑图层中画点。
    CREATEPOINT = 1001,
    
	/// 在可编辑图层中画直线。
    CREATELINE = 1002,
    
	/// 在可编辑图层中画矩形。
    CREATERECTANGLE = 1003,
    
	/// 在可编辑图层中画折线。
    CREATEPOLYLINE = 1004,
	
	/// 在可编辑图层中画多边形。
    CREATEPOLYGON = 1005,
	
	/// 在可编辑图层中画两点圆。
    CREATE_CIRCLE_2P = 1006,
    
	/// 在可编辑图层中画椭圆。
    CREATEELLIPSE = 1009,
    
    ///  自由线。
    CREATE_FREE_POLYLINE = 1011,
    
    ///  自由绘制。
    CREATE_FREE_DRAWPOLYGON = 1012,
    
    ///  自由绘制。
    CREATE_FREE_DRAW = 1019,
    
    /// 量算长度。
    MEASURELENGTH = 2001,
    
	/// 量算面积。
	MEASUREAREA =  2002,
    
    //态势标绘
    CREATE_PLOT = 3000,
    
}Action;
