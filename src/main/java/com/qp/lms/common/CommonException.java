package com.qp.lms.common;

import java.util.Date;

public class CommonException extends RuntimeException {


    public static final long serialVersionUID = 1L;
    private String courtName;
    private Date date;
    private int hour;

    public CommonException(String courtName, Date date, int hour) {
        this.courtName = courtName;
        this.date = date;
        this.hour = hour;
    }

    public String getCourtName() {
        return courtName;
    }

    public Date getDate() {
        return date;
    }

    public int getHour() {
        return hour;
    }
}
