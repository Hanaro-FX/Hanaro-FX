package com.hana.app.frame;

import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface BaseService<K, V> {

    @Transactional
    int insert(V v) throws Exception;

    @Transactional
    int delete(K k) throws Exception;

    @Transactional
    int update(V v) throws Exception;

    V selectOne(K k) throws Exception;

    List<V> selectAll() throws Exception;
}
