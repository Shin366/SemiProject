package com.fortrip.com.app.common.util;

import java.security.SecureRandom;

public class TempPwUtil {
	private static final String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String CHAR_UPPER = CHAR_LOWER.toUpperCase();
    private static final String DIGITS = "0123456789";
    private static final String SYMBOLS = "!@#$%&";

    private static final String PASSWORD_ALLOW = CHAR_LOWER + CHAR_UPPER + DIGITS + SYMBOLS;
    private static final SecureRandom random = new SecureRandom();
    
    public static String generateSecureTempPassword(int length) {
    		if(length < 8)length = 8;
    		StringBuilder sb = new StringBuilder(length);
    		for(int i = 0; i < length; i++) {
    			int index = random.nextInt(PASSWORD_ALLOW.length());
    			sb.append(PASSWORD_ALLOW.charAt(index));
    		}
    		return sb.toString();
    }
}
