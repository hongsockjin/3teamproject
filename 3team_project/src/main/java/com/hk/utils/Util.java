package com.hk.utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Util {
	
	private String toDates;
	
	public void setToDates(String mDate) {
		
		//mDate를 날짜형식으로 편집한다. = yyyy-MM-dd hh:mm:ss
		String m = mDate.substring(0, 4)+"-" //year-
				+mDate.substring(4, 6)+"-"	 //year-month
				+mDate.substring(6, 8)+" "	 //"year-month-date"
				+mDate.substring(8, 10)+":"  //"year-month-date hh:"
				+mDate.substring(10)+":00";  //"year-month-date hh:mm:00"
		//문자열을 ---> date타입으로 변환하는 것!
		Timestamp tm = Timestamp.valueOf(m);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH:mm");
		this.toDates=sdf.format(tm);
	}

	public String getToDates() {
		return toDates;
	}
	
	//한자리수를 두자리수로 변환하는 메서드
	public static String isTwo(String s) {
	    return s.length()<2?"0"+s:s;
	}
	
	}
