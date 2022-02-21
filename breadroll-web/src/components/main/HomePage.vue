<!--首页-->
<template>
  <div class="home-page">
    <div class="banner">
      <el-carousel height="380px">
        <el-carousel-item v-for="(item,index) in bannerData" :key="index">
          <router-link :to="'/courseDetail?id='+item.courseId">
            <el-image :src="item.bannerUrl" @error.once="defImg()"></el-image>
          </router-link>
        </el-carousel-item>
      </el-carousel>
    </div>
    <div class="module">
      <div class="module-box">
        <router-link v-for="(item,index) in moduleData" :to="item.url" :key="index">
          <div class="module-content">
            <div class="logo" :class="item.class">
              <i :class="item.icon"></i>
            </div>
            <span class="title" v-text="item.title"/>
            <span class="desc" v-text="item.desc"/>
          </div>
        </router-link>
      </div>
    </div>
    <div class="course">
      <div class="course-container">
        <div class="course-content" v-for="(item,index) in courseData" :key="index">
          <h2>{{item.title}}</h2>
          <div class="more">
            <el-link icon="el-icon-s-promotion" @click="toMoreCourse(item.title,index)">查看更多</el-link>
          </div>
          <ul>
            <li class="course-box" v-for="(course,i) in item.course" @click="toCourseDetail(course)" :key="i">
              <el-image :src="course.coverUrl" style="height: 161px;width: 100%;" lazy></el-image>
              <div class="course-info">
                <p>{{course.courseName}}</p>
                <span class="time-length">{{course.courseTime,course.courseSecond | changeHourMin}}</span>
                <el-tag v-if="course.vipState" type="warning" size="small">VIP课程</el-tag>
                <el-tag v-else type="success" size="small">免费课程</el-tag>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "HomePage",
    data() {
        return{
          bannerData:this.$readJson.getBanner(),
          courseData:[],
          moduleData:[{url:'/coursePreview', title:'预告', desc:'精品好课，抢先了解', icon:'iconfont iconlaba2', class:'lg1'},
            {url:'/learnMaterials', title:'资料', desc:'精选资料 懂你需求', icon:'iconfont iconvip', class:'lg2'},
            {url:'/memberDetails', title:'VIP', desc:'至尊会员 终身学习', icon:'iconfont iconbiaoqiankuozhan_taocan-283', class:'lg3'},
            {url:'/articleList', title:'锦囊', desc:'学习干货 经验杂谈', icon:'iconfont iconicon_A', class:'lg4'},
            {url:'/coursePage?title=免费专区&way=2', title:'免费专区', desc:'热门好课 免费观看', icon:'iconfont iconmianfeijieyue', class:'lg5'},
          ],
        }
    },
    methods:{
      toMoreCourse(title,index){
        if(index===2){
          this.$router.push({ path: '/coursePage', query: { title: title,way:index }});
        }else{
          this.$router.push({ path: '/coursePage', query: {way:index }});
        }
      },
      toCourseDetail(course){
        this.$router.push({ path: '/courseDetail', query: {id:course.courseId}});
      },
      defImg(){
        this.bannerData=this.$readJson.getBanner();
      },
    },
    mounted() {
      this.$courseApi.queryCourseHome().then(res=>{
        this.courseData = res.data;
      });
      this.$globalApi.queryBannerInfo().then(res=>{
        this.bannerData = res.data;
        console.log(this.bannerData);
        if(this.bannerData.length===0){
          this.bannerData=this.$readJson.getBanner();
        }
      });
    }
  }
</script>

