package com.selina.mall.util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 工具类，作用是封装请求的响应结果
 *
 * @param <T>
 */
@SuppressWarnings("all")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResponseResult<T> {
    private Integer code;//响应状态码
    private String message;//响应消息文本
    private T data;//查询时将查询结果进行封装

    public ResponseResult(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public static <T> ResponseResult<T> success(T data) {
        ResponseResult<T> result = new ResponseResult<>();
        result.setCode(200);
        result.setMessage("操作成功");
        result.setData(data);
        return result;
    }

    public static <T> ResponseResult<T> failure(T data) {
        ResponseResult<T> result = new ResponseResult<>();
        result.setCode(210);
        result.setMessage("操作失败");
        result.setData(data);
        return result;
    }
}