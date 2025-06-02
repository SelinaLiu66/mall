package com.selina.mall.product.service.impl;

import com.selina.mall.product.entity.Comment;
import com.selina.mall.product.mapper.CommentMapper;
import com.selina.mall.product.service.ICommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 商品评价表 服务实现类
 * </p>
 *
 * @author Selina
 * @since 2025-04-27
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

}
