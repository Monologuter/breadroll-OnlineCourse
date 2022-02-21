<!--特训班-->
<template>
  <div class="training">
    <div class="training-container">
      <div class="training-content">
        <h2>特训班</h2>
        <ul>
          <li class="training-box" v-for="(course,index) in specialTraining" :key="index" @click="toCourseDetail(course)">
            <el-image style="display: block;width: 100%;height: 336px" :src="course.coverUrl"></el-image>
            <div class="training-info">
              <p class="title">{{course.courseName}}</p>
              <p class="desc">{{course.description}}</p>
              <el-tag type="warning" size="small">{{course.courseTime}}&nbsp;小时</el-tag>
              <span class="price">¥&nbsp;{{course.price}}</span>
            </div>
          </li>
        </ul>
        <el-pagination
          style="margin: 20px auto;"
          background
          :hide-on-single-page="true"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="queryData.pageNum"
          :page-size="queryData.pageSize"
          layout=" prev, pager, next"
          :total="queryData.total">
        </el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "SpecialTraining",
    data() {
      return{
        specialTraining:[],
        queryData:{
          pageNum:1,
          pageSize:15,
          total:0,
        },
      }
    },
    methods:{
      reqInfo(){
        this.$courseApi.queryAllSpecialCourse(this.queryData).then(res=>{
          this.specialTraining = res.data.list;
          this.queryData.total = res.data.total;
        });
      },
      //每页大小
      handleSizeChange(val) {
        this.queryData.pageSize=val;
        this.reqInfo();
      },
      //修改当前页
      handleCurrentChange(val) {
        this.queryData.pageNum=val;
        this.reqInfo();
      },
      toCourseDetail(course){
        this.$router.push({ path: '/specialDetail', query: {id:course.courseId}});
      }
    },
    created(){
      this.reqInfo();
    }
  }
</script>

<style scoped>
  .training{
    width: 100%;
  }

  .training .training-container{
    width: 75%;
    min-width: 1300px;
    margin: 30px auto 70px;
  }

  .training .training-content{
    position: relative;
    margin: 50px auto 80px;
  }

  .training .training-content h2{
    color: #333333;
    text-align: left;
    font-weight: 400;
    font-size: 22px;
    margin: 0 0 14px 0;
  }

  .training .training-content .more{
    position: absolute;
    right: 45px;
    top: 15px;
    font-size: 16px;
    color: #666666;
  }

  .training .training-content .more .el-link{
    font-size: 15px;
  }

  .training .training-content>ul{
    margin: 0;
    padding: 0;
    display: grid;
    list-style: none;
    grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
    grid-row-gap: 45px;
    grid-column-gap: 25px;
  }

  .training .training-box{
    position: relative;
    overflow: hidden;
    width: 100%;
    height: 450px;
    transition: all .2s linear;
    border-radius: 10px;
    cursor: pointer;
    box-shadow: 0 6px 10px 0 rgba(75,91,138,0.1);
    border: 1px solid rgb(243, 243, 243);
    background-color: rgb(255, 255, 255);
  }

  .training .training-box:hover{
    box-shadow: 0 15px 30px rgba(0,0,0,.1);
    transform: translate3d(0px, -2px, 0px);
  }

  .training .training-info{
    position: relative;
    text-align: left;
    height: 108px;
    margin-top: 5px;
  }

  .training .training-info .title{
    display: block;
    overflow: hidden;
    margin: 0;
    padding: 5px 14px 0;
    color: rgba(0, 0, 0, 0.83);
    font-size: 14px;
    text-align: justify;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .desc{
    bottom: 0;
    display: -webkit-box;
    overflow: hidden;
    height: 34px;
    padding: 0 14px;
    margin-top: 6px;
    -webkit-box-orient: vertical;
    color: rgba(38, 50, 56, 0.54);
    font-size: 0.75rem;
    line-height: 1.125rem;
    text-overflow: ellipsis;
    transition: height 0.3s;
    word-wrap: break-word;
  }

  .training .training-info .price{
    display: inline-block;
    position: absolute;
    right: 15px;
    bottom: 10px;
    overflow: hidden;
    width: auto;
    color: rgb(102, 102, 102);
    font-size: 14px;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .training .training-info .el-tag{
    position: absolute;
    left: 11px;
    bottom: 10px;
  }
</style>
