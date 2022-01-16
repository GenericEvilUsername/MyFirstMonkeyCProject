import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.ActivityMonitor;
using Toybox.Time.Gregorian as Calendar;

class MyMonkeyView extends WatchUi.WatchFace {

    var font24;
    var font_sec;
    var font_date;
    var is24Hour;

    function initialize() {
        var settings = System.getDeviceSettings();
        is24Hour = settings.is24Hour;
        WatchFace.initialize();
    
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        
        setLayout(Rez.Layouts.WatchFace(dc));
        /*font24 = WatchUi.loadResource(Rez.Fonts.digital24);
        font_sec = WatchUi.loadResource(Rez.Fonts.digital_sec);

        font_date = WatchUi.loadResource(Rez.Fonts.digital_date);
     
        var font_am = WatchUi.loadResource(Rez.Fonts.ampm);    
        var dateDim = dc.getTextDimensions("2", font_date);
        var dateDim2 = dc.getTextDimensions("06-30", font_date);
        var dateDim3 = dc.getTextDimensions("55544", font_date);
        var pm = dc.getTextDimensions("PM", font_am);
        var timeSize = dc.getTextWidthInPixels("23:32", font24);   
        var timeHeight = dc.getTextDimensions("1", font24); 
        var timeHeight2 = dc.getTextDimensions("24", font24); 
        var colHeight = dc.getTextDimensions(":", Graphics.FONT_LARGE);     
        var secSize = dc.getTextDimensions("00", font_sec);
*/
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = System.getClockTime();

         var now = Time.now();
        var info = Calendar.info(now, Time.FORMAT_SHORT);
       

        var hour = clockTime.hour;
        var am = "";
        if(!is24Hour) {
            if(hour > 12) {
                hour = hour - 12;
                am = "PM";
            } else {
                am = "AM";
            }
        }
        

        
        
        var ampm = View.findDrawableById("ampm") as Text;
        ampm.setText(am);
        
        var hours = View.findDrawableById("hours") as Text;
        hours.setText(hour.toString());
        
        var col = View.findDrawableById("col") as Text;
        col.setText(":");
        var minutes = View.findDrawableById("minutes") as Text;
        minutes.setText(clockTime.min.format("%02d"));

        var sec = View.findDrawableById("SecLabel") as Text;
        var secString = clockTime.sec.format("%02d");
        sec.setText(secString);

        var date = View.findDrawableById("DateLabel") as Text;
        var dateStr = Lang.format("$1$-$2$", [info.month.format("%02d"), info.day.format("%02d")]);
        date.setText(dateStr);

        var steps = View.findDrawableById("StepsLabel") as Text;
        var stepStr = ActivityMonitor.getInfo().steps;
        steps.setText(stepStr.toString());

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
