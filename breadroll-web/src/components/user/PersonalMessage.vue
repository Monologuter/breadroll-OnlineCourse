<template>
  <div class="system-message">
    <h2 class="header">我的消息
      <el-button plain size="small" @click="readAll" style="position: absolute;right: 25px">全部已读</el-button>
    </h2>
    <div class="message-container">
      <el-card class="message-card" shadow="hover" v-for="(item,index) in personalMessageData" :key="index">
        <div slot="header">
          <el-badge :is-dot="!item.readState">
            <span style="font-weight: 600;"><i class="iconfont iconxinbaniconshangchuan-1"/>&nbsp;{{item.title}}</span>
          </el-badge>
          <span class="publish-time">{{item.publishTime}}
            <el-link icon="el-icon-delete" class="delete-link" :underline="false" @click="clearIt(item.messageId)"></el-link>
          </span>
        </div>
        <p class="message-content" :class="[item.url ? 'set-width':'']" v-html="item.content"/>
        <div class="link" v-if="item.url" >
          <el-link type="success" target="_blank" :href="item.url" style="height: 20px">
            <span @click="readMe(item.messageId)">
              查看详情<i class="el-icon-thumb"/>
            </span>
          </el-link>
        </div>
      </el-card>
    </div>
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
  </div>
</template>

<script>
  export default {
    name: "PersonalMessage",
    data() {
      return{
        personalMessageData:null,
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
      readAll(){
        this.$userApi.readAllMyMessage().then(()=>{
          this.reqInfo();
          this.$store.commit("saveMessageState",false);
        });
      },
      readMe(messageId){
        this.$userApi.readMessage(messageId).then(()=>{
          this.reqInfo();
          this.$userApi.checkNewMessage().then(res=>{
            this.$store.commit("saveMessageState",res.data);
          });
        });
      },
      clearIt(messageId){
        this.$confirm('确定清除此条消息?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$userApi.clearMyMessage(messageId).then(()=>{
            this.reqInfo();
          });
        }).catch(() => {});
      },
      reqInfo(){
        //查询我的所有消息
        this.$userApi.queryMyMessage(this.queryData).then(res=>{
          this.personalMessageData = res.data.list;
          this.queryData.total = res.data.total;
        });
      },
    },
    mounted() {
      this.reqInfo();
    }
  }
</script>

<style scoped>
.system-message{
  position: relative;
  overflow: hidden;
  padding-top: 20px;
  border-radius: 8px;
  background-color: #ffffff;
  margin-bottom: 10px;
  border: 1px solid #e6e6e6;
}

.system-message .header{
  margin-top: 0;
  padding-left: 30px;
  padding-bottom: 16px;
  margin-bottom: 16px;
  border-bottom: 1px solid #e6e6e6;
}

.system-message .message-container{
  padding: 0 20px 30px;
  min-height: 340px;
}

.system-message .message-card{
  position: relative;
  margin-bottom: 25px;
}

.message-card .publish-time{
  position: absolute;
  right: 20px;
  top: 12px;
  color: #999;
  font-size: 13px;
}

.message-card .message-content{
  width: 100%;
  font-size: 15px;
  line-height: 26px;
  color: rgba(0, 0, 0, 0.65);
  text-align: justify;
  text-overflow: ellipsis;
}

.message-card .set-width{
  width: 88% !important;
}

.message-card .delete-link{
  font-size: 16px;
  margin-left: 5px;
  vertical-align: middle;
  display: inline-block;
  margin-top: -2px;
}

.message-card .link{
  position: absolute;
  top: 0;
  right: 22px;
  height: 100%;
  display: flex;
  align-items: center;
}

.system-message .page{
  padding: 5px 12px;
  background: rgb(255, 255, 255);
  margin: -10px auto 14px;
  text-align: center;
}
</style>

<style>
.system-message .el-card__header{
  padding: 10px 20px;
  background-color: #F9F9F9;
  position: relative;
}

.system-message .el-card__body{
  padding: 0 20px;
  min-height: 50px;
  position: relative;
  display: flex;
  align-items: center;
}


.system-message .message-card .el-badge__content.is-fixed.is-dot{
  right: -4px;
  top: 5px;
}
</style>
