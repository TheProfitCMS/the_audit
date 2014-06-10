@TheAudit = do ->
  init: ->
    $('@ctrl_acts select').on 'change', (e) ->
      select = $ e.target
      value = select.val()

      location.href = if value.length
        "?controller_action=#{ $(e.target).val() }"
      else
        "?"
