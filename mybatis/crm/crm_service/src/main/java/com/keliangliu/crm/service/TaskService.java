package com.keliangliu.crm.service;

import com.github.pagehelper.PageInfo;
import com.keliangliu.crm.entity.Task;

import java.util.List;
import java.util.Map;

public interface TaskService {


    void saveTask(Task task);

    List<Task> findByParams(Integer accountId,String showAll);

    Task findById(Integer id);

    void editTask(Task task);

    void delById(Integer id);
}
