package com.twoormore.twoormore_android;

import android.app.Dialog;
import android.support.v4.app.DialogFragment;
import android.app.TimePickerDialog;
import android.os.Bundle;
import android.text.format.DateFormat;
import android.view.View;
import android.widget.TextView;
import android.widget.TimePicker;

import java.util.Calendar;

/**
 * Created by osmid on 5/24/2016.
 */

public class TimePickerFragment extends DialogFragment
        implements TimePickerDialog.OnTimeSetListener {

    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        // Use the current time as the default values for the picker
        final Calendar c = Calendar.getInstance();
        int hour = c.get(Calendar.HOUR_OF_DAY);
        int minute = c.get(Calendar.MINUTE);

        // Create a new instance of TimePickerDialog and return it
        return new TimePickerDialog(getActivity(), this, hour, minute,
                DateFormat.is24HourFormat(getActivity()));
    }

    public void onTimeSet(TimePicker view, int hourOfDay, int minute) {
        ((NewPrayerEventActivity) getActivity()).getBundle().putInt(NewPrayerEventActivity.EXTRA_HOUR, hourOfDay);
        ((NewPrayerEventActivity) getActivity()).getBundle().putInt(NewPrayerEventActivity.EXTRA_MINUTE, minute);

        TextView timeValue = (TextView) getActivity().findViewById(R.id.textView_timeValue);
        timeValue.setText(hourOfDay + ":"  + minute);
    }
}
