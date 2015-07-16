window.RailsFoo =
  welcome:
    setup: ->
      @sayHello()
      return
    sayHello: ->
      console.log 'Hey yourself!'
      return
