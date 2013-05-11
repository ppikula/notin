#= require hamlcoffee
#= require underscore-1.4.3.min
#= require json2
#= require backbone-0.9.9.min
#= require matchMedia
#= require keymaster.min
#= require jquery_ujs
#= require jquery.masonry-2.1.06.min
#= require jquery.dateFormat-1.0
#= require jquery.autosize-1.16.7.min
#= require showdown.min
#= require_self
#= require ./notin/lib/sync
#= require ./notin/lib/notes_mason
#= require ./notin/router
#= require ./notin/shourtcuts
#= require_tree ./notin/models
#= require_tree ./notin/collections
#= require_tree ./notin/views
#= require_tree ./templates/

# Create namespace
window.Notin =  {}

Notin.start = ->
  Notin.router = new Notin.Router
  Notin.app = new Notin.AppView

  $('#notin').html(Notin.app.render().$el)

  Backbone.history.start
    pushState: true
