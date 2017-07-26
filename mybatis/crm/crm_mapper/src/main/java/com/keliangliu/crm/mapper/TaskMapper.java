package com.keliangliu.crm.mapper;


import com.keliangliu.crm.entity.Task;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TaskMapper {


    void saveTask(Task task);


    List<Task> findByParams(@Param("accountId") Integer accountId, @Param("showAll") String showAll);

    Task findById(Integer id);

    void editTask(Task task);

    void delById(Integer id);
}
