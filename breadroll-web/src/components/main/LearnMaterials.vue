<template>
  <div class="learn-materials">
    <div class="banner">
      <h2 class="title">随时随地 · 一站学习</h2>
      <p class="desc">{{words}}</p>
      <div class="banner-image"></div>
    </div>
    <div class="resource-container">
      <el-card class="resource-card" shadow="never">
        <div slot="header" class="clearfix" style="position:relative;">
          <svg class="icon" aria-hidden="true" style="width: 50px;height: 50px;">
            <use xlink:href="#iconwenjian"></use>
          </svg>
          <span style="font-size: 23px;font-weight: 600;position: absolute;top: 8px;margin-left: 8px;">学习资源</span>
          <el-form inline :model="queryData" style="position: absolute;right: 0;top: 5px">
            <el-form-item>
              <el-input v-model="queryData.resourceName" placeholder="请输入文件名进行搜索"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="queryResource">搜索</el-button>
            </el-form-item>
          </el-form>
        </div>
        <div class="resource-info">
          <el-alert title="下载资源需要扣除对应花卷币，下载后记得保存好文件，不然下次下载会继续扣除花卷币哦！" type="warning"  close-text="知道了" show-icon></el-alert>
          <el-table :data="resourceData" class="resource-table" height="382px" stripe border style="width: 100%;" empty-text="暂无学习资料">
            <el-table-column prop="resourceName" label="文件名" width="300"></el-table-column>
            <el-table-column prop="remark" label="资源详情"></el-table-column>
            <el-table-column prop="fileSize" label="文件大小" width="150"></el-table-column>
            <el-table-column label="所需花卷币" width="180">
              <template slot-scope="scope">
                <el-tag size="small" style="font-size: 15px" type="warning">
                  <svg class="icon" aria-hidden="true">
                    <use xlink:href="#iconmantou"></use>
                  </svg>
                  {{scope.row.breadCoin}}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="180">
              <template slot-scope="scope">
                <el-button size="mini" type="primary" @click="download(scope.row)">下载</el-button>
              </template>
            </el-table-column>
          </el-table>
          <el-pagination
            class="page"
            v-if="resourceData!=null && resourceData.length!==0"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="queryData.pageNum"
            :page-sizes="[6, 10, 20, 50]"
            :page-size="queryData.pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="queryData.total">
          </el-pagination>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
  let ksdYuJu = ["但行好事，莫问前程", "去更远的地方，见更亮的光", "永远相信美好的事情即将发生", "生活原本沉闷，但跑起来就有风", "我们的征途是星辰大海", "保持热爱、奔赴山海", "须知少年凌云志，曾许人间第一流", "唯有热爱，能抵岁月漫长", "生活明朗，万物可爱，人间值得，未来可期", "一群有情有义的人、在一起做一些有价值有意义的事情", "即使再小的帆也能远航", "人就这么一辈子，开心也是一天，不开心也是一天，所以你一定要开心", "我们缺乏的不是知识，而是学而不厌的态度", "世界上只有少数人能够最终达到自己的理想", "生活是属于每个人自己的感受，不属于任何别人的看法", "受了这些苦，一定是为了什么值得的东西", "希望有一天自己也成为一个小太阳去温暖别人", "在谷底也要开花", "你若盛开，蝴蝶自来", "走自己的路，为自己的梦想去奋斗", "向着月亮出发，即使不能到达，也能站着群星之中", "真正喜欢的人和事，都值得我们坚持", "你最可爱，我说时来不及思索，但思索之后，还是这样说", "屏幕前的你一定是个很温柔的人吧", "别人拥有的，不必羡慕；只要努力，时间都会给你", "你只有走完必须走的路，才能过想过的生活", "凡是不能杀死你的，最终都会让你更强", "拥有希望的人，和漫天的星星一样，是永远不会孤独的", "失败，是正因你在距成功一步之遥的时候停住了脚步"];
  export default {
    name: "LearnMaterials",
    data() {
        return{
          words:"",
          queryData:{
            pageNum:1,
            pageSize:6,
            total:0,
            resourceName:'',
          },
          resourceData:[],
          filePath:'material/1621084496470阿里巴巴Java开发手册泰山版.pdf',
          fileName:'阿里巴巴Java开发手册泰山版.pdf',
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
      getWords() {
        this.words = ksdYuJu[Math.floor(Math.random() * ksdYuJu.length)];
      },
      queryResource(){
        this.$courseApi.queryResourceByName(this.queryData).then(res=>{
          this.resourceData = res.data.list;
          this.queryData.total = res.data.total;
        });
      },
      reqInfo(){
        this.$courseApi.queryAllResource(this.queryData).then(res=>{
          this.resourceData = res.data.list;
          this.queryData.total = res.data.total;
        });
      },
      download(row){
        if(this.$cookie.getToken()===null){
          this.$notify({title: '警告', message: '请先登录！', type: 'warning', offset: 50});
          this.$router.push('/loginForm');
        }else{
          this.$confirm('下载这份学习资料将扣除您'+row.breadCoin+'花卷币, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.$courseApi.checkResourceExist(row.resourceId).then(res=>{
              this.$message.success("花卷币已扣除，请及时保存资料");
              window.location.href=this.$courseApi.downloadLearnMaterials(row.resourceId);
              //检测是否有新消息
              this.$userApi.checkNewMessage().then(res=>{
                this.$store.commit("saveMessageState",res.data);
              });
              //查询花卷币数量
              this.$userApi.queryCoin().then(res=>{
                let userCoin = res.data;
                this.$store.commit("saveUserCoin",userCoin);
              });
            });
          }).catch(() => {});
        }
      }
    },
    created(){
      this.getWords();
      this.reqInfo();
    }
  }
</script>

<style scoped>
.learn-materials{
  width: 100%;
  min-height: 80vh;
  margin: 0 auto;
  min-width: 1450px;
  background: #F7F9FE;
}

.banner{
  position: relative;
  height: 220px;
  width: 100%;
  overflow: hidden;
}

.banner-image{
  position: absolute;
  top: 0;
  left: 0;
  height: 220px;
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
  top: 35%;
  left: 50%;
  line-height: 58px;
  color: #FFF;
  font-size: 34px;
  letter-spacing: 10px;
  transform: translate(-50%, -50%);
  z-index: 999;
}

.banner .desc{
  position:absolute;
  top: 65%;
  left:50%;
  transform: translate(-50%, -50%);
  background: -webkit-linear-gradient(45deg, #70f7fe, #fbd7c6, #fdefac, #bfb5dd, #bed5f5);
  color: transparent;
  letter-spacing: 2px;
  /*设置字体颜色透明*/
  -webkit-background-clip: text;
  /*背景裁剪为文本形式*/
  animation: ran 10s linear infinite;
  /*动态10s展示*/
  z-index: 999;
}

.resource-container{
  min-height: 50vh;
  margin: 30px auto 80px;
  width: 80%;
  min-width: 1450px;
  text-align: center;
}

.resource-info .page{
  margin-top: 15px;
}
</style>

<style>
.resource-card .el-card__header{
  text-align: left;
  padding: 8px 20px;
}

.resource-card .el-card__body{
  padding-bottom: 10px;
  margin-bottom: 10px;
}

/*elementUI表头与表格居中*/
.learn-materials .el-table th,.learn-materials .el-table td{
  text-align: center!important;
}


</style>
