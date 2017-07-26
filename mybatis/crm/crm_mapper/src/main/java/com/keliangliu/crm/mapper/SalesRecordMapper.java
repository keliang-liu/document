package com.keliangliu.crm.mapper;

import com.keliangliu.crm.entity.SalesRecord;

import java.util.List;

public interface SalesRecordMapper {
    void saveSalesRecord(SalesRecord salesRecord);

    List<SalesRecord> findBySalesId(Integer id);
}
