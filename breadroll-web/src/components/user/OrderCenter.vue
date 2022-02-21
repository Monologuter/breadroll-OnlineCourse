<template>
  <div class="order-center">
    <h2 class="header">我的订单</h2>
    <div class="gold-container">
      <el-card class="gold-card" shadow="none">
        <div slot="header">
          <svg class="icon" aria-hidden="true" style="width: 31px;height: 31px;vertical-align: middle;">
            <use xlink:href="#iconrecord"></use>
          </svg>
          <span style="font-weight: 600;">订单记录</span>
        </div>
        <el-table :data="orderData" border stripe style="width: 100%;margin-bottom: 20px;min-height: 283px;">
          <el-table-column prop="orderNo" label="订单编号" width="300"></el-table-column>
          <el-table-column prop="orderName" label="订单名称" width="300"></el-table-column>
          <el-table-column prop="createTime" label="创建时间" width="200"></el-table-column>
          <el-table-column prop="payPrice" label="支付金额" width="150"></el-table-column>
          <el-table-column prop="orderState" label="订单状态"></el-table-column>
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
    name: "OrderCenter",
    data() {
      return{
        orderData:[],    //花卷币记录数据
        queryData:{
          pageNum:1,
          pageSize:10,
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
      reqInfo() {
        this.$userApi.queryMyOrder(this.queryData).then(res=>{
          this.orderData = res.data.list;
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
.order-center{
  overflow: hidden;
  padding-top: 20px;
  border-radius: 8px;
  background-color: #ffffff;
  margin-bottom: 10px;
  border: 1px solid #e6e6e6;
}

.order-center .header{
  margin-top: 0;
  padding-left: 30px;
  padding-bottom: 16px;
  margin-bottom: 16px;
  border-bottom: 1px solid #e6e6e6;
}

.order-center .gold-container{
  padding: 0 20px 0;
  min-height: 340px;
}

.order-center .gold-card{
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

.order-center .page{
  padding: 5px 12px;
  background: rgb(255, 255, 255);
  margin: -10px auto 7px;
  text-align: center;
}
</style>

<style>
.order-center .gold-card .el-table__empty-text {
  line-height: 245px;
  user-select: none;
}


.order-center .el-card__header{
  padding: 10px 20px;
  border: 1px solid #EBEEF5;
  position: relative;
}

.order-center .detailed .el-card__body{
  padding: 0 20px;
  border: 1px solid #ebeef5!important;
}

.order-center .el-card__body{
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
