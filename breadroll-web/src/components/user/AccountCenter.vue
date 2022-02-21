<template>
  <div>
    <ul class="account-center">
      <li class="account-box">
        <div class="state">
          <svg v-if="accountData.state" class="icon" aria-hidden="true">
            <use xlink:href="#iconchenggong"></use>
          </svg>
          <svg v-else class="icon" aria-hidden="true">
            <use xlink:href="#iconshibai"></use>
          </svg>
        </div>
        <div class="name">
          <span>我的帐号</span>
        </div>
        <div class="value">
          <span>{{accountData.value}}</span>
        </div>
        <div class="operate">
          <el-button plain v-clipboard:copy="accountData.value"
          v-clipboard:success="onCopy" v-clipboard:error="onError">点击复制</el-button>
        </div>
      </li>
      <li class="account-box" v-if="userVipInfo!=null && userVipInfo.isVip">
        <div class="state">
          <svg class="icon" aria-hidden="true">
            <use :xlink:href="userVipInfo.vipIcon"></use>
          </svg>
        </div>
        <div class="name">
          <span>我的会员</span>
        </div>
        <div class="value">
          <span>{{userVipInfo.vipName}}</span>
          <el-divider v-if="userVipInfo.expireDate.indexOf('9999')===-1" direction="vertical"></el-divider>
          <span style="font-size: 16px;font-weight: 300;">{{userVipInfo.expireDate | vipState}}</span>
        </div>
        <div class="operate">
          <el-button plain @click="openVip">立即续费</el-button>
        </div>
      </li>
      <li class="account-box">
        <div class="state">
          <svg v-if="phoneData.state" class="icon" aria-hidden="true">
            <use xlink:href="#iconchenggong"></use>
          </svg>
          <svg v-else class="icon" aria-hidden="true">
            <use xlink:href="#iconshibai"></use>
          </svg>
        </div>
        <div class="name">
          <span>绑定手机</span>
        </div>
        <div class="value">
          <span>{{phoneData.value}}</span>
        </div>
        <div class="operate">
          <el-button plain @click="updatePhone">
            <span v-if="phoneData.value==null">点击绑定</span>
            <span v-else>更换号码</span>
          </el-button>
        </div>
      </li>
      <li class="account-box">
        <div class="state">
          <svg v-if="passwordData.state" class="icon" aria-hidden="true">
            <use xlink:href="#iconchenggong"></use>
          </svg>
          <svg v-else class="icon" aria-hidden="true">
            <use xlink:href="#iconshibai"></use>
          </svg>
        </div>
        <div class="name">
          <span>登录密码</span>
        </div>
        <div class="value">
          <span>{{passwordData.value}}</span>
        </div>
        <div class="operate">
          <el-button plain @click="updatePassWord">修改密码</el-button>
        </div>
      </li>
      <li class="account-box">
        <div class="state">
          <svg class="icon" style="width: 21px;height: 21px" aria-hidden="true">
            <use xlink:href="#icontishi"></use>
          </svg>
        </div>
        <div class="name">
          <span>注销账户</span>
        </div>
        <div class="value">
          <span>{{logoutData.value}}</span>
        </div>
        <div class="operate">
          <el-button plain @click="deleteMe">注销帐号</el-button>
        </div>
      </li>
    </ul>
    <!--身份验证对话框-->
    <el-dialog title="绑定手机" :visible.sync="dialogPhone" :close-on-click-modal="false" width="30%" top="15vh">
      <h4 style="margin: 0 0 10px">你正在进行敏感操作，继续操作前请验证您的身份</h4>
      <!--验证身份表单-->
      <el-form :model="phoneForm" :rules="phoneRules" ref="phoneForm">
        <el-form-item label="密码验证" prop="passWord" required>
          <el-input show-password v-model="phoneForm.passWord" placeholder="请输入当前账号密码"></el-input>
        </el-form-item>
        <el-form-item label="手机号" prop="userPhone" required>
          <el-input v-model="phoneForm.userPhone" placeholder="请输入要绑定的手机号"></el-input>
        </el-form-item>
        <el-form-item label="'短信验证码" prop="checkCode">
          <el-input v-model="phoneForm.checkCode" :disabled="notEnable" placeholder="请输入短信验证码"></el-input>
          <el-button plain v-prevent-re-click @click="sendCode(phoneForm.userPhone,$event)" style="position: absolute;right:0;padding-bottom: 13px;top: 39px;">发送验证码</el-button>
        </el-form-item>
      </el-form>
      <!--对话框底部-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="cancelPhone('phoneForm')">取 消</el-button>
        <el-button type="primary" v-preventReClick @click="submitPhone('phoneForm')">确 定</el-button>
      </span>
    </el-dialog>
    <!--修改密码对话框-->
    <el-dialog title="修改密码" :visible.sync="dialogPass" :close-on-click-modal="false" width="30%" top="20vh">
      <!--修改密码表单-->
      <el-form :model="passForm" :rules="passRules" ref="passForm">
        <el-form-item label="当前密码" prop="passWord">
          <el-input show-password v-model="passForm.passWord" placeholder="请输入当前账号密码"></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="newPassWord" required inline-message>
          <el-input show-password v-model="passForm.newPassWord" placeholder="新密码和当前密码不能相同"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="checkPassWord" required>
          <el-input show-password v-model="passForm.checkPassWord" placeholder="确认密码和新密码保持一致"></el-input>
        </el-form-item>
      </el-form>
      <!--对话框底部-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="cancelPass('passForm')">取 消</el-button>
        <el-button type="primary" v-preventReClick @click="submitPass('passForm')">确 定</el-button>
      </span>
    </el-dialog>
    <!--身份验证对话框-->
    <el-dialog title="帐号安全验证" :visible.sync="dialogCheck" :close-on-click-modal="false" width="30%" top="25vh">
      <h4 style="margin: 0 0 10px">你正在进行敏感操作，继续操作前请验证您的身份</h4>
      <!--验证身份表单-->
      <el-form :model="checkForm" :rules="deleteRules" ref="checkForm">
        <el-form-item label="验证邮箱" prop="email" required>
          <el-input v-model="checkForm.email" disabled placeholder="用于验证的邮箱"></el-input>
        </el-form-item>
        <el-form-item label="邮箱验证码" prop="checkCode">
          <el-input auto-complete="new-password" autocomplete="off" v-model="checkForm.checkCode" :disabled="notMailEnable" placeholder="请输入邮箱验证码"></el-input>
          <el-button plain v-prevent-re-click @click="sendMailCode(checkForm.email,$event)" style="position: absolute;right:0;padding-bottom: 13px;top: 39px;">发送验证码</el-button>
        </el-form-item>
      </el-form>
      <!--对话框底部-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="cancelDelete('checkForm')">取 消</el-button>
        <el-button type="primary" v-preventReClick @click="submitCheck('checkForm')">确 定</el-button>
      </span>
    </el-dialog>
    <!--注销对话框-->
    <el-dialog :visible.sync="dialogLogout" :close-on-click-modal="false" width="40%" top="25vh">
      <div slot="title" class="dialog-title">
        <svg class="icon" aria-hidden="true" style="width: 20px;height: 20px;">
          <use xlink:href="#icontishi_"></use>
        </svg>
        <span class="title-text" style="font-size: 18px;">申请注销</span>
        <div class="button-right">
          <span class="title-close" @click="cancelLogout"></span>
        </div>
      </div>
      <div style="min-height: 280px;">
        <h3 style="color: #333333;margin-top: 5px">{{userInfo.userName}},您好</h3>
        <p>很遗憾，在线教育无法继续为您提供服务，感谢您一直以来的陪伴。</p>
        <p>注销帐号前，请检查是否满足一下条件，我们将对一下信息进行审核，以保证您的帐号安全；</p>
        <p class="tips">
          1、当前帐号无违规记录<br/>
          2、帐号无任何纠纷<br/>
          3、注销后帐号内的所有信息将无法恢复
        </p>
        <p style="text-align: center;">
          <el-button type="primary" size="small" @click="submitLogout">申请注销</el-button>
        </p>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  export default {
    name: "AccountCenter",
    data() {
      //身份验证，密码是否正确
      let validatePassWord = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入当前账号密码'));
        } else {
          //去后台比对，查看密码是否输入正确
          this.$loginApi.checkPassword(this.userInfo.userAccount,value).then(()=>{
            callback();
          }).catch(()=>{
            callback(new Error('密码错误'))
          })
        }
      };
      //验证手机号
      let validatePhone = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入手机号'));
        } else {
          if(this.$tools.checkPhone(value)){
            callback();
          }
          return callback(new Error('请输入正确的手机号'))
        }
      };
      //新密码校验规则
      let validatePass = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入新密码'));
        }else if(value === this.passForm.passWord){
          callback(new Error('新密码和当前密码不能相同'));
        } else {
          if (this.$tools.checkPass(value)) {
            callback();
          }
          return callback(new Error("密码必须字母开头，由数字和字母组合成，长度为6-18"))
        }
      };
      //确认密码校验规则
      let validatePass2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请再次输入密码'));
        } else if (value !== this.passForm.newPassWord) {
          callback(new Error('两次输入密码不一致!'));
        } else {
          callback();
        }
      };
      return{
        userVipInfo:null,
        dialogPhone:false,
        dialogPass:false,
        dialogCheck:false,
        dialogLogout:false,
        userInfo:null,
        accountData:{state:true, value:"1325554003@qq.com"},
        phoneData:{state:false, value:null},
        passwordData:{state:true, value:"********"},
        logoutData:{state:true, value:"注销后将无法恢复，请谨慎操作"},
        //默认短信验证码输入框不能使用，需发送验证码后才能可输入内容
        notEnable:true,
        notMailEnable:true,
        phoneForm:{
          passWord:'',
          userPhone:'',
          checkCode:'',
        },
        phoneRules:{
          passWord: [
            { validator: validatePassWord, trigger: 'blur' },
          ],
          userPhone: [
            { validator: validatePhone, trigger: 'blur' },
          ],
          checkCode: [
            { required: true, message: '请输入短信验证码', trigger: 'blur' },
          ],
        },
        //修改密码表单
        passForm:{
          passWord:'',
          newPassWord:'',
          checkPassWord:'',
        },
        passRules:{
          passWord: [
            { required: true, message: '请输入当前账号密码', trigger: 'blur' }
          ],
          newPassWord: [
            { validator: validatePass, trigger: 'blur' }
          ],
          checkPassWord: [
            { validator: validatePass2, trigger: 'blur' }
          ]
        },
        //注销账户
        checkForm:{
          email:'',
          checkCode:'',
        },
        deleteRules:{
          checkCode: [
            { required: true, message: '请输入邮箱验证码', trigger: 'blur' }
          ]
        },
      }
    },
    methods:{
      //复制帐号
      onCopy: function (e) {
       this.$message.success("复制成功！");
      },
      onError: function (e) {
        this.$message.warning("复制失败！");
      },
      //绑定手机号
      updatePhone() {
        this.dialogPhone=true;
      },
      // 发送手机验证码
      sendCode(phone,event){
        this.codeButtonTemp = event.currentTarget;
        this.$refs['phoneForm'].validateField('passWord', (passwordError) => {
          if(passwordError) return;
          this.$refs['phoneForm'].validateField('userPhone', (phoneError) => {
            if(phoneError) return;
            this.$globalApi.getPhoneCode(phone).then(()=>{
              this.$message.success("发送成功");
              this.$countDown.setItem(this.codeButtonTemp);
              this.notEnable=false;
            })
          });
        });
      },
      //提交手机号的修改
      submitPhone(formName){
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.$userApi.updatePhone(this.phoneForm).then(res=>{
              this.dialogPhone = false;
              this.$message.success(res.message);
              this.$countDown.removeItem(this.codeButtonTemp);
              this.phoneData.state=true;
              this.phoneData.value=this.phoneForm.userPhone;
              this.$userApi.getUserInfo().then(res=>{
                this.$store.commit("saveUserInfo",res.data);
              });
              this.$refs[formName].resetFields();
              this.notEnable=true;
            });
          } else {
            return false;
          }
        });
      },
      //取消绑定手机号
      cancelPhone(formName) {
        this.$refs[formName].resetFields();
        this.dialogPhone=false;
      },
      //修改密码
      updatePassWord(){
        this.dialogPass=true;
      },
      //开通VIP页面
      openVip(){
        this.$router.push("/memberDetails");
      },
      //提交修改密码
      submitPass(formName){
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.$userApi.updatePassWord(this.passForm).then(res=>{
              this.dialogPass=false;
              this.$refs[formName].resetFields();
              this.$message.success(res.message);
              this.$alert('当前身份已过期，请重新登录', '提示', {
                confirmButtonText: '确定',
                type: 'warning',
                callback: () => {
                  this.$cookie.clearToken();
                  this.$router.push("/loginForm");
                }
              });
            })
          } else {
            return false;
          }
        });
      },
      //取消修改密码
      cancelPass(formName) {
        this.$refs[formName].resetFields();
        this.dialogPass=false;
      },
      //注销账号
      deleteMe(){
       this.checkForm.email = this.userInfo.userAccount;
        this.dialogCheck=true;
      },
      // 发送邮箱验证码
      sendMailCode(email,event){
        this.codeButtonTemp = event.currentTarget;
        this.$refs['checkForm'].validateField('email', (emailError) => {
          if(emailError) return;
          this.$globalApi.getEmailCode(email,this.userInfo.userName).then(()=>{
            this.$message.success("发送成功");
            this.$countDown.setItem(this.codeButtonTemp);
            this.notMailEnable=false;
          })
        });
      },
      //取消修改密码
      cancelDelete(formName) {
        this.$refs[formName].resetFields();
        this.dialogCheck=false;
      },
      //验证身份
      submitCheck(formName){
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.$globalApi.checkEmailCode(this.checkForm).then(()=>{
              this.dialogCheck=false;
              this.$refs[formName].resetFields();
              this.dialogLogout=true;
            })
          } else {return false;}
        });
      },
      //取消注销
      cancelLogout(){
        this.dialogLogout=false;
      },
      //提交注销
      submitLogout(){
        this.$userApi.logoutUser().then(()=>{
          this.dialogLogout=false;
          this.$alert('注销成功，感谢您的使用', "成功", {
            confirmButtonText: '确定',
            type: 'success',
            callback: () => {
              this.$cookie.clearToken();
              this.$router.push("/loginForm");
            }
          });
        });
      },
    },
    created(){
      if(this.$store.state.userInfo!=null){
        this.userInfo = this.$store.state.userInfo;
        this.accountData.value=this.userInfo.userAccount;
        if(this.userInfo.userPhone){
          this.phoneData.state = true;
          this.phoneData.value = this.userInfo.userPhone;
        }
      }
      if(this.$store.state.vipInfo!=null){
        this.userVipInfo = this.$store.state.vipInfo;
        console.log(this.userVipInfo)
      }
    }
  }
</script>

<style scoped>
  .account-center{
    margin-top: 0;
    list-style: none;
  }

  .account-box{
    position: relative;
    height: 70px;
    line-height: 65px;
    margin-top: 10px;
    font-size: 18px;
    border-bottom: 1px solid #e6e6e6;
  }

  .account-box .state{
    position: absolute;
    top: 2px;
    left: 30px;
  }

  .account-box .state svg{
    width: 25px;
    height: 25px;
  }

  .account-box .name{
    position: absolute;
    left: 140px;
  }

  .account-box .value{
    position: absolute;
    left: 350px;
  }

  .account-box .operate{
    position: absolute;
    right: 80px;
  }

  .tips{
    color: #1890ff;
    line-height: 34px;
    font-weight: 500;
    font-size: 15px;
  }


</style>
