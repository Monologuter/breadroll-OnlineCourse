<template>
  <div class="course-detail">
    <div class="course-container">
      <div class="course-player">
        <div class="player-container" v-if="course!=null">
          <div class="locked" v-if="locked">
            <h2>
              <el-image style="width: 100px;height: 100px;position: absolute;left: 240px" :src="logoImg"></el-image>
              <span style="position: absolute;top: 50px;left: 350px;">开通VIP，即可解锁全部章节</span>
            </h2>
            <el-button type="primary" round @click="openVip">VIP免费看</el-button>
          </div>
          <video-player v-else ref="videoPlayer" :playsinline="true" style="width: 100%;height: 100%;"
                        :options="playerOptions" @ready="playerReadied" @ended="onPlayerEnded($event)" @timeupdate = "onPlayerTimeupdate($event)">
            您的浏览器不支持视频播放。
          </video-player>
          <div class="jump-play" v-if="playRecord!=null">
            <el-button type="text" icon="el-icon-close" style="font-size: 20px;margin:-2px 0 0 12px;vertical-align: middle" @click="closeJump"></el-button>
            <span>上次看到 {{playRecord.listName}}</span>
            <el-button type="text" @click="autoPlay" style="margin: 0 14px;">跳转播放</el-button>
          </div>
        </div>
        <div class="course-list">
          <div class="header">
            <p class="title">{{course.courseName}}</p>
            <p class="desc">
              <span>共{{courseList.length}}节</span> <el-divider direction="vertical"></el-divider>
              <span>时长{{course.courseTime | changeHourMin}}</span> <el-divider direction="vertical"></el-divider>
              <span v-if="course.vipState">VIP课程</span>
              <span v-else>免费课程</span>
            </p>
          </div>
          <ul class="list-menu">
            <li v-for="(item,index) in courseList" :key="index" @click="playCourse(item,index)" :class="[active === index ? 'is-active':'']">
              <i class="el-icon-video-play play-icon"></i>
              <span class="list-name">{{item.listName}}</span>
              <span class="time">时长 {{item.timeMinute | timeFormate}}:{{item.timeSecond | timeFormate}}</span>
              <i v-if="item.lockState && !isVip" class="el-icon-lock lock"></i>
            </li>
          </ul>
          <div class="course-operate" v-if="this.$store.state.userInfo && this.$store.state.userInfo.userId">
            <el-button type="primary" round @click="joinCourse">加入课程</el-button>
          </div>
        </div>
      </div>
      <div class="course-box">
        <div class="course-info">
          <el-tabs value="first">
            <el-tab-pane label="课程简述" name="first">
              <p class="title">课程简介</p>
              <p class="desc">{{course.description}}</p>
              <p class="title">讲师介绍</p>
              <div class="teacher-data">
                <div class="header">
                  <el-avatar class="avatar" :size="40" :src="teacher.avatarUrl"></el-avatar>
                  <span class="teacher-name">{{teacher.teacherName}}</span>
                </div>
                <div class="content">{{teacher.description}}</div>
              </div>
            </el-tab-pane>
          </el-tabs>
        </div>
        <div class="recommend">
          <div class="title">为你推荐
            <el-button type="text" style="float: right;margin-top: 5px" icon="el-icon-refresh" @click="refresh">换一批</el-button>
          </div>
          <ul class="content">
            <li v-for="(course,index) in recommendCourse" :key="index" @click="watch(course)">
              <el-image :src="course.coverUrl"></el-image>
              <p class="course-name">{{course.courseName}}</p>
              <span class="time">{{course.courseTime | changeHourMin}}</span>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "CourseDetail",
    data() {
      return{
        logoImg:require("../../assets/global/nurse.png"),
        locked:true,
        isVip:false,
        currentInfo:{
          userId:null,
          courseId:0,
          listId:0,
          playTime:0,
        },
        courseSize:0,
        recommendCourse:null,
        active:0,
        teacher: {},
        course: {},
        courseList: [],
        playRecord:null,
        recordFlag:false,
        playerOptions: {
          playbackRates: [0.5, 1.0, 1.5, 2.0], //可选择的播放速度
          autoplay: false, //如果true,浏览器准备好时开始回放。
          muted: false, // 默认情况下将会消除任何音频。
          loop: false, // 视频一结束就重新开始。
          preload: 'auto', // 建议浏览器在<video>加载元素后是否应该开始下载视频数据。auto浏览器选择最佳行为,立即开始加载视频（如果浏览器支持）
          language: 'zh-CN',
          aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
          fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
          sources: [{type: "video/mp4", src: "http://localhost:9000/upload/course/HTML5+CSS3%E9%9B%B6%E5%9F%BA%E7%A1%80%E7%89%B9%E8%AE%AD%E7%8F%AD/16204635255731.1.mp4"}],
          poster: "", //你的封面地址
          notSupportedMessage: '此视频暂无法播放，请稍后再试', //允许覆盖Video.js无法播放媒体源时显示的默认信息。
          controlBar: {
            timeDivider: true,//当前时间和持续时间的分隔符
            durationDisplay: true,//显示持续时间
            remainingTimeDisplay: true,//是否显示剩余时间功能
            fullscreenToggle: true  //全屏按钮
          }
        }
      }
    },
    methods:{
      /*视频播放完成*/
      onPlayerEnded(player) {
         if(++this.active>=this.courseList.length){
           this.$alert('恭喜您，课程观看完成！完结、撒花！', '观看完成', {
             confirmButtonText: '确定',
             type: 'success'
           });
         }else{
           let list = this.courseList[this.active];
           this.currentInfo.listId = list.listId;
           this.locked=list.lockState && !this.isVip;
           this.playerOptions.sources[0].src=list.videoUrl;
           this.currentInfo.playTime = 0;
           this.playerOptions.autoplay=true;
         }
      },
      /* 获取视频播放进度 */
      onPlayerTimeupdate (player) {
        this.currentInfo.playTime = player.cache_.currentTime;
      },
      /* 设置视频进度 */
      playerReadied (player) {
        player.currentTime(this.currentInfo.playTime);
      },
      watch(course){
        this.reqInfo(course.courseId);
      },
      //播放课程
      playCourse(list,index){
        this.active=index;
        this.currentInfo.listId = list.listId;
        this.locked=list.lockState && !this.isVip;
        this.playerOptions.sources[0].src=list.videoUrl;
        this.currentInfo.playTime = 0;
        this.playerOptions.autoplay=true;
      },
      //获取随机课程
      randomCourse(count){
        this.$courseApi.queryCourseByRandom(count).then(res=>{
          this.recommendCourse=res.data;
        });
      },
      refresh(){
        this.randomCourse(3);
      },
      //开通VIP页面
      openVip(){
        this.$router.push("/memberDetails");
      },
      reqInfo(id){
        this.$courseApi.queryCourseInfoById(id).then(res=>{
          if(res.data===null || res.data.course===null){
            this.$router.push("/notCourse")
          }
          this.teacher = res.data.teacher;
          this.course = res.data.course;
          this.locked=this.course.lockState;
          this.courseList = res.data.courseList;
          this.courseSize = this.courseList.length;
          this.playerOptions.poster=this.course.coverUrl;
          this.currentInfo.listId=this.courseList[0].listId;
          this.playerOptions.sources[0].src=this.courseList[0].videoUrl;
        });
      },
      autoPlay(){
        this.playerOptions.sources[0].src = this.playRecord.url;
        this.currentInfo.playTime = this.playRecord.timeLength;
        this.playerOptions.autoplay=true;
        for(let i=0;i<this.courseList.length;i++){
          if(this.playRecord.listName === this.courseList[i].listName){
            this.active = i;
            this.currentInfo.listId = this.courseList[i].listId;
          }
        }
        this.playRecord = null;
      },
      closeJump(){
        this.playRecord = null;
      },
      getStudyRecord(courseId){
        this.$userApi.getPlayRecord(courseId).then(res=>{
          this.playRecord = res.data;
          let that = this;
          setTimeout(function(){that.playRecord=null},10000);
        });
      },
      //加入课程
      joinCourse(){
        let data = {
          userId:this.$store.state.userInfo.userId,
          courseId:this.currentInfo.courseId,
          deleteState:false
        }
        this.$userApi.addUserCourse(data).then(res=>{
          this.$message.success(res.message);
        });
      },
    },
    mounted() {
      //页面直接关闭时，保存播放进度
      window.onbeforeunload = ()=>{
        if(this.$store.state.userInfo!=null && this.recordFlag && this.currentInfo.playTime!=0){
          this.currentInfo.userId = this.$store.state.userInfo.userId;
          this.$userApi.addPlayRecord(this.currentInfo);
        }
      };
    },
    created(){
      this.currentInfo.courseId = this.$route.query.id;
      this.reqInfo(this.currentInfo.courseId);
      if(this.$store.state.vipInfo!=null && this.$store.state.vipInfo.isVip!=null){
        this.isVip = this.$store.state.vipInfo.isVip;
      }
      this.randomCourse(3);
      if(this.$cookie.getToken()){
        this.getStudyRecord(this.currentInfo.courseId);
        let that = this;
        setTimeout(function(){that.recordFlag=true},5000);
      }
    },
    beforeDestroy() {
      //vue组件取消时，保存播放进度
      if(this.$store.state.userInfo!=null && this.recordFlag && this.currentInfo.playTime!=0){
        this.currentInfo.userId = this.$store.state.userInfo.userId;
        this.$userApi.addPlayRecord(this.currentInfo);
      }
    }
  }
