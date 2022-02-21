<template>
  <div class="bread-roll-gold">
    <h2 class="header">我的花卷币</h2>
    <div class="gold-container">
      <el-card class="gold-card detailed" shadow="hover">
        <div slot="header">
          <svg class="icon" aria-hidden="true" style="width: 25px;height: 25px;vertical-align: middle">
            <use xlink:href="#iconmantou"></use>
          </svg>
          <span style="font-weight: 600;">详细信息</span>
        </div>
        <p class="gold-content" style="margin-bottom: 10px;">花卷币余额: <span style="color:#FF6633">{{userCoin}}</span></p>
        <p class="gold-content">本月共签到 <span style="color:#FF6633">{{signCount}}</span> 次，
          连续签到 <span style="color:#FF6633">{{coiledSignCount}}</span> 次
        </p>
        <div class="link">
          <el-popover
            placement="bottom"
            width="280"
            trigger="hover">
            <div class="gold-help">
              <h6 class="title">花卷币有什么用？</h6>
              <ul>
                <li>花卷币可用于兑换课程资料</li>
                <li>花卷币还可用于参加活动</li>
              </ul>
              <h6 class="title">如何获得花卷币？</h6>
              <ul>
                <li>每日签到可获得花卷币</li>
                <li>开通VIP将会赠送花卷币</li>
              </ul>
              <h6 class="title">签到获取花卷币规则！</h6>
              <ul>
                <li>每日签到基础赠送20个</li>
                <li>每连续签到1天，多赠送5个</li>
                <li>最大连续签到上限为7天</li>
              </ul>
            </div>
            <el-link type="primary" slot="reference" style="height: 20px">花卷币帮助<i class="el-icon-question"/> </el-link>
          </el-popover>

        </div>
      </el-card>
      <el-card class="gold-card" shadow="none">
        <div slot="header">
          <svg class="icon" aria-hidden="true" style="width: 31px;height: 31px;vertical-align: middle;">
            <use xlink:href="#iconrecord"></use>
          </svg>
          <span style="font-weight: 600;">花卷币记录</span>
        </div>
        <el-table :data="recordData" border stripe style="width: 100%;margin-bottom: 20px;">
          <el-table-column prop="recordTime" label="时间" width="280"></el-table-column>
          <el-table-column prop="vary" label="变化" width="280"></el-table-column>
          <el-table-column prop="remark" label="原因"></el-table-column>
        </el-table>
        <!--分页-->
        <el-pagination
          class="page"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="queryData.pageNum"
          :page-sizes="[5, 10, 20, 50]"
          :page-size="queryData.pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="queryData.total">
        </el-pagination>
      </el-card>
    </div>
  </div>
</template>

<script>
  export default {
    name: "BreadRollGold",
    data() {
      return{
        userCoin:0,       //花卷币数量
        signCount:0,        //本月签到数
        coiledSignCount:0,  //本月连续签到数
        recordData:[],    //花卷币记录数据
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
        this.reqRecord();
      },
      //修改当前页
      handleCurrentChange(val) {
        this.queryData.pageNum=val;
        this.reqRecord();
      },
      reqRecord() {
        //查询花卷币记录
        this.$userApi.queryCoinRecord(this.queryData).then(res=>{
          this.recordData = res.data.list;
          this.queryData.total = res.data.total;
        });
      },
      reqInfo() {
        //查询花卷币数量
        this.$userApi.queryCoin().then(res=>{
          this.userCoin = res.data;
        });
        //查询本月签到次数
        this.$userApi.getSignCount().then(res=>{
          this.signCount = res.data;
        });
        //查询本月连续签到次数
        this.$userApi.getCoiledSignCount().then(res=>{
          this.coiledSignCount = res.data;
        });
        this.reqRecord();
      }
    },
    created(){
      this.reqInfo();
    }
  }
</script>

<style scoped>
.bread-roll-gold{
  overflow: hidden;
  padding-top: 20px;
  border-radius: 8px;
  background-color: #ffffff;
  margin-bottom: 10px;
  border: 1px solid #e6e6e6;
}

.bread-roll-gold .header{
  margin-top: 0;
  padding-left: 30px;
  padding-bottom: 16px;
  margin-bottom: 16px;
  border-bottom: 1px solid #e6e6e6;
}

.bread-roll-gold .gold-container{
  padding: 0 20px 0;
  min-height: 340px;
}

.bread-roll-gold .gold-card{
  position: relative;
  margin-bottom: 5px;
  border: none;
}


.gold-card .gold-content{
  width: 100%;
  font-size: 20px;
  margin-left: 20px;
  line-height: 26px;
  color: rgba(0, 0, 0, 0.9);
  font-weight: 600;
  text-align: justify;
  text-overflow: ellipsis;
}

.gold-card .set-width{
  width: 88% !important;
}

.gold-card .link{
  position: absolute;
  top: 20px;
  right: 22px;
  display: flex;
  align-items: center;
}

.bread-roll-gold .page{
  padding: 5px 12px;
  background: rgb(255, 255, 255);
  margin: -10px auto 7px;
  text-align: center;
}
</style>

<style>
.bread-roll-gold .el-card__header{
  padding: 10px 20px;
  border: 1px solid #EBEEF5;
  position: relative;
}

.bread-roll-gold .detailed .el-card__body{
  padding: 0 20px;
  border: 1px solid #ebeef5!important;
}

.bread-roll-gold .el-card__body{
  padding: 0;
  min-height: 50px;
  border: none;
  position: relative;
}

.el-popover .gold-help{
    margin-top: 15px;
}

.el-popover .gold-help .title{
  margin: 5px 10px;
  font-size: 15px;
  font-weight: 600;
}

.el-popover .gold-help ul{
  list-style-type: disc;
  margin-top: 8px;
  margin-bottom: 20px;
}

.el-popover .gold-help li{
  list-style-type: disc;
}
</style>
