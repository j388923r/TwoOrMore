package com.twoormore.twoormore_android;

import android.content.Intent;
import android.location.Geocoder;
import android.location.Address;
import android.support.design.widget.Snackbar;
import android.support.v4.app.DialogFragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class NewPrayerEventActivity extends AppCompatActivity implements OnMapReadyCallback {
    private static final String EXTRA_PREFIX = "com.twoormore.twoormore_android.";

    public static final String EXTRA_TITLE = EXTRA_PREFIX + "title";
    public static final String EXTRA_DESCRIPTION = EXTRA_PREFIX + "description";
    public static final String EXTRA_DATE = EXTRA_PREFIX + "date";
    public static final String EXTRA_HOUR = EXTRA_PREFIX + "hour";
    public static final String EXTRA_MINUTE = EXTRA_PREFIX + "minute";
    public static final String EXTRA_LATITUDE  =  EXTRA_PREFIX + "latitude";
    public static final String EXTRA_LONGITUDE = EXTRA_PREFIX + "longitude";
    public static final String EXTRA_MIT_ROOM  =  EXTRA_PREFIX + "mit_room";

    private static final int REQUEST_CODE_LOCATION_SEARCH = 989;

    private final int miniMapInitialZoom = 15;
    private final int miniMapSelectZoom = 18;

    private final Bundle mBundle = new Bundle();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new_prayer_event);


        // Set textviews for current date and time
        Date dateObj = new Date();
        DateFormat currentDate = DateFormat.getDateInstance();
        DateFormat currentTime = DateFormat.getTimeInstance(DateFormat.SHORT);
        mBundle.putDouble(EXTRA_HOUR, currentDate.getCalendar().get(Calendar.HOUR_OF_DAY));
        mBundle.putDouble(EXTRA_MINUTE, currentDate.getCalendar().get(Calendar.MINUTE));


        TextView dateValue = (TextView) findViewById(R.id.textView_dateValue);
        TextView timeValue = (TextView) findViewById(R.id.textView_timeValue);
        dateValue.setText(currentDate.format(dateObj));
        timeValue.setText(currentTime.format(dateObj));

                // TODO(?): Use current location by default
        TextView locationValue = (TextView) findViewById(R.id.textView_locationValue);
        String addressName = "77 Massachusetts Ave\nCambridge, MA 02139";
        locationValue.setText(addressName);

        SupportMapFragment miniMap = (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.newPrayerEvent_miniMap);
        miniMap.getMapAsync(this);
    }

    public void showDatePickerDialog(View view) {
        DialogFragment newFragment = new DatePickerFragment();
        newFragment.show(getSupportFragmentManager(), "datePicker");
    }

    public void showTimePickerDialog(View view) {
        DialogFragment newFragment = new TimePickerFragment();
        newFragment.show(getSupportFragmentManager(), "timePicker");
    }

    public void showLocationSearch(View view) {
        Intent intent = new Intent(this, LocationSearchActivity.class);

        startActivityForResult(intent, REQUEST_CODE_LOCATION_SEARCH);
    }

    public Bundle getBundle() {
        return mBundle;
    }

    public void savePrayerEvent(View view) {
        Editable titleText = ((EditText)findViewById(R.id.editText_eventName)).getText();
        if (titleText == null) {
            Snackbar.make(view, "Please provide a title for this event.", Snackbar.LENGTH_SHORT);
            return;
        }
        mBundle.putString(EXTRA_TITLE, titleText.toString());

        Editable descriptionText = ((EditText)findViewById(R.id.editText_description)).getText();
        if (descriptionText != null) {
            mBundle.putString(EXTRA_DESCRIPTION, descriptionText.toString());
        } else {
            mBundle.putString(EXTRA_DESCRIPTION, "");
        }

        Intent intent = new Intent(this, MainActivity.class);
        intent.putExtras(mBundle);

        startActivity(intent);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == REQUEST_CODE_LOCATION_SEARCH) {
            if (resultCode == RESULT_OK) {
                final TextView locationValue =  (TextView) findViewById(R.id.textView_locationValue);
                SupportMapFragment miniMap = (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.newPrayerEvent_miniMap);

                // Defaults are for 84 mass ave
                double lat = data.getDoubleExtra(LocationSearchActivity.INTENT_LAT_VALUE, 42.359291);
                double lng = data.getDoubleExtra(LocationSearchActivity.INTENT_LNG_VALUE, -71.093991);

                mBundle.putDouble(EXTRA_LATITUDE, lat);
                mBundle.putDouble(EXTRA_LONGITUDE, lng);

                String val = data.getStringExtra(LocationSearchActivity.INTENT_LOC_VALUE);
                locationValue.setText(val);

                final LatLng newLocation = new LatLng(lat, lng);
                miniMap.getMapAsync(new OnMapReadyCallback() {
                    @Override
                    public void onMapReady(GoogleMap googleMap) {
                        googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(newLocation, miniMapSelectZoom));
                        googleMap.clear();
                        googleMap.addMarker(new MarkerOptions().position(newLocation));
                    }
                });

            }
        }
    }

    @Override
    public void onMapReady(GoogleMap map) {
        //map.setMyLocationEnabled(true);

        String addressName = "77 Massachusetts Ave, Cambridge, MA";

        Geocoder geocoder = new Geocoder(this, Locale.getDefault());
        LatLng location;
        try {
            Address address = geocoder.getFromLocationName(addressName, 1).get(0);
            location = new LatLng(address.getLatitude(), address.getLongitude());
        } catch (IOException e) {
            location = new LatLng(42.359291,-71.093991); // 84 mass ave
        }

        map.moveCamera(CameraUpdateFactory.newLatLngZoom(location, miniMapInitialZoom));
        map.addMarker(new MarkerOptions().position(location));
    }
}
