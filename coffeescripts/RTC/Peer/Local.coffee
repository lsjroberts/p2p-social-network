window.RTC or= {}
window.RTC.Peer or= {}

class window.RTC.Peer.Local extends window.RTC.Peer.Peer
    constructor: (name) ->
        super name
        this.connections = []

    connect: (remote) ->
        this.connections.push(remote.connect(this))

    send: (message) ->
        for connection in this.connections
            connection.send(message)