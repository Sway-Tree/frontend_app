_.defaults this,
  Before: (object, methodName, adviseMethod) ->
    YouAreDaBomb(object, methodName).before(adviseMethod)
  BeforeAnyCallback: (object, methodName, adviseMethod) ->
    YouAreDaBomb(object, methodName).beforeAnyCallback(adviseMethod)
  After: (object, methodName, adviseMethod) ->
    YouAreDaBomb(object, methodName).after(adviseMethod)
  Around: (object, methodName, adviseMethod) ->
    YouAreDaBomb(object, methodName).around(adviseMethod)

$ = jQuery

class Server
  constructor: ->

  take_data: ->
    $.get 'http://0.0.0.0:3000/name_list', (data) ->
      $(".main").append(data)

class UseCase
  constructor: ->
    @names = ["Anette", "Henry", "Tarja", "Mia", "Callin", "Pauli"]

  start: ->
    console.log("hello")
    @writeNames(@names)

  writeNames: (names) =>

class Gui
  constructor: ->

  _createElementFor: (templateId, data) =>
    source = $(templateId).html()
    template = Handlebars.compile(source)
    html = template(data)
    element = $(html)

  showNames: (names) =>
    element = @_createElementFor("#show-names-template", {names : names})
    $(".main").append(element)

class Glue
  constructor: (@useCase, @gui)->
    After(@useCase, "writeNames", (names) => @gui.showNames(names))

class App
  constructor: ->
    console.log("hello")
    server = new Server()
    usecase = new UseCase()
    gui = new Gui()
    glue = new Glue(usecase, gui)

    usecase.start()
    server.take_data()


app = new App() 
