define ["requireJs-config"], (requireJsConfig) ->

  # Classe utilitaire
  class Utils

    # Calcul du nombre de caractères dans un textarea
    @charNumberTextArea: (idTextArea, idCharNumber) ->
      charNumber = $(idTextArea).val().length
      $(idCharNumber).text(charNumber)
      $(idTextArea).keyup ->
        $(idCharNumber).text(this.value.length)

    # Selon l'URL, coche ou non la checkbox portant l'id passé en paramètre
    # De même changement d'URL après action sur la checkbox
    # Utilisé pour l'alimentation des datatables
    @datatableChecked: (idCheckbox, urlTrue, urlFalse) ->
      # Url -> checkbox
      idValue = $.String.deparam(window.location.search.split('?')[1])[idCheckbox]
      $("#"+idCheckbox).attr('checked', new Boolean(idValue == "true").valueOf())

      # checkbox -> Url
      $("#"+idCheckbox).click ->
        thisCheck = $(this)
        if thisCheck.is(':checked')
          window.location = urlTrue
        else
          window.location = urlFalse

    # Gestion d'un "formulaire" de rafraîchissement des données d'un datatable
    # inputs dates range pour une date lié au données
    # Checkbox pour inclure un certain nombre de données ou pas
    # Prise en compte du cache
    @datatableFilterByDateAndCheckbox: (idCheckbox, idDateMin, idDateMax, idButton, url, cachePrefix, cache) ->
      $("#" + idDateMin).datetimepicker
        format: 'dd/mm/yyyy'
        daysOfWeekDisabled: [0,6]
        startView: 2
        minView: 2 # Précision Minutes
        maxView:4  # Précision Année
        language: "fr"
        weekStart: 1
        autoclose: true
        todayBtn: true
        todayHighlight: true

      $("#" + idDateMax).datetimepicker
        format: 'dd/mm/yyyy'
        daysOfWeekDisabled: [0,6]
        startView: 2
        minView: 2 # Précision Minutes
        maxView:4  # Précision Année
        language: "fr"
        weekStart: 1
        autoclose: true
        todayBtn: true
        todayHighlight: true

      # URL : Valeur des paramètres
      idCheckboxValue = $.String.deparam(window.location.search.split('?')[1])[idCheckbox]
      dateMin = $.String.deparam(window.location.search.split('?')[1])[idDateMin]
      dateMax = $.String.deparam(window.location.search.split('?')[1])[idDateMax]

      # Les propriétés renseignées dans l'URL prenent le pas sur le cache
      # Si différent de undefined
      if idCheckboxValue?
        cache.withX = idCheckboxValue
      else
        idCheckboxValue = cache.withX

      if dateMin?
        cache.dateDebut = dateMin
      else
        dateMin = cache.dateDebut

      if dateMax?
        cache.dateFin = dateMax
      else
        dateMax = cache.dateFin

      # On met à jour le cache
      jsRoutes.controllers.CacheController.updateTwoDatesAndBooleanPageFilter(cachePrefix, JSON.stringify(cache)).ajax
        context: this
        type: "POST"
        cache: false

      # Form : on attribue le valeurs
      $("#" + idCheckbox).attr('checked', new Boolean(idCheckboxValue == "true" || idCheckboxValue == true).valueOf())
      $("#" + idDateMin).val(dateMin)
      $("#" + idDateMax).val(dateMax)

      # Génére l'URL à partir des valeurs des inputs
      # Mise à jour du cache en conséquence
      urlCompleted = () ->
        isChecked = $("#"+idCheckbox).is(':checked')
        dateMin = $("#"+idDateMin).val()
        dateMax = $("#"+idDateMax).val()

        cache.withX = isChecked
        cache.dateDebut = dateMin
        cache.dateFin = dateMax

        # On met à jour le cache
        jsRoutes.controllers.CacheController.updateTwoDatesAndBooleanPageFilter(cachePrefix, JSON.stringify(cache)).ajax
          context: this
          type: "POST"
          cache: false
          success: (cache) ->
            window.location = url(isChecked, dateMin, dateMax)

      # checkbox -> Url
      $("#"+idCheckbox).change ->
        urlCompleted()

      # date input -> Url
      $("#"+idButton).click ->
        urlCompleted()

      # On retourne le cache
      cache

    @delay = (->
      timer = 0
      (callback, ms) ->
        clearTimeout timer
        timer = setTimeout(callback, ms)
        return
    )()

    @agentAutocomplete = (id, callBack) ->
      $(id).autocomplete
        source: (request, response) ->
          # Route du WS depuis jsRoutes defini dans Application#javascriptRoutes()
          # passer en paramètre la valeur de l'input (request.term)
          jsRoutes.controllers.admin.Utilisateurs.getListAgentsAsJson(request.term).ajax
            context: this
            cache: false
            dataType: "json"
            success: (data) ->
              # En cas de succès, action sur la réponse liste d'items.
              response $.map(data, (item) ->
                # l'autocomplete nécessite un couple (value, label)
                label: item.compteMatriculaire + " (" + item.prenom + " " + item.nom + " - " + item.structureMetierNom + ")"
                value: item.compteMatriculaire
              )
        # Longueur minimale pour appeler le WS.
        minLength: 2
        # Action à la sélection d'un élément
        select: (event, ui) ->
          callBack(ui.item.value)
          # position de la liste de suggestion
          position:
            my: "left top"
            at: "left bottom"
        open: () ->
          $('ul.ui-autocomplete').width('600px')

    @bootstrapDualListbox = (id, msgLeft, msgRight) ->
      $(id).bootstrapDualListbox
        preserveselectiononmove: "moved"
        moveonselect: true
        infotext: 'Affichage de tous les éléments : {0}'
        infotextfiltered: 'Affichage de {0} élément(s) sur {1}'
        infotextempty: 'Aucun élément dans la liste'
        initialfilterfrom: ''
        selectorminimalheight: 300
        helperselectnamepostfix: false
      $(id + "_field .bootstrap-duallistbox-container .box1").prepend($("<div>").html("<strong>" + msgLeft + "</strong>"))
      $(id + "_field .bootstrap-duallistbox-container .box2").prepend($("<div><strong>").html("<strong>" + msgRight + "</strong>"))