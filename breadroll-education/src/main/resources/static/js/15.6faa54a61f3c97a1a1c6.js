webpackJsonp([15],{QsZ0:function(t,e,a){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var r={render:function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"order-center"},[a("h2",{staticClass:"header"},[t._v("我的订单")]),t._v(" "),a("div",{staticClass:"gold-container"},[a("el-card",{staticClass:"gold-card",attrs:{shadow:"none"}},[a("div",{attrs:{slot:"header"},slot:"header"},[a("svg",{staticClass:"icon",staticStyle:{width:"31px",height:"31px","vertical-align":"middle"},attrs:{"aria-hidden":"true"}},[a("use",{attrs:{"xlink:href":"#iconrecord"}})]),t._v(" "),a("span",{staticStyle:{"font-weight":"600"}},[t._v("订单记录")])]),t._v(" "),a("el-table",{staticStyle:{width:"100%","margin-bottom":"20px","min-height":"283px"},attrs:{data:t.orderData,border:"",stripe:""}},[a("el-table-column",{attrs:{prop:"orderNo",label:"订单编号",width:"300"}}),t._v(" "),a("el-table-column",{attrs:{prop:"orderName",label:"订单名称",width:"300"}}),t._v(" "),a("el-table-column",{attrs:{prop:"createTime",label:"创建时间",width:"200"}}),t._v(" "),a("el-table-column",{attrs:{prop:"payPrice",label:"支付金额",width:"150"}}),t._v(" "),a("el-table-column",{attrs:{prop:"orderState",label:"订单状态"}})],1),t._v(" "),a("el-pagination",{staticClass:"page",attrs:{"current-page":t.queryData.pageNum,"page-sizes":[5,10,20,50],"page-size":t.queryData.pageSize,layout:"total, sizes, prev, pager, next, jumper",total:t.queryData.total},on:{"size-change":t.handleSizeChange,"current-change":t.handleCurrentChange}})],1)],1)])},staticRenderFns:[]};var n=a("VU/8")({name:"OrderCenter",data:function(){return{orderData:[],queryData:{pageNum:1,pageSize:10,total:0}}},methods:{handleSizeChange:function(t){this.queryData.pageSize=t,this.reqInfo()},handleCurrentChange:function(t){this.queryData.pageNum=t,this.reqInfo()},reqInfo:function(){var t=this;this.$userApi.queryMyOrder(this.queryData).then(function(e){t.orderData=e.data.list,t.queryData.total=e.data.total})}},created:function(){this.reqInfo()}},r,!1,function(t){a("a8mf"),a("ZSCb")},"data-v-5644a8d4",null);e.default=n.exports},ZSCb:function(t,e){},a8mf:function(t,e){}});
//# sourceMappingURL=15.6faa54a61f3c97a1a1c6.js.map