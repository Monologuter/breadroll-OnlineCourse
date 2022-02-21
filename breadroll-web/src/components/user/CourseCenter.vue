<template>
  <div class="course-content">
    <h2 class="header">我的课程</h2>
    <ul v-if="courseData!=null && courseData.length!==0">
      <li class="course-info" v-for="(course,index) in courseData" :key="index">
        <el-image :src="course.coverUrl"></el-image>
        <h2 class="title">{{course.courseName}}</h2>
        <p class="desc">{{course.description}}</p>
        <div class="course-state">
          <el-tag class="time-length" size="small"><i class="el-icon-time" style="margin-right: 4px;"/>{{course.courseTime,course.courseSecond | changeHourMin}}</el-tag>
          <el-tag class="state" v-if="course.vipState" type="warning" size="small">VIP课程</el-tag>
          <el-tag class="state" v-else type="success" size="small">免费课程</el-tag>
        </div>
        <div class="operate-course">
          <el-button type="primary" size="small" @click="watchCourse(course.courseId)">观看课程</el-button>
          <el-button type="danger" size="small" @click="exitCourse(course.courseId)">退出课程</el-button>
        </div>
      </li>
    </ul>
    <div v-else class="no-course">
      <el-image :src="noCourseImg"></el-image>
      <h2>暂无课程信息，快去加入课程吧</h2>
    </div>
    <el-pagination
      class="page"
      v-if="courseData!=null && courseData.length!==0"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="queryData.pageNum"
      :page-sizes="[5, 10, 20, 50]"
      :page-size="queryData.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="queryData.total">
    </el-pagination>
  </div>
</template>

<script>
  export default {
    name: "CourseCenter",
    data() {
      return{
        noCourseImg:require("../../assets/global/no-course.png"),
        courseData:[],
        queryData:{
          pageNum:1,
          pageSize:5,
          total:0,
        },
      }
    },
    methods:{
      handleSizeChange(val) {
        this.queryData.pageSize=val;
        this.reqInfo();
      },
      //修改当前页
      handleCurrentChange(val) {
        this.queryData.pageNum=val;
        this.reqInfo();
      },
      //观看课程
      watchCourse(courseId){
        this.$router.push({ path: '/courseDetail', query: {id:courseId}});
      },
      //退出课程
      exitCourse(courseId){
        this.$userApi.exitUserCourse(courseId).then(res=>{
          this.$message.success(res.message);
          this.reqInfo();
        });
      },
      reqInfo(){
        this.$userApi.queryUserCourse(this.queryData).then(res=>{
          this.courseData = res.data.list;
          this.queryData.total = res.data.total;
        });
      }
    },
    created(){
      this.reqInfo();
    }
  }
</script>

<style scoped>
  .course-content{
    overflow: hidden;
    padding-top: 20px;
    border-radius: 8px;
    background-color: #ffffff;
    margin-bottom: 50px;
    border: 1px solid #e6e6e6;
  }

  .course-content .header{
    margin-top: 0;
    padding-left: 30px;
    padding-bottom: 16px;
    margin-bottom: 16px;
    border-bottom: 1px solid #e6e6e6;
  }

  .course-content>ul{
    padding: 10px 30px 0;
    width: auto;
    list-style: none;
    margin: 0;
  }

  .course-content .course-info{
    position: relative;
    height: 156px;
    width: auto;
    color: #333333;;
    transition: all 0.5s;
    text-align: left;
    padding-bottom: 20px;
    margin-bottom: 20px;
    border-bottom: 1px solid #ededed;
  }

  .course-content .course-info:hover{
    color: #40a9ff;
  }

  .course-content .course-info .el-image{
    width: 290px;
    height: 100%;
    margin-right: 20px;
    border-radius: 10px;
    overflow: hidden;
    display: flex;
    position: relative;
  }

  .course-content .course-info>.title{
    position: absolute;
    top: 0;
    margin: 16px 0;
    padding: 0;
    left: 310px;
    font-size: 18px;
    font-family: 'PingFangSC', sans-serif;
  }

  .course-content .course-info .desc{
    position: absolute;
    top: 49px;
    left: 310px;
    margin: 0;
    font-size: 14px;
    text-align: justify;
    width: 68%;
    height: 40px;
    line-height: 20px;
    overflow: hidden;
    color: #999999;
    text-overflow: ellipsis;
    font-family: 'PingFangSC', sans-serif;
    display: -webkit-box;
    -webkit-box-orient: vertical;
  }

  .course-content .course-info .course-state{
    position: absolute;
    left: 310px;
    bottom: 40px;
  }

  .course-content .course-info .el-tag{
    font-size: 14px;
    margin-right: 10px;
  }

  .course-content .course-info .operate-course{
    position: absolute;
    right: 60px;
    bottom: 30px;
  }

  .course-content .page{
    padding: 5px 12px;
    background: rgb(255, 255, 255);
    margin: -10px auto 14px;
    text-align: center;
  }

  .course-content .no-course{
    text-align: center;
    height: 500px;
    width: 100%;
  }

  .course-content .no-course .el-image{
    height: 74%;
    width: 440px;
  }
</style>
