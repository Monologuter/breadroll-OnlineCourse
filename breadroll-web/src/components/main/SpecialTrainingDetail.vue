<template>
  <div class="special-detail">
    <el-image :src="applyImg" style="width: 100%;height: 210px"></el-image>
    <h1 class="course-name">
      <el-image :src="leftImg"></el-image>
      {{courseData.courseName}}
      <el-image :src="rightImg"></el-image>
    </h1>
    <el-tabs v-model="activeName" class="special-info">
      <el-tab-pane label="课程简介" name="first">
        <el-card class="course-card">
          <div class="desc">
            {{courseData.description}}
            <div>
              <span class="tips">{{courseData.typeName}}</span>
              <span class="tips">预计时长 {{courseData.courseTime}} h</span>
              <span class="tips">开课时间 {{courseData.startTime}}</span>
              <span class="tips">价格 {{courseData.price}} 元</span>
            </div>
          </div>
        </el-card>
      </el-tab-pane>
      <el-tab-pane label="讲师介绍" name="second">
        <el-card class="course-card">
          <div class="teacher desc">
            <el-image :src="teacherData.avatarUrl" style="width: 135px;height: 150px"></el-image>
            <div class="teacher-info">
              <h2 style="margin: 0 0 10px">{{teacherData.teacherName}}</h2>
              <p style="margin: 0">{{teacherData.description}}</p>
              <div><span class="tips">入职时间 {{teacherData.entryTime}}</span></div>
            </div>
          </div>
        </el-card>
      </el-tab-pane>
    </el-tabs>
    <h1 class="sign-up">
      <svg class="icon" style="width: 65px;height: 65px;vertical-align: middle" aria-hidden="true">
        <use xlink:href="#iconweibiaoti--"></use>
      </svg>
      报名流程
    </h1>
    <div class="sign-up-process">
      <el-timeline>
        <el-timeline-item :timestamp="tip" placement="top" icon="el-icon-edit"  type="primary">
          <el-card shadow="hover" v-if="applyState">
            <span style="font-size: 18px;color: #333333;font-weight: 100">恭喜您，{{courseData.courseName}} 已报名成功</span>
          </el-card>
          <el-card shadow="hover" v-else-if="new Date(courseData.startTime)<new Date()">
            <span style="font-size: 18px;color: #333333;font-weight: 100">《{{courseData.courseName}}》已开课，无法参与报名，请留意下次开课时间</span>
          </el-card>
          <el-card shadow="never" v-else class="apply-card">
            <el-form :inline="true" :model="orderInfo" :rules="rules" ref="userForm" label-width="100px" class="user-apply">
              <el-form-item prop="userName">
                <el-input v-model="orderInfo.userName" placeholder="请输入您的姓名"  prefix-icon="el-icon-user"></el-input>
              </el-form-item>
              <el-form-item prop="userPhone">
                <el-input v-model="orderInfo.userPhone" placeholder="请输入您的手机号" prefix-icon="el-icon-mobile-phone"></el-input>
              </el-form-item>
              <el-form-item prop="userEmail">
                <el-input v-model="orderInfo.userEmail" placeholder="请输入您的邮箱" prefix-icon="el-icon-message"></el-input>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="onSubmit('userForm')" style="width: 200px" :disabled="applyState">
                  <span v-if="applyState">课程已报名</span>
                  <span v-else>立即报名</span>
                </el-button>
              </el-form-item>
            </el-form>
          </el-card>
        </el-timeline-item>
        <el-timeline-item v-if="!applyState" timestamp="缴纳学费" placement="top" icon="el-icon-mobile-phone"  type="primary">
          <el-card shadow="hover">
            <span style="font-size: 18px;color: #333333;font-weight: 100">提交报名信息后，将为您自动生成支付订单，在支付宝完成支付即可</span>
          </el-card>
        </el-timeline-item>
        <el-timeline-item timestamp="查收入学通知书" placement="top" icon="el-icon-s-promotion"  type="primary">
          <el-card shadow="hover">
            <span v-if="applyState" style="font-size: 18px;color: #333333;font-weight: 100">您的个人邮箱将会收到电子版入学通知书，请注意查收</span>
            <span v-else style="font-size: 18px;color: #333333;font-weight: 100">订单支付成功后，您的个人邮箱将收到电子版入学通知书，请注意查收</span>
          </el-card>
        </el-timeline-item>
        <el-timeline-item timestamp="来校报到" placement="top" icon="el-icon-school"  type="primary">
          <el-card shadow="hover">
            <span style="font-size: 18px;color: #333333;font-weight: 100">学员须在开学前 2 ~ 3 天，携带通知书所示的报名材料及相关证件到校区报到</span>
          </el-card>
        </el-timeline-item>
      </el-timeline>
    </div>
    <h1 class="sign-up">
      <svg class="icon" style="width: 60px;height: 60px;vertical-align: middle" aria-hidden="true">
        <use xlink:href="#iconditu"></use>
      </svg>
      校区地址
    </h1>
    <div class="baidu-map">
      <el-card show="never">
        <h3 style="text-align: left;margin: 20px 5px;">详细地址：{{schoolAddress}}</h3>
        <baidu-map class="map-view" :center="schoolAddress" :zoom="14" ak="95oCR19X0eU0BR3QHFkERkMeoNyUMP5d">
          <bm-navigation anchor="BMAP_ANCHOR_TOP_RIGHT"></bm-navigation>
          <bm-geolocation anchor="BMAP_ANCHOR_BOTTOM_RIGHT" :showAddressBar="true" :autoLocation="true"></bm-geolocation>
          <bm-map-type :map-types="['BMAP_NORMAL_MAP', 'BMAP_HYBRID_MAP']" anchor="BMAP_ANCHOR_TOP_LEFT"></bm-map-type>
        </baidu-map>
      </el-card>
    </div>
  </div>