<style scoped>
  .home-page{
    width: 100%;
    height: 100%;
    margin: 0 auto;
    min-width: 1450px;
    background: #F7F9FE;
  }
  .banner{
    width: 100%;
  }

  .banner .el-image{
    width: 100%;
    height: 100%;
  }

  .module{
    width: 100%;
  }

  .module .module-box{
    width: 80%;
    min-width: 1380px;
    margin: 30px auto;
  }

  .module .module-box a{
    width: 235px;
    height: 100px;
    margin: 0 15px;
    display: inline-block;
    border-radius: 20px 0 20px 0;
    overflow: hidden;
    box-shadow: 0 2px 10px 0 rgba(75,91,138,0.1);
    border: solid 1px #f3f3f3;
    background-color: #ffffff;
    transition: all .5s;
    -webkit-transition:all .5s;

  }
  .module .module-box a:hover{
    box-shadow: 0 10px 20px 0 rgba(61,73,112,0.2);
    border: solid 1px #f3f3f3;
    background-color: #ffffff;
    transform: translate3d(0, -2px, 0);
  }

  .module .module-box .module-content{
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    position: relative;
  }

  .module-content .logo{
    width: 51px;
    height: 51px;
    border-radius: 50%;
    margin: 0 13px 0 19px;
    line-height: 51px;
  }

  .lg1{
    background-image: linear-gradient(65deg, rgba(106, 68, 255, 0.16), rgba(84, 204, 255, 0.16));
    color: #5195FF;
  }

  .lg2{
    background-image: linear-gradient(139deg, rgb(255, 239, 234), rgb(255, 223, 225));
    color: #ff4d4f;
  }

  .lg3{
    background-image: linear-gradient(232deg, rgba(250, 215, 97, 0.16), rgba(239, 118, 35, 0.16));
    color: #FECE0A;
  }

  .lg4{
    background-image: linear-gradient(70deg, rgba(145, 68, 224, 0.16), rgba(255, 157, 211, 0.16));
    color: #722ed1;
  }

  .lg5{
    background-image: linear-gradient(50deg, rgba(28, 188, 175, 0.16), rgba(153, 231, 138, 0.16));
    color: #55CF9E;
  }

  .module-content .logo i{
    font-size: 30px;
  }


  .module-content .title{
    font-size: 22px;
    color: #666;
    margin-bottom: 4px;
    position: absolute;
    top: 20px;
    left: 82px;
  }

  .module-content .desc{
    position: absolute;
    top: 60px;
    left: 82px;
    font-size: 12px;
    color: #666;
  }

  .course{
    width: 100%;
  }

  .course .course-container{
    width: 75%;
    min-width: 1300px;
    margin: 30px auto 70px;
  }

  .course .course-content{
    position: relative;
    margin: 50px auto 80px;
  }

  .course .course-content h2{
    color: #333333;
    text-align: left;
    font-weight: 400;
    font-size: 22px;
    margin: 0 0 14px 0;
  }

  .course .course-content .more{
    position: absolute;
    right: 45px;
    top: 15px;
    font-size: 16px;
    color: #666666;
  }

  .course .course-content .more .el-link{
    font-size: 15px;
  }

  .course .course-content>ul{
    margin: 0;
    padding: 0;
    display: grid;
    list-style: none;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    grid-row-gap: 30px;
    grid-column-gap: 10px;
  }

  .course .course-box{
    position: relative;
    overflow: hidden;
    width: 290px;
    height: 240px;
    transition: all .2s linear;
    border-radius: 10px;
    cursor: pointer;
    box-shadow: 0 6px 10px 0 rgba(75,91,138,0.1);
    background-color: rgb(255, 255, 255);
  }

  .course .course-box:hover{
    box-shadow: 0 15px 30px rgba(0,0,0,.1);
    transform: translate3d(0px, -2px, 0px);
  }

  .course .course-info{
    position: relative;
    text-align: left;
    height: 70px;
  }

  .course .course-info p{
    display: block;
    margin: 5px 10px 10px;
    font-size: 15px;
    color: rgba(0, 0, 0, 0.83);
    overflow: hidden;
    line-height: 1.5;
    text-align: justify;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .course .course-info .time-length{
    display: inline-block;
    position: absolute;
    left: 11px;
    bottom: 18px;
    overflow: hidden;
    width: 130px;
    color: rgb(102, 102, 102);
    font-size: 14px;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .course .course-info .el-tag{
    position: absolute;
    right: 15px;
    bottom: 16px;
  }

</style>
