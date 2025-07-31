package com.d13nunes.plugins.appcoinssdk;

import com.getcapacitor.Logger;

public class AppCoinsSdk {

    public String echo(String value) {
        Logger.info("Echo", value);
        return value;
    }
}
