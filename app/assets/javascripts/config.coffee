define [], () ->

  class Config

    ###################################################################################
    #
    #   Configuration requireJs
    #
    ###################################################################################
    @loadConfig = () ->
      require.config
        baseUrl: ""
        paths:
          jquery: "webjars/jquery/2.1.0/jquery"
          bootstrap: "webjars/bootstrap/3.1.1/js/bootstrap"
          fullcalendar: "webjars/fullcalendar/1.6.4/fullcalendar"
          bootstrapDatetimepicker: "webjars/bootstrap-datetimepicker/2.2.0/js/bootstrap-datetimepicker"
        shim:
          jquery:
            exports: "$"

    ###################################################################################
    #
    #   Tableau de correspondance : nom fichier CSS -> Chemin fichier CSS
    #
    ###################################################################################
    cssPath = () ->
      tab =
        fullcalendarCss : "webjars/fullcalendar/1.6.4/fullcalendar.css"
        bootstrapCss: "webjars/bootstrap/3.1.1/css/bootstrap.min.css"
        bootstrapDatetimepickerCss: "webjars/bootstrap-datetimepicker/2.2.0/css/bootstrap-datetimepicker.min.css"

    ###################################################################################
    #
    #   Modification du DOM pour chargement fichier CSS
    #
    ###################################################################################
    @loadCss = (cssName) ->
      url = cssPath()[cssName]
      link = document.createElement("link")
      link.type = "text/css"
      link.rel = "stylesheet"
      link.href = url
      document.getElementsByTagName("head")[0].appendChild(link)

    ###################################################################################
    #
    #   Initialisation
    #   Appelé depuis un autre fichier javascript
    #
    ###################################################################################
    @init = (dependenciesJs, dependenciesCss, callback) ->
      loadConfig()
      require ["jquery"], ($) ->
        $ ->
          $.each( dependenciesCss, (index, value) ->
            loadCss(value)
          )
          require dependenciesJs , () ->
            callback()


