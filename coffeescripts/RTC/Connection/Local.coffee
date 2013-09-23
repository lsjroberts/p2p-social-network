window.RTC or= {}
window.RTC.Connection or= {}

class window.RTC.Connection.Local extends window.RTC.Connection.Connection
    constructor: (local, remote) ->
        super local,remote
