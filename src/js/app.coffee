_.defaults this,
  Before: (object, methodName, adviseMethod) ->
    YouAreDaBomb(object, methodName).before(adviseMethod)
  BeforeAnyCallback: (object, methodName, adviseMethod) ->
    YouAreDaBomb(object, methodName).beforeAnyCallback(adviseMethod)
  After: (object, methodName, adviseMethod) ->
    YouAreDaBomb(object, methodName).after(adviseMethod)
  Around: (object, methodName, adviseMethod) ->
    YouAreDaBomb(object, methodName).around(adviseMethod)

class Server
  constructor: ->

  take_data: ->
    console.log("dupa")
    $.ajax(
          type: "GET"
          url: "http://sway-backend-app.shellyapp.com/name_list.json"
          success: (names) =>
            console.log("success")
            console.log(names)
            @data_taken(names)
          error: =>
            console.log("fail")
          )
      

  data_taken: (data) ->

class UseCase
  constructor: ->
    @names = ["Anette", "Henry", "Tarja", "Mia", "Callin", "Pauli"]

  start: (@server)->
    @writeNames(@names)
    @server.take_data()

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
  constructor: (@useCase, @gui, @server)->
    After(@useCase, "writeNames", (names) => @gui.showNames(names))
    After(@server, "data_taken", (data) => gui.showNames(data))

class App
  constructor: ->
    console.log("hello")
    usecase = new UseCase()
    gui = new Gui()
    server = new Server()
    glue = new Glue(usecase, gui, server)

    usecase.start(server)


app = new App() 