</template>

<script>
  import BaiduMap from 'vue-baidu-map/components/map/Map.vue'
  import { BmGeolocation, BmNavigation, BmMapType } from 'vue-baidu-map'

  export default {
    name: "SpecialTrainingDetail",
    components: {
      BaiduMap,
      BmGeolocation,
      BmNavigation,
      BmMapType,
    },
    data() {
      var validatePhone = (rule, value, callback) => {
        if (this.$tools.checkPhone(value)) {
          callback();
        }
        callback(new Error('请输入正确的手机号'));
      };
      return{
        applyImg:require("../../assets/global/apply.jpg"),
        leftImg:require("../../assets/global/left.png"),
        rightImg:require("../../assets/global/right.png"),
        courseId:'',
        tip:'预报名',
        courseData:{},
        teacherData:{},
        applyState:false,
        activeName: 'first',
        orderInfo:{
          orderNo:'',
          orderName:'',
          payPrice:'',
          serialNumber:'',
          userId:'',
          userName:'',
          userPhone:'',
          userEmail:''
        },
        schoolAddress:'河南省郑州市高新区中国移动在线服务河南分公司',
        rules: {
          userName: [
            {required: true, message: '请输入您的姓名', trigger: 'blur'},
            {min: 1, max: 20, message: '请输入正确的姓名', trigger: 'blur'}
          ],
          userPhone: [
            {required: true, message: '请输入您的手机号', trigger: 'blur'},
            { validator: validatePhone, trigger: 'blur' }
          ],
          userEmail: [
            { required: true, message: '请输入您的邮箱', trigger: 'blur' },
            { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] }
          ]
        }
      }
    },
    methods:{
      reqInfo(id){
        this.$courseApi.querySpecialById(id).then(res=>{
          this.courseData = res.data.course;
          this.teacherData = res.data.teacher;
          this.applyState = res.data.applyState;
          if(this.applyState){
            this.tip = "报名成功"
          }
        });
      },
      onSubmit(formName) {
        if(this.$cookie.getToken()===null){
          this.$notify({title: '警告', message: '请先登录！', type: 'warning', offset: 50});
          this.$router.push('/loginForm');
        }else {
          this.$refs[formName].validate((valid) => {
            if (valid) {
              //添加订单信息
              this.orderInfo.orderNo = this.$tools.getUUID();
              this.orderInfo.orderName = '报名' + this.courseData.courseName;
              this.orderInfo.payPrice = this.courseData.price;
              this.orderInfo.serialNumber = this.$tools.getUUID() + "_" + this.courseData.courseId;
              this.$store.commit('serialNumber', this.orderInfo.serialNumber);
              this.$globalApi.createOrder(this.orderInfo).then(res => {
                const div = document.createElement('div');
                div.innerHTML = res.data;
                document.body.appendChild(div);
                document.forms[document.forms.length - 1].submit();
              });
            } else {
              return false;
            }
          });
        }
      },
    },
    created(){
      this.courseId = this.$route.query.id;
      let serialNumber =  this.$route.query.serialNumber;
      let specialSerialNumber = this.$store.state.serialNumber;
      if(serialNumber===specialSerialNumber){
        this.$courseApi.querySpecialById(this.$route.query.id).then(res=>{
          this.courseData = res.data.course;
          this.teacherData = res.data.teacher;
          this.applyState = res.data.applyState;
          if(this.applyState){
            this.tip = "报名成功"
          }
          this.$notify({title: '成功', message: '尊贵的用户，'+res.data.course.courseName+'报名成功', type: 'success', offset: 50});
        });
      }else{
        this.reqInfo(this.courseId);
      }
    },
  }
