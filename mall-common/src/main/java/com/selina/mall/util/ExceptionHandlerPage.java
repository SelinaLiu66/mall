package com.selina.mall.util;

import com.alibaba.csp.sentinel.adapter.spring.webmvc.callback.BlockExceptionHandler;
import com.alibaba.csp.sentinel.slots.block.BlockException;
import com.alibaba.csp.sentinel.slots.block.authority.AuthorityException;
import com.alibaba.csp.sentinel.slots.block.degrade.DegradeException;
import com.alibaba.csp.sentinel.slots.block.flow.FlowException;
import com.alibaba.csp.sentinel.slots.block.flow.param.ParamFlowException;
import com.alibaba.csp.sentinel.slots.system.SystemBlockException;
import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Writer;

/**
 * @author JiangYingbo
 */
@SuppressWarnings("all")
@Component
public class ExceptionHandlerPage implements BlockExceptionHandler {
    @Override
    public void handle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, BlockException e) throws Exception {
        //BlockException 异常接口,包含Sentinel的五个异常
        System.out.println("-------------------------------------执行ExceptionHandlerPage");
        //设置响应内容和中文字符集，需要在获取响应输出流之前执行
        httpServletResponse.setContentType("text/json;charset=utf-8");
        Writer writer = httpServletResponse.getWriter();
        if (e instanceof FlowException) {// FlowException 限流异常
            writer.write(JSON.toJSONString(new ResponseResult<>(500, "当前接口被限流了，请稍后重试~")));
            return;
        }
        if (e instanceof DegradeException) {// DegradeException 降级异常
            writer.write(JSON.toJSONString(new ResponseResult<>(500, "当前接口被降级了，请稍后重试~")));
            return;
        }
        if (e instanceof ParamFlowException) {// ParamFlowException 参数限流异常
            writer.write(JSON.toJSONString(new ResponseResult<>(500, "当前接口访问参数被限流了，请稍后重试~")));
            return;
        }
        if (e instanceof AuthorityException) {// AuthorityException 授权异常
            writer.write(JSON.toJSONString(new ResponseResult<>(500, "您没有当前接口的访问权限~")));
            return;
        }
        if (e instanceof SystemBlockException) {// SystemBlockException 系统负载异常
            writer.write(JSON.toJSONString(new ResponseResult<>(500, "系统过载保护中，请稍后重试~")));
            return;
        }
    }
}