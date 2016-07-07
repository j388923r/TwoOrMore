package com.twoormore.twoormore_android;

import android.content.Intent;
import android.support.v4.app.DialogFragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.DatePicker;
import android.widget.TextView;

import java.util.Calendar;
import java.util.Locale;

public class NewPrayerEventActivity extends AppCompatActivity {
    private static final String EXTRA_PREFIX = "com.twoormore.twoormore_android.";

    public static final String EXTRA_BIBLE_VERSES =  EXTRA_PREFIX + "bible_verses";
    public static final String EXTRA_EVENT_NAME = EXTRA_PREFIX + "event_name";
    public static final String EXTRA_DESCRIPTION =  EXTRA_PREFIX + " description";
    public static final String EXTRA_MONTH = EXTRA_PREFIX + "month";
    public static final String EXTRA_DATE = EXTRA_PREFIX + "date";
    public static final String EXTRA_YEAR = EXTRA_PREFIX + "year";
    public static final String EXTRA_HOUR = EXTRA_PREFIX + "hour";
    public static final String EXTRA_MINUTE = EXTRA_PREFIX + "minute";
    public static final String EXTRA_LOCATION  =  EXTRA_PREFIX + "location";

    private final Bundle mBundle = new Bundle();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new_prayer_event);

        Calendar cal = Calendar.getInstance();
        String day = cal.getDisplayName(Calendar.DAY_OF_WEEK, Calendar.SHORT, Locale.getDefault());
        String month = cal.getDisplayName(Calendar.MONTH, Calendar.SHORT, Locale.getDefault());
        int date = cal.get(Calendar.DAY_OF_MONTH);
        int year = cal.get(Calendar.YEAR);

        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int minute = cal.get(Calendar.MINUTE);

        TextView dateValue = (TextView) findViewById(R.id.textView_dateValue);
        TextView timeValue = (TextView) findViewById(R.id.textView_timeValue);
        dateValue.setText(day + ", " + month + " " + date + ", " + year);
        timeValue.setText(hour + ":"  + minute);
    }

    public void showDatePickerDialog(View view) {
        DialogFragment newFragment = new DatePickerFragment();
        newFragment.show(getSupportFragmentManager(), "datePicker");
    }

    public void showTimePickerDialog(View view) {
        DialogFragment newFragment = new TimePickerFragment();
        newFragment.show(getSupportFragmentManager(), "timePicker");
    }

    public Bundle getBundle() {
        return mBundle;
    }

    public void savePrayerEvent(View view) {
        Log.d("Bundle values: ", mBundle.toString());

        Intent intent = new Intent(this, SavedPrayerEventsActivity.class);
        //TODO: server things here instead
        intent.putExtra(EXTRA_EVENT_NAME, ((TextView) findViewById(R.id.editText_eventName)).getText().toString());
        intent.putExtra(EXTRA_DESCRIPTION, ((TextView) findViewById(R.id.editText_description)).getText().toString());
        intent.putExtras(mBundle); // TODO: location, bible verses
        Log.d("NPEA Bundle values: ", mBundle.toString());
        Log.d("NPEA Intent values: ", intent.toString());
        Log.d("Event name: ", intent.getStringExtra(EXTRA_EVENT_NAME));

        startActivity(intent);
    }
}
