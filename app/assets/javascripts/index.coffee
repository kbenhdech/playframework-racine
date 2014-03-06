dependenciesJs = [
  "bootstrapDatetimepicker"
  "fullcalendar"
]

dependenciesCss = [
  "fullcalendarCss"
  "bootstrapCss"
  "bootstrapDatetimepickerCss"
]

callback = () ->

  $("#datetimepicker").datetimepicker
    format: "yyyy-mm-dd hh:ii"

  # Initialisation du plugin
  $("#calendar").fullCalendar(
    # General Display
    header:
      left:   'title'
      center: 'month,agendaWeek,agendaDay'
      right:  'prev,today,next'
    firstDay: 1
    weekends: true
    weekMode: "liquid"
    weekNumbers: true
    aspectRatio: 1
    # View
    defaultView: 'agendaWeek'
    # Agenda Options
    allDaySlot: false
    allDayDefault: false
    slotMinutes: 15
    minTime: 8
    maxTime: 20
    axisFormat: "HH:00"
    slotEventOverlap: false # Evite la superposition visuelle d'évenements
    # Text/Time Customization
    timeFormat:
      agenda: 'HH:mm{ - HH:mm}'
      '': 'h(:mm)'
    columnFormat:
      month: 'ddd',
      week: 'ddd d/M',
      day: 'dddd d/M'
    titleFormat:
      month: 'MMMM yyyy'
      week: "d MMMM[ yyyy]{ 'au' d MMMM yyyy}"
      day: 'dddd d MMM yyyy'
    buttonText:
      prev:     '&lsaquo;' # <
      next:     '&rsaquo;' # >
      prevYear: '&laquo;'  # <<
      nextYear: '&raquo;'  # >>
      today:    'Aujourd\'hui'
      month:    'Mois',
      week:     'Semaine',
      day:      'Jour'
    monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet','Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre']
    monthNamesShort: ['Jan', 'Fev', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Aoû', 'Sep', 'Oct', 'Nov', 'Dec']
    dayNames: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi','Jeudi', 'Vendredi', 'Samedi']
    dayNamesShort: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi']
    weekNumberTitle: "S"

  )

require ["./config"], (config) ->
  config.init(dependenciesJs, dependenciesCss, callback)


