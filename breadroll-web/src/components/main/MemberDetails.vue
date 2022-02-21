<template>
  <div class="member-details">
    <div class="banner">
      <h2 class="title">开通会员可享受更多服务</h2>
      <el-button type="primary" icon="iconfont iconvip1" round @click="openDefaultMember">&nbsp;开通会员</el-button>
      <div class="banner-image"></div>
    </div>
    <div class="member-introduce">
      <h2 class="header">会员特权</h2>
      <ul class="member-box">
        <li class="member-info" v-for="(item,index) in vipData" :key="index" :class="top[index]">
          <div class="top">
            <svg class="icon members-icon" aria-hidden="true">
              <use :xlink:href="item.vipIcon"></use>
            </svg>
            <h3 class="members-name">{{item.vipName}}</h3>
            <p class="members-txt">赠送 {{item.breadCoin}} 花卷币</p>
            <p class="members-txt">{{item.vipMark}}</p>
          </div>
          <div class="center">
            <span class="title-left" :class="left[index]"></span>
            <i :class="color[index]">{{item.vipName}}尊享权益</i>
            <span class="title-right" :class="right[index]"></span>
          </div>
          <div class="bottom">
            <ul class="auth-list">
              <li><el-image :src="vip_1"/>广告特权</li>
              <li><el-image :src="vip_2"/>赠送花卷币</li>
              <li><el-image :src="vip_3"/>尊贵身份</li>
              <li><el-image :src="vip_4"/>全部课程免费</li>
            </ul>
            <div class="purchase">
              <el-button :type="type[index]" @click="openMember(item)" round>立即开通</el-button>
            </div>
          </div>
        </li>
      </ul>
    </div>
    <el-dialog :title="data.vipName" :visible.sync="dialogVisible" :close-on-click-modal="false" width="360px" top="30vh">
      <p class="title">会员介绍</p>
      <p class="desc">
        <ul>
          <li>尊贵VIP会员标识</li>
          <li>解锁全部线上课程</li>
          <li>免费赠送{{data.breadCoin}}花卷币</li>
          <li v-if="data.timeLength===-1">并将有机会参与我们举办的下线活动</li>
          <li>价格：￥{{data.price}}</li>
          <li>有效时长：
            <span v-if="data.timeLength===-1">永久</span>
            <span v-else>{{data.timeLength}}天</span>
          </li>
        </ul>
      </p>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" size="small" round @click="createOrder" icon="iconfont iconzhifubaozhifu"> 支付宝</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
  export default {
    name: "MemberDetails",
    data() {
      return{
        dialogVisible:false,
        vipData:[],
        data:{},
        order:{
          orderName:"",
          orderNo:"",
          payPrice:"",
          serialNumber:"",
        },
        vip_1:require("../../assets/global/vip-tq-1_1.png"),
        vip_2:require("../../assets/global/vip-tq-1_2.png"),
        vip_3:require("../../assets/global/vip-tq-1_3.png"),
        vip_4:require("../../assets/global/vip-tq-1_4.png"),
        icon:['#iconhuiyuan2','#iconhuiyuan','#iconhuiyuan4','#iconhuiyuan1','#iconhuiyuan5'],
        top:['vip-1','vip-2','vip-3','vip-4','vip-5'],
        left:['left-vip-1','left-vip-2','left-vip-3','left-vip-4','left-vip-5'],
        right:['right-vip-1','right-vip-2','right-vip-3','right-vip-4','right-vip-5'],
        color:['i-vip-1','i-vip-2','i-vip-3','i-vip-4','i-vip-5'],
        type:['primary','success','danger','warning'],
      }
    },
    methods:{
      openDefaultMember(){
        if(this.$store.state.userInfo===null || this.$store.state.userInfo.userId===null){
          this.$cookie.clearToken();
          this.$router.push('/loginForm');
          this.$notify({
            title: '警告',
            message: '请先登录！',
            type: 'warning'
          });
        }
        this.data = this.vipData[2];
        this.dialogVisible = true;
      },
      openMember(data){
        if(this.$cookie.getToken() === null || this.$store.state.userInfo===null || this.$store.state.userInfo.userId===null){
          this.$cookie.clearToken();
          this.$router.push('/loginForm');
          this.$notify({
            title: '警告',
            message: '请先登录！',
            type: 'warning'
          });
        }
        this.data = data;
        this.dialogVisible = true;
      },
      createOrder(){
        this.order.orderNo = this.$tools.getUUID();
        this.order.orderName = "开通" +  this.$tools.deepCope(this.data.vipName);
        this.order.payPrice = this.$tools.deepCope(this.data.price);
        this.order.serialNumber = this.$tools.getUUID()+"_"+this.data.vipId+"_"+this.$store.state.userInfo.userId;
        this.dialogVisible=false;
        this.$store.commit('serialNumber',this.order.serialNumber);
        this.$globalApi.createOrder(this.order).then(res=>{
          const div = document.createElement('div');
          div.innerHTML = res.data;
          document.body.appendChild(div);
          document.forms[document.forms.length-1].submit();
        });
      }
    },
    mounted(){
      this.$globalApi.queryVipInfo().then(res=>{
        this.vipData = res.data;
      });
    },
    created() {
      let serialNumber =  this.$route.query.serialNumber;
      let vipSerialNumber = this.$store.state.serialNumber;
      if(serialNumber===vipSerialNumber){
        let vipId = serialNumber.split("_")[1];
        this.$userApi.queryVipById(vipId).then(res=>{
          this.$notify({title: '成功', message: '尊贵的用户，'+res.data.vipName+'开通成功', type: 'success', offset: 50});
        });
        this.$userApi.queryMyVip().then(res=>{
          this.$store.commit("saveVipInfo",res.data);
        });
      }
    }
  }
