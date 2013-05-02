# Let application know when AJAX request starts and completes.
parent_sync = Backbone.sync
Backbone.sync = (method, model, options) ->
  options or (options = {})

  # Processing starts
  Notin.app.trigger "request:start"

  # Override parent success to know that processing is completed
  options.complete = (xhr, status) ->
    Notin.app.trigger "request:complete"

  parent_sync method, model, options