</script>

<style scoped>
  .special-detail{
    width: 100%;
    margin-bottom: 60px;
  }

  .course-name{
    color: #000;
    margin: 25px 0;
    padding: 0;
    padding-left: 40px;
    font-size: 36px;
    font-weight: 500;
  }

  .course-name .el-image:first-child {
    width: 90px;
    position: relative;
    top: -15px;
    right: 29px;
  }

  .course-name .el-image:last-child {
    width: 130px;
    position: relative;
    top: -14px;
    left: -5px;
  }

  .special-info{
    width: 70%;
    min-width: 1100px;
    margin: 0 auto;
    min-height: 300px;
  }

  .course-card .desc{
    text-align: justify;
    line-height: 30px;
    min-height: 100px;
  }

  .course-card .teacher{
    display: grid;
    grid-template-columns: 150px 1fr;
    grid-column-gap: 30px;
  }

  .course-card .teacher .teacher-info{
    text-align: justify;
  }

  .desc .tips{
    display: inline-block;
    margin: 15px 15px 0 0;
    width: fit-content;
    height: 28px;
    padding: 0 30px;
    border-radius: 15px;
    background-color: #e1eeff;
    color: rgb(58, 176, 237);
    line-height: 30px;
    text-align: center;
  }

  .sign-up{
    color: #000;
    margin: 25px 0;
    padding: 0;
    font-size: 32px;
    font-weight: 500;
  }

  .sign-up-process{
    text-align: left;
    width: 70%;
    min-width: 1100px;
    margin: 0 auto;
    min-height: 300px;
  }

  .baidu-map{
    text-align: center;
    width: 70%;
    min-width: 1100px;
    margin: 0 auto;
    min-height: 300px;
  }

  .baidu-map .map-view{
    width: 100%;
    height: 600px;
  }

</style>

<style>
.special-info .el-tabs__header{
  display: flex;
  justify-content: center;
}

.special-info .el-card__body{
  padding: 30px 40px;

}

.special-info .el-tabs__content{
  box-shadow: 3px 20px 62px 0 rgba(76,103,222,.03);
}

.special-info  .el-tabs__item{
  font-weight: 500;
  font-size: 24px;
}

.special-info .el-tabs__nav-wrap::after{
  display: none!important;
}

.sign-up-process .el-timeline-item__timestamp{
  font-size: 22px;
  margin-left: 12px;
  color: #000;
  margin-bottom: 22px;
}

.sign-up-process .el-timeline-item__node--normal{
  left: -15px;
  top: -8px;
  width: 38px;
  height: 38px;
}

.sign-up-process .el-timeline-item__icon{
  font-size: 22px;
}

.sign-up-process .user-apply  .el-form-item{
  width: 40%;
}

.sign-up-process .user-apply .el-form-item__content{
  width: 100%;
}

.sign-up-process .apply-card .el-card__body{
  padding-bottom: 2px;
}

.baidu-map .el-card__body{
  padding: 10px;
}
</style>
