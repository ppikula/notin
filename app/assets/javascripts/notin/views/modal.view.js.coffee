Notin.ModalView = Backbone.View.extend
  render: (template) ->
    $help = $('<div></div>')
    $help.html(JST[template])

    $.modal($help,
      # Don't allow any shortcuts.
      onShow: ->
        @prevScope = key.getScope()
        key.setScope('none')
      onClose: ->
        key.setScope(@prevScope)
        $.modal.close()
    )
