package controllers;

import play.mvc.Controller;
import play.mvc.Result;
import views.html.demo.fullcalendar;
import views.html.demo.bootstrapDatetimePicker;

public class Demo extends Controller {

    public static Result bootstrapDatetimePicker() {
        return ok(bootstrapDatetimePicker.render());
    }

    public static Result fullcalendar() {
        return ok(fullcalendar.render());
    }

}