</script>

<style scoped>
  .course-detail{
    width: 100%;
    background-color: #F9F9F9;
  }

  .course-container{
    min-height: 80vh;
    width: 70%;
    margin: 0 auto 60px;
    min-width: 1200px;
    background-color: #F9F9F9;
  }

  .course-player{
    height: 545px;
    width: 100%;
    margin: 30px auto;
    display: grid;
    grid-template-columns: 2fr 1fr;
    background-color: #fff;


    box-shadow:0 2px 4px 0 #ededed;
  }

  .course-list .header{
    border-bottom: 1px solid #eee;
    text-align: left;
    padding: 17px 32px 0;
  }

  .course-list .title{
    height: auto;
    margin: 0;
    overflow: hidden;
    font-size: 20px;
    font-weight: 500;
    color: #333333;
    text-overflow: ellipsis;
    word-wrap: break-word;
    white-space: normal;
  }

  .course-list .desc{
    margin: 7px auto 16px;
    color: #666666;
    font-size: 14px;
  }

  .list-menu{
    margin: 0;
    padding: 0;
    height: 408px;
    overflow: auto;
    text-align: left;
    list-style: none;
  }

  .list-menu::-webkit-scrollbar {/*滚动条整体样式*/
    width: 10px;     /*高宽分别对应横竖滚动条的尺寸*/
    height: 1px;
  }

  .list-menu::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
    border-radius: 10px;
    -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
    background: #535353;
  }

  .list-menu::-webkit-scrollbar-track {/*滚动条里面轨道*/
    -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
    border-radius: 10px;
    background: #EDEDED;
  }

  .list-menu>li{
    position:relative;
    height: 66px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    color: #666666;
    cursor: pointer;
    transition: all 0.2s ease;
    border-bottom: 1px solid #eee;
  }

  .list-menu>li:hover{
    color: #0088f0!important;
  }

  .is-active{
    color: #0088f0!important;
  }

  .list-menu .play-icon{
    position: absolute;
    font-size: 30px;
    color: #bfbfbf;
    top: 20px;
    left: 24px;
  }

  .list-menu .list-name{
    position: absolute;
    font-size: 16px;
    left: 72px;
    top: 13px;
  }


  .list-menu .time{
    position: absolute;
    font-size: 13px;
    left: 72px;
    top: 41px;
  }

  .list-menu .lock{
    position: absolute;
    font-size: 17px;
    right: 18px;
    top: 33px;
    color: #666666;
  }

  .course-operate{
    width: 100%;
    margin-top: 5px;
  }

  .course-operate .el-button{
    width: 225px;
  }

  .course-box{
    margin: 0 auto;
    width: 100%;
    display: grid;
    grid-template-columns: 1fr 375px;
    grid-column-gap: 30px;
    background-color: #F9F9F9;
  }

  .course-box .course-info{
    padding: 20px 30px;
    text-align: left;
    background-color: #F2F4FA;
  }

  .course-box .course-info .title{
    font-size: 24px;
    font-weight: 500;
    margin: 10px 0 12px;
    position: relative;
    display: inline-block;
  }

  .course-box .course-info .title:after{
    width: 100%;
    height: 8px;
    border-radius: 2px;
    position: absolute;
    left: 0;
    content: '';
    background-color: rgba(0, 136, 240, 0.1);
    bottom: 3px;
  }


  .course-box .course-info  .desc{
    margin: 0 0 12px 0;
    font-size: 16px;
    color: #00000099;
    line-height: 26px;
  }

  .teacher-data{
    width: 400px;
    height: 230px;
    border-radius: 12px;
    box-shadow: 0 4px 9px 0 rgba(13,67,108,0.1);
    background-color: #ffffff;
    overflow: hidden;
  }

  .teacher-data .header{
    width: 100%;
    position: relative;
    height: 64px;
    background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
  }

  .teacher-data .avatar{
    position: absolute;
    top: 14px;
    left: 18px;
  }

  .teacher-data .teacher-name{
    position: absolute;
    top: 21px;
    left: 70px;
    font-size: 18px;
  }

  .teacher-data .content{
    height: 165px;
    font-size: 16px;
    color: #2632388A;
    padding: 24px;
    line-height: 26px;
  }

  .course-box .recommend{
    height: 350px;
    background-color: #FFFFFF;
  }

  .recommend .title{
    font-size: 18px;
    color: #333333;
    text-align: left;
    padding: 3px 32px;
    height: 52px;
    line-height: 52px;
    border-bottom: 1px solid #E4E7ED;
  }

  .recommend .content{
    padding: 0 32px;
    list-style: none;
  }

  .recommend .content>li{
    position: relative;
    height: 70px;
    cursor: pointer;
    margin-bottom: 20px;
  }

  .recommend .content>li:hover{
    color: #0088f0!important;
  }

  .recommend .content .el-image{
    position: absolute;
    top: 2px;
    left: 0;
    width: 120px;
    height: 66px;
    border-radius: 6px;
  }

  .recommend .content .course-name{
    position: absolute;
    margin: 0;
    left: 130px;
    top: 8px;
    width: 180px;
    overflow: hidden;
    text-align: justify;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 14px;
  }

  .recommend .content .time{
    font-size: 12px;
    position: absolute;
    margin: 0;
    color: rgba(38, 50, 56, 0.54);
    left: 130px;
    top: 43px;
  }

  .course-player .locked{
    width: 100%;
    height: 100%;
    padding-top: 175px;
    padding-bottom: 50px;
    box-sizing: border-box;
    background: #000000;
    background-size: 100% 100%;
  }

  .course-player .locked h2{
    font-size: 18px;
    font-weight: 500;
    color: #D1AF88;
    position: relative;
    user-select: none;
    height: 100px;
  }

  .course-player .locked .el-button{
    width: 180px;
    margin-top: 15px;
  }

  .player-container{
    position: relative;
  }

  .player-container .jump-play{
    position: absolute;
    bottom: 50px;
    font-size: 14px;
    background: #343434;
    height: 45px;
    line-height: 45px;
    color: #FFF;
    border-radius: 5px;
  }
</style>


<style>
.video-js{
  height: 100% !important;
}

.video-js .vjs-tech{
  object-fit:fill;
  width: 100.08%;
}

.video-js .vjs-big-play-button{
  position: absolute;
  left: 50%!important;
  top: 50%!important;
  transform: translate(-50%,-50%);
  -webkit-transform: translate(-50%,-50%);
  -ms-transform: translate(-50%,-50%);
}

.el-tabs__item{
  font-size: 18px;
  color: #263238DE!important;
}
</style>
