package com.twoormore.twoormore_android;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by osmid on 7/16/2016.
 */
public interface JSONProcessor {
    public void processJSON(JSONObject jsonObject) throws JSONException;
}
