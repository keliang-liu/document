package com.keliangliu.crm.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.keliangliu.crm.entity.Task;
import com.keliangliu.crm.mapper.TaskMapper;
import com.keliangliu.crm.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class TaskServiceImpl implements TaskService {


    @Autowired
    private TaskMapper taskMapper;


    @Override
    public void saveTask(Task task) {

        taskMapper.saveTask(task);

    }

    @Override
    public List<Task> findByParams(Integer accountId,String showAll) {

       return  taskMapper.findByParams(accountId,showAll);

    }

    @Override
    public Task findById(Integer id) {
        return taskMapper.findById(id);
    }

    @Override
    public void editTask(Task task) {
        taskMapper.editTask(task);
    }

    @Override
    public void delById(Integer id) {
        taskMapper.delById(id);
    }
}
