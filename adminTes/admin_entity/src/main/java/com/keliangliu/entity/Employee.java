package com.keliangliu.entity;

import java.io.Serializable;

/**
 * @author 
 */
public class Employee implements Serializable {
    private Integer id;

    /**
     * 员工姓名
     */
    private String empName;

    /**
     * 员工的姓名
     */
    private String empTel;

    /**
     * 员工的邮箱账号
     */
    private String empEmail;

    /**
     * 员工的性别
     */
    private String sex;

    /**
     * 员工的部门id
     */
    private Integer deptId;

    /**
     * 是否时领导 1：是 2：不是
     */
    private Integer isOrder;

    private Dept dept;

    public void setDept(Dept dept) {
        this.dept = dept;
    }

    public Dept getDept() {
        return dept;
    }

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getEmpTel() {
        return empTel;
    }

    public void setEmpTel(String empTel) {
        this.empTel = empTel;
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public Integer getIsOrder() {
        return isOrder;
    }

    public void setIsOrder(Integer isOrder) {
        this.isOrder = isOrder;
    }

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        Employee other = (Employee) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getEmpName() == null ? other.getEmpName() == null : this.getEmpName().equals(other.getEmpName()))
            && (this.getEmpTel() == null ? other.getEmpTel() == null : this.getEmpTel().equals(other.getEmpTel()))
            && (this.getEmpEmail() == null ? other.getEmpEmail() == null : this.getEmpEmail().equals(other.getEmpEmail()))
            && (this.getSex() == null ? other.getSex() == null : this.getSex().equals(other.getSex()))
            && (this.getDeptId() == null ? other.getDeptId() == null : this.getDeptId().equals(other.getDeptId()))
            && (this.getIsOrder() == null ? other.getIsOrder() == null : this.getIsOrder().equals(other.getIsOrder()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getEmpName() == null) ? 0 : getEmpName().hashCode());
        result = prime * result + ((getEmpTel() == null) ? 0 : getEmpTel().hashCode());
        result = prime * result + ((getEmpEmail() == null) ? 0 : getEmpEmail().hashCode());
        result = prime * result + ((getSex() == null) ? 0 : getSex().hashCode());
        result = prime * result + ((getDeptId() == null) ? 0 : getDeptId().hashCode());
        result = prime * result + ((getIsOrder() == null) ? 0 : getIsOrder().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", empName=").append(empName);
        sb.append(", empTel=").append(empTel);
        sb.append(", empEmail=").append(empEmail);
        sb.append(", sex=").append(sex);
        sb.append(", deptId=").append(deptId);
        sb.append(", isOrder=").append(isOrder);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}