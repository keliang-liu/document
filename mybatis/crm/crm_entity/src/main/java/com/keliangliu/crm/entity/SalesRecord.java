package com.keliangliu.crm.entity;

import java.io.Serializable;
import java.util.Date;

public class SalesRecord implements Serializable {
    private static final long serialVersionUID = -3914955793112062768L;


    private Integer id;
    private String content;
    private Integer salesId;
    private Date updateTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getSalesId() {
        return salesId;
    }

    public void setSalesId(Integer salesId) {
        this.salesId = salesId;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
