package com.keliangliu.util;

import java.io.UnsupportedEncodingException;

/**
 * Created by lkl on 2017/7/19.
 */
public class IsoToUtf {

    public static String isoToUtf(String str)  {
        if(str != null) {
            try {
                str = new String(str.getBytes("ISO-8859-1"),"UTF-8");
                return str;
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }

        }

        return null;
    }

}
