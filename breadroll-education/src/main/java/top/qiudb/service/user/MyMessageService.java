package top.qiudb.service.user;

import top.qiudb.pojo.message.MyMessage;

import java.util.List;

/**
 * @author Qiu
 * @email qiudb.top@aliyun.com
 * @date 2021/5/6 9:37
 * @description 我的消息
 */
public interface MyMessageService {
    //添加我的信息
    public Boolean insertMyMessage(MyMessage myMessage);

    //更新我的信息
    public Boolean updateMyMessage(MyMessage myMessage);

    //所有消息状态设为已读
    public Boolean readAllMessage(Integer userId);

    //根据用户id查询个人消息
    public List<MyMessage> queryMessageById(Integer userId,int pageNum, int pageSize);

    //查询总数
    public Integer queryCount(Integer userId);

    //判断用户个人是否有新消息
    public Boolean newMessageState(Integer userId);
}
