define ["../config"], (config) ->
  dependenciesJs = [
    "bootstrapDatetimepicker"
  ]
  dependenciesCss = [
    "bootstrapCss"
    "bootstrapDatetimepickerCss"
  ]
  config.loadConfig()
  require ["jquery"], ($) ->
    $ ->
      $.each( dependenciesCss, (index, value) ->
        config.loadCss(value)
      )
      require dependenciesJs , () ->




        #config.init(dependenciesJs, dependenciesCss, () ->)

        # Classe utilitaire
        class BootstrapDatetimePickerUtils

          @withTimeIcon = (id) ->
            $(id).parent().addClass("input-append")
            $(id).parent().css("margin-left", "20px")
            $(id).after("<span class='add-on'><i class='icon-time'></i></span>")

          withCalendarIcon = (id) ->
            $(id).parent().addClass("input-append")
            $(id).parent().css("margin-left", "20px")
            $(id).after("<span class='add-on'><i class='icon-calendar'></i></span>")

          # datetimepicker - Date and Time
          @datetimepickerDateAndTime: (id) ->
            config.init(dependenciesJs, dependenciesCss, () ->
              $(id).datetimepicker
                format: 'dd/mm/yyyy hh:ii'
                daysOfWeekDisabled: [0,6]
                startView: 2
                minView: 0 # Précision Minutes
                maxView:3  # Précision Mois
                language: "fr"
                weekStart: 1
                autoclose: true
                todayBtn: true
                todayHighlight: true
                minuteStep: 15
              withCalendarIcon(id)
            )

          # datetimepicker - Date
          @datetimepickerDate: (id) ->
            $(id).datetimepicker
              format : 'dd/mm/yyyy'
              daysOfWeekDisabled: [0,6]
              startView: 2
              minView: 2
              maxView: 3
              language: "fr"
              weekStart: 1
              autoclose: true
            @withCalendarIcon(id)

          # datetimepicker - Date - Avec les Weekend
          @datetimepickerDateWithWeekEnd: (id) ->
            $(id).datetimepicker
              format : 'dd/mm/yyyy'
              startView: 2
              minView: 2
              maxView: 3
              language: "fr"
              weekStart: 1
              autoclose: true
            @withCalendarIcon(id)

          # datetimepicker - Time
          @datetimepickerTime: (id) ->
            $(id).datetimepicker
              format : 'hh:ii'
              daysOfWeekDisabled: [0,6]
              startView: 1
              minView: 0
              maxView: 1
              language: "fr"
              weekStart: 1
              autoclose: true
              minuteStep: 15
            @withTimeIcon(id)



