package com.twoormore.twoormore_android;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

public class LocationSearchActivity extends AppCompatActivity implements JSONProcessor {

    public static final String EXTRA_LOCATION_SEARCH_LONGITUDE = MainActivity.EXTRA_PREFIX + "LOCATION_SEARCH_LONGITUDE";
    public static final String EXTRA_LOCATION_SEARCH_LATITUDE = MainActivity.EXTRA_PREFIX + "LOCATION_SEARCH_LATITUDE";
    public static final String INTENT_LAT_VALUE = "INTENT_LAT_VALUE";
    public static final String INTENT_LNG_VALUE = "INTENT_LNG_VALUE";
    public static final String INTENT_LOC_VALUE = "INTENT_LOC_VALUE";

    private final String latitudeKey = "lat_wgs84";
    private final String longitudeKey = "long_wgs84";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_location_search);
    }

    public void setPrayerLocation(View view) throws Exception{
        EditText locationTextBox = (EditText) findViewById(R.id.editText_newPrayerLocation);
        String location = locationTextBox.getText().toString();
        String buildingNumber = location.split("-")[0];

        Log.d("THIS_IS_LOCATION", location);
        Log.d("THIS_IS_BUILDING", buildingNumber);
        String whereIsMitPrefix = "http://whereis.mit.edu/search?type=query&output=json&q=building%20";

        String whereIsMitUrl = whereIsMitPrefix + buildingNumber;
        new ParseJson(this).execute(whereIsMitUrl);
    }

    @Override
    public void processJSON(JSONObject jsonObject) throws JSONException {
        double lat = jsonObject.getDouble(latitudeKey);
        double lng = jsonObject.getDouble(longitudeKey);

        String roomNumber = ((EditText)findViewById(R.id.editText_newPrayerLocation)).getText().toString();
        String buildingNumber = roomNumber.split("-")[0];

        Intent intent = new Intent(this, NewPrayerEventActivity.class);
        intent.putExtra(INTENT_LOC_VALUE, "MIT Building " + buildingNumber);
        intent.putExtra(INTENT_LAT_VALUE, lat);
        intent.putExtra(INTENT_LNG_VALUE, lng);

        setResult(RESULT_OK, intent);
        finish();
    }

    private class ParseJson extends AsyncTask<String, Void, JSONObject> {

        private JSONProcessor jsonProcessor;

        public ParseJson(JSONProcessor jsonProcessor) {
            this.jsonProcessor = jsonProcessor;
        }

        @Override
        protected JSONObject doInBackground(String... params) {
            String url = params[0];

            Log.d("THIS_IS_URL", url);
            try {
                InputStreamReader inputStream = new InputStreamReader(new URL(url).openStream());
                StringBuilder jsonBuilder = new StringBuilder();

                BufferedReader bufferedReader = new BufferedReader(inputStream);

                for (int c = bufferedReader.read(); c != -1; c = bufferedReader.read()) {
                    jsonBuilder.append((char) c);
                }
                inputStream.close();

                JSONArray json = new JSONArray(jsonBuilder.toString());
                return json.getJSONObject(0);
            } catch(Exception e) {
                e.printStackTrace();
            }
            return new JSONObject();
        }

        @Override
        protected void onPostExecute(JSONObject jsonObject) {
            try {
                this.jsonProcessor.processJSON(jsonObject);
            } catch(JSONException e) {

            }
        }
    }
}