</script>

<style scoped>
  .member-details{
    width: 100%;
    min-height: 80vh;
    margin: 0 auto;
    min-width: 1450px;
    background: #F7F9FE;
  }

  .banner{
    position: relative;
    height: 310px;
    width: 100%;
    overflow: hidden;
  }

  .banner-image{
    position: absolute;
    top: 0;
    left: 0;
    height: 310px;
    width: 100%;
    overflow: hidden;
    background-image: url(../../assets/global/coursebg.jpg);
    background-color: #160b03;
    background-position: center center;
    background-repeat: no-repeat;
    background-size: cover;
    filter: hue-rotate(320deg);
  }

  .banner .title{
    position: absolute;
    top: 30%;
    left: 50%;
    font-size: 30px;
    color: #fccd99;
    transform: translate(-50%, -50%);
    z-index: 999;
  }

  .banner .el-button{
    position: absolute;
    top: 65%;
    left: 50%;
    width: 220px;
    font-size: 18px;
    transform: translate(-50%, -50%);
    z-index: 999;
  }

  .member-introduce{
    margin: 30px auto 80px;
    width: 80%;
    min-width: 1450px;
  }

  .member-introduce .header{
    font-size: 33px;
    letter-spacing: 15px;
    font-weight: 500;
    color: #4c4c4c;
    margin: 25px auto;
  }

  .member-introduce .member-box{
    display: grid;
    margin: 0;
    padding: 0;
    list-style: none;
    grid-template-columns: repeat(4, 1fr);
    grid-column-gap: 30px;
    grid-row-gap: 50px;
  }

  .member-introduce .member-info{
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
    text-align: center;
    -webkit-box-shadow: 0 6px 10px 0 rgba(75,91,138,0.1);
    box-shadow: 0 6px 10px 0 rgba(75,91,138,0.1);
    border: 1px solid rgb(243, 243, 243);
    border-top: 3px solid #fff;
  }

  .member-info .members-icon{
    margin-top: 30px;
    width: 65px;
    height: 65px;
  }

  .member-info .members-name{
    font-size: 24px;
    color: #333;
    margin: 10px auto;
  }

  .member-info .members-txt{
    font-size: 14px;
    color: #999999;
    margin: 0;
  }

  .member-info .center{
    height: 32px;
    line-height: 32px;
    font-size: 14px;
    text-align: center;
    margin: 19px 0 10px;
  }

  .member-info .center .title-left, .member-info .center .title-right {
    width: 60px;
    height: 1px;
    display: inline-block;
    vertical-align: middle;
  }

  .member-info .center i{
    font-style: normal;
    display: inline-block;
    padding: 0 10px;
  }

  .bottom .auth-list{
    list-style: none;
    display: grid;
    grid-template-columns: 1fr 1.2fr;
    grid-column-gap: 10px;
    padding: 0;
    margin: 10px 30px 10px 40px;
  }

  .bottom .auth-list li{
    padding: 0;
    height: 30px;
    list-style: none;
    margin-bottom: 14px;
    margin-left: 16px;
    line-height: 30px;
    font-size: 14px;
    color: #333;
    text-align: left;
  }

  .bottom .auth-list li .el-image{
    display: inline-block;
    vertical-align: middle;
    width: 26px;
    height: 26px;
    margin-right: 8px;
  }

  .bottom .purchase{
    position: relative;
    height: 100px;
    background: #faf8f8;
  }
  .bottom .el-button{
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 200px;
    font-size: 16px;
  }

  /* vip 1 */

  .member-introduce .member-box .vip-1:hover{
    border-top-color: #459EFE;
  }

  .left-vip-1{
    background: -webkit-linear-gradient(left,#fff, #459EFE);
    background: -o-linear-gradient(right,#fff, #459EFE);
    background: -moz-linear-gradient(right,#fff, #459EFE);
    background: linear-gradient(to right,#fff, #459EFE);
  }

  .right-vip-1{
    background: -webkit-linear-gradient(left,#459EFE,#fff);
    background: -o-linear-gradient(right, #459EFE, #fff);
    background: -moz-linear-gradient(right, #459EFE, #fff);
    background: linear-gradient(to right, #459EFE, #fff);
  }

  .i-vip-1{
    color: #459EFE;
  }

  /* vip 2 */

  .member-introduce .member-box .vip-2:hover{
    border-top-color: #8F65FF;
  }

  .left-vip-2{
    background: -webkit-linear-gradient(left,#fff, #8F65FF);
    background: -o-linear-gradient(right,#fff, #8F65FF);
    background: -moz-linear-gradient(right,#fff, #8F65FF);
    background: linear-gradient(to right,#fff, #8F65FF);
  }

  .right-vip-2{
    background: -webkit-linear-gradient(left,#8F65FF,#fff);
    background: -o-linear-gradient(right, #8F65FF, #fff);
    background: -moz-linear-gradient(right, #8F65FF, #fff);
    background: linear-gradient(to right, #8F65FF, #fff);
  }

  .i-vip-2{
    color: #8F65FF;
  }

  /* vip 3 */

  .member-introduce .member-box .vip-3:hover{
    border-top-color: #f47d7d;
  }

  .left-vip-3{
    background: -webkit-linear-gradient(left,#fff, #f47d7d);
    background: -o-linear-gradient(right,#fff, #f47d7d);
    background: -moz-linear-gradient(right,#fff, #f47d7d);
    background: linear-gradient(to right,#fff, #f47d7d);
  }

  .right-vip-3{
    background: -webkit-linear-gradient(left,#f47d7d,#fff);
    background: -o-linear-gradient(right, #f47d7d, #fff);
    background: -moz-linear-gradient(right, #f47d7d, #fff);
    background: linear-gradient(to right, #f47d7d, #fff);
  }

  .i-vip-3{
    color: #f47d7d;
  }

  /* vip 4 */

  .member-introduce .member-box .vip-4:hover{
    border-top-color: #FBAE0C;
  }

  .left-vip-4{
    background: -webkit-linear-gradient(left,#fff, #FBAE0C);
    background: -o-linear-gradient(right,#fff, #FBAE0C);
    background: -moz-linear-gradient(right,#fff, #FBAE0C);
    background: linear-gradient(to right,#fff, #FBAE0C);
  }

  .right-vip-4{
    background: -webkit-linear-gradient(left,#FBAE0C,#fff);
    background: -o-linear-gradient(right, #FBAE0C, #fff);
    background: -moz-linear-gradient(right, #FBAE0C, #fff);
    background: linear-gradient(to right, #FBAE0C, #fff);
  }

  .i-vip-4{
    color: #FBAE0C;
  }


  /* vip 5 */

  .member-introduce .member-box .vip-5:hover{
    border-top-color: #B6BED2;
  }

  .left-vip-5{
    background: -webkit-linear-gradient(left,#fff, #B6BED2);
    background: -o-linear-gradient(right,#fff, #B6BED2);
    background: -moz-linear-gradient(right,#fff, #B6BED2);
    background: linear-gradient(to right,#fff, #B6BED2);
  }

  .right-vip-5{
    background: -webkit-linear-gradient(left,#B6BED2,#fff);
    background: -o-linear-gradient(right, #B6BED2, #fff);
    background: -moz-linear-gradient(right, #B6BED2, #fff);
    background: linear-gradient(to right, #B6BED2, #fff);
  }

  .i-vip-5{
    color: #B6BED2;
  }
</style>
<style>
  .member-details .el-dialog{
    text-align: left;
    border: solid 7px transparent;
    background-clip: content-box, border-box;
    background-image: linear-gradient(#16161a, #16161a), linear-gradient(316deg, #d89852, #fccd99);
    background-origin: border-box;
    border-radius: 16px;
  }

  .member-details .el-dialog .el-dialog__header{
    border-bottom:none;
    padding-top: 30px;
    text-align: center;
  }

  .member-details .el-dialog__title{
    color: #d3b08b;
    font-size: 20px;
  }

  .member-details .el-dialog__footer{
    text-align: center;
  }

  .member-details .el-dialog__footer .el-button{
    width: 150px;
    font-size: 15px;
  }
  .member-details .el-dialog .el-dialog__body {
    padding: 0 40px 10px;
    font-size: 18px;
  }

  .member-details .el-dialog .title {
    color: #d3b08b;
    margin: 12px auto 4px;
    font-size: 18px;
    font-weight: bold;
  }

  .member-details .el-dialog .desc {
    color: #d3b08b;
    font-size: 15px;
    opacity: 0.8;
  }

  .member-details .el-dialog ul{
    padding-left: 20px;
  }


</style>
