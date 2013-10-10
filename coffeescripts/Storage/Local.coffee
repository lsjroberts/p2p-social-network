window.Storage or= {}

class window.Storage.Local
    constructor: (@prefix) ->

    put: (key, value) ->
        localStorage[this.prefix + key] = value

    has: (key) ->
        return localStorage[this.prefix + key]?

    get: (key) ->
        if this.has(key)
            return localStorage[this.prefix + key]
        return null

    forget: (key) ->
        localStorage.removeItem(this.prefix + key)