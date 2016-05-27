package com.twoormore.twoormore_android;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.support.v4.app.DialogFragment;
import android.os.Bundle;
import android.text.format.DateFormat;
import android.widget.DatePicker;
import android.widget.TextView;
import android.widget.TimePicker;

import java.util.Calendar;
import java.util.Locale;

/**
 * Created by osmid on 5/24/2016.
 */

public class DatePickerFragment extends DialogFragment
        implements DatePickerDialog.OnDateSetListener {

    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        // Use the current date as the default values for the picker
        final Calendar c = Calendar.getInstance();
        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH);
        int day = c.get(Calendar.DAY_OF_MONTH);

        // Create a new instance of DatePickerDialog and return it
        return new DatePickerDialog(getActivity(), this, year, month, day);
    }

    @Override
    public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
        Calendar cal = Calendar.getInstance();
        String day = cal.getDisplayName(Calendar.DAY_OF_WEEK, Calendar.SHORT, Locale.getDefault());
        String month = cal.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.getDefault());

        ((NewPrayerEventActivity) getActivity()).getBundle().putInt(NewPrayerEventActivity.EXTRA_MONTH, monthOfYear);
        ((NewPrayerEventActivity) getActivity()).getBundle().putInt(NewPrayerEventActivity.EXTRA_DATE, dayOfMonth);
        ((NewPrayerEventActivity) getActivity()).getBundle().putInt(NewPrayerEventActivity.EXTRA_YEAR, year);

        TextView dateView = (TextView) getActivity().findViewById(R.id.textView_dateValue);
        dateView.setText(day + ", "  + month + " " + dayOfMonth + ", " + year);
    }
}
