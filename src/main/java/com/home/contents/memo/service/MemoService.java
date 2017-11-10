package com.home.contents.memo.service;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.home.contents.memo.entity.MemoEntity;
import com.home.contents.memo.repository.MemoRepository;

@Service
@Transactional
public class MemoService {
    private static final Logger logger = LoggerFactory.getLogger(MemoService.class);
    @Autowired
    MemoRepository memoRepository;
    @Autowired
    Environment environment;
    
    public MemoEntity insertMemo(String contents) {
    	Date date = new Date();
    	MemoEntity memo = new MemoEntity();
    	memo.setContents(contents);
    	memo.setCreatedDate(date);
    	memo.setIsDeleted("F");
    	memoRepository.save(memo);
    	return memo;
    }
    
    public void deleteMemo(Long seq) {
    	memoRepository.delete(seq);
    }
    
    public Page<MemoEntity> findMemoAll(PageRequest request) {
    	return memoRepository.findByIsDeleted("F", request);
    }
}
