require ["../utils/bootstrapDatetimePicker-utils"], (bootstrapDatetimePickerUtils) ->
  require ["jquery"], ($) ->
    $ ->

      bootstrapDatetimePickerUtils.datetimepickerDateAndTime("#datetimepicker")
