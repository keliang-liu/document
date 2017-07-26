package com.keliangliu.crm.serviceImpl;


import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.entity.Customer;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.formula.functions.Column;
import org.apache.poi.ss.formula.functions.Rows;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import java.io.*;

public class CustomerServiceImplTest {


    public static void main(String[] args) {
        Customer customer = new Customer();

        try {
            InputStream in = new BufferedInputStream(new FileInputStream(new File("D:/customer.xls-")));
            Workbook workbook = new HSSFWorkbook(in);
            int sheets = workbook.getNumberOfSheets();
            Sheet sheet = workbook.getSheetAt(0);
            int rows = sheet.getPhysicalNumberOfRows();

            for(int i = 1; i <= rows; i++ ) {
                Row row = sheet.getRow(i);
                System.out.println(row.getCell(0).getStringCellValue());
                System.out.println(row.getCell(1).getStringCellValue());
                System.out.println(row.getCell(2).getStringCellValue());
                System.out.println(row.getCell(3).getStringCellValue());
                System.out.println(row.getCell(4).getDateCellValue());
                System.out.println(row.getCell(5).getDateCellValue());

            }

        } catch (IOException e) {
            e.printStackTrace();
        }




    }




}
