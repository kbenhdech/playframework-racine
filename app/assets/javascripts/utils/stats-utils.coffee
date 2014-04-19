define ["requireJs-config"], (requireJsConfig) ->

  # Classe utilitaire
  class StatsUtils

    # Définition de la fonction de contruction du graphique de la pyramide des âges
    @pyramidAgeBuildChart: (id, title, subtitle, categories, numberSubject, seriesMale, seriesFemale, percentMax) ->
      chartData =
        chart:
          renderTo: id
          type: "bar"
        title:
          text: title
        subtitle:
          text: subtitle
        xAxis: [
          categories: categories
          lineColor: "#FF0000"
          reversed: false
        ,
          # mirror axis on right side
          opposite: true
          reversed: false
          categories: categories
          linkedTo: 0
        ]
        colors: ["#4572A7", "#AA4643", "#89A54E", "#80699B", "#3D96AE", "#DB843D", "#92A8CD", "#A47D7C", "#B5CA92"]
        yAxis:
          title:
            text: null
          labels:
            formatter: ->
              Math.abs(@value) + "%"
          min: percentMax * -1
          max: percentMax
        plotOptions:
          bar:
            stacking: "normal"
        tooltip:
          formatter: ->
            "<b>" + @series.name + ", Age: " + @point.category + "</b><br/>" + numberSubject + ": " + Highcharts.numberFormat(Math.abs(@point.y), 1) + "%"
        series: [
          name: "Homme"
          data: seriesMale
        ,
          name: "Femme"
          data: seriesFemale
        ]
      chart = new Highcharts.Chart(chartData)

    # Définition de la fonction de contruction d'un Pie Chart
    @pieChart: (id, title, data) ->
      $(id).highcharts
        chart:
          plotBackgroundColor: null
          plotBorderWidth: null
          plotShadow: false
        title:
          text: title
        tooltip:
          formatter: ->
            "<b>" + @point.name + "</b><br />" + "Nombre : " + @y + " (" + Math.round(@percentage*100)/100 + " %)"
        plotOptions:
          pie:
            allowPointSelect: true
            cursor: "pointer"
            dataLabels:
              enabled: true
              color: "#000000"
              connectorColor: "#000000"
              formatter: ->
                "<b>" + @point.name + "</b>: " + "" + @y + " (" + Math.round(@percentage*100)/100 + " %)"
            showInLegend: true
        series: [
          type: "pie"
          name: "Nombre"
          data: data
        ]

    # Définition de la fonction de contruction d'un Column Chart
    @columnChart: (id, title, subtitle, data) ->
      $(id).highcharts
        chart:
          type: "column"
        title:
          text: title
        subtitle:
          text: subtitle
        xAxis:
          categories: []
        yAxis:
          min: 0
          title:
            text: "Nombre"
        tooltip:
          headerFormat: "<table>"
          pointFormat: "<tr><td style=\"color:{series.color};padding:0\">{series.name}: </td>" + "<td style=\"padding:0\"><b>{point.y}</b></td></tr>"
          footerFormat: "</table>"
          shared: true
          useHTML: true
        plotOptions:
          column:
            pointPadding: 0.2
            borderWidth: 0
        series: data