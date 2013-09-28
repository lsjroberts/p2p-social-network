window.RTC or= {}
window.RTC.Peer or= {}

class window.RTC.Peer.Local extends window.RTC.Peer.Peer
    constructor: (name) ->
        super name
        this.connections = []

    connect: (remote, success = null, failure = null) ->
        this.connections.push(remote.connect(this, success, failure))

    send: (message) ->
        Logger.trace('RTC.Peer.Local->send')
        Logger.log(message)
        for connection in this.connections
            connection.send(message)