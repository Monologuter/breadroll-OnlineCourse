webpackJsonp([13],{cxuZ:function(t,a,e){"use strict";Object.defineProperty(a,"__esModule",{value:!0});var s={name:"CoursePage",data:function(){return{noCourseImg:e("NdxS"),courseData:[],activeName:"first",tabName:"",index:0,queryData:{pageNum:1,pageSize:5,total:0}}},methods:{toCourseDetail:function(t){this.$router.push({path:"/courseDetail",query:{id:t.courseId}})},handleClick:function(t,a){var e=parseInt(t.index);this.index=e,this.reqInfo(e)},handleSizeChange:function(t){this.queryData.pageSize=t,this.reqInfo(this.index)},handleCurrentChange:function(t){this.queryData.pageNum=t,this.reqInfo(this.index)},reqInfo:function(t){var a=this;switch(t){case 0:this.$courseApi.queryAllCourse(this.queryData).then(function(t){a.courseData=t.data.list,a.queryData.total=t.data.total});break;case 1:this.$courseApi.queryCourseByTime(this.queryData).then(function(t){a.courseData=t.data.list,a.queryData.total=t.data.total});break;case 2:this.$courseApi.queryCourseByPlay(this.queryData).then(function(t){a.courseData=t.data.list,a.queryData.total=t.data.total});break;case 3:this.reqData()}},reqData:function(){var t=this;if(null!=this.$route.query.way)switch(this.tabName="",this.$route.query.way){case"0":this.activeName="third",this.index=2,this.reqInfo(this.index);break;case"1":this.activeName="second",this.index=1,this.reqInfo(this.index);break;case"2":this.tabName=this.$route.query.title,this.activeName="fourth",this.index=3,this.$courseApi.queryCourseByFree(this.queryData).then(function(a){t.courseData=a.data.list,t.queryData.total=a.data.total});break;case"type":this.tabName=this.$route.query.title,this.activeName="fourth",this.index=3,this.queryData.typeId=this.$route.query.id,this.$courseApi.queryCourseByType(this.queryData).then(function(a){t.courseData=a.data.list,t.queryData.total=a.data.total});break;case"name":this.tabName=this.$route.query.name,this.activeName="fourth",this.index=3,this.queryData.courseName=this.$route.query.name,this.$courseApi.queryCourseByName(this.queryData).then(function(a){t.courseData=a.data.list,t.queryData.total=a.data.total})}else this.$courseApi.queryAllCourse(this.queryData).then(function(a){t.courseData=a.data.list,t.queryData.total=a.data.total})}},watch:{$route:function(t,a){this.reqData()}},created:function(){this.reqData()}},i={render:function(){var t=this,a=t.$createElement,e=t._self._c||a;return e("div",{staticClass:"course-page"},[e("div",{staticClass:"course-container"},[e("el-image",{staticClass:"banner",attrs:{src:"https://static.wanmen.org/406cc4a6b08400394590d4f393d14970.jpg"}}),t._v(" "),e("div",{staticClass:"course-content"},[e("el-tabs",{staticStyle:{padding:"20px 30px 0"},on:{"tab-click":t.handleClick},model:{value:t.activeName,callback:function(a){t.activeName=a},expression:"activeName"}},[e("el-tab-pane",{attrs:{label:"全部课程",name:"first"}}),t._v(" "),e("el-tab-pane",{attrs:{label:"新品",name:"second"}}),t._v(" "),e("el-tab-pane",{attrs:{label:"最热",name:"third"}}),t._v(" "),e("el-tab-pane",{attrs:{label:t.tabName,name:"fourth"}})],1),t._v(" "),null!=t.courseData&&0!==t.courseData.length?e("ul",t._l(t.courseData,function(a,s){return e("li",{key:s,staticClass:"course-info animated bounceIn",on:{click:function(e){return t.toCourseDetail(a)}}},[e("el-image",{attrs:{src:a.coverUrl}}),t._v(" "),e("h2",{staticClass:"title"},[t._v(t._s(a.courseName))]),t._v(" "),e("p",{staticClass:"desc"},[t._v(t._s(a.description))]),t._v(" "),e("div",{staticClass:"course-state"},[e("el-tag",{staticClass:"time-length",attrs:{size:"small"}},[e("i",{staticClass:"el-icon-time",staticStyle:{"margin-right":"4px"}}),t._v(t._s(t._f("changeHourMin")(a.courseTime,a.courseSecond)))]),t._v(" "),a.vipState?e("el-tag",{staticClass:"state",attrs:{type:"warning",size:"small"}},[t._v("VIP课程")]):e("el-tag",{staticClass:"state",attrs:{type:"success",size:"small"}},[t._v("免费课程")]),t._v(" "),e("el-tag",{staticClass:"play-count",attrs:{type:"warning",size:"small"}},[e("i",{staticClass:"el-icon-view"}),t._v(" 播放量 "+t._s(a.playCount))])],1)],1)}),0):e("div",{staticClass:"no-course"},[e("el-image",{attrs:{src:t.noCourseImg}}),t._v(" "),e("h2",[t._v("抱歉，没有找到 “"),e("span",{staticStyle:{color:"#0088f0"}},[t._v(t._s(t.tabName))]),t._v("” 的相关课程")])],1),t._v(" "),null!=t.courseData&&0!==t.courseData.length?e("el-pagination",{staticClass:"page",attrs:{"current-page":t.queryData.pageNum,"page-sizes":[5,10,20,50,100,200],"page-size":t.queryData.pageSize,layout:"total, sizes, prev, pager, next, jumper",total:t.queryData.total},on:{"size-change":t.handleSizeChange,"current-change":t.handleCurrentChange}}):t._e()],1)],1)])},staticRenderFns:[]};var r=e("VU/8")(s,i,!1,function(t){e("tOx1"),e("yFkV")},"data-v-8434f63e",null);a.default=r.exports},tOx1:function(t,a){},yFkV:function(t,a){}});
//# sourceMappingURL=13.72bc303195822794dcf3.js.map