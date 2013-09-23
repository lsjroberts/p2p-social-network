window.RTC or= {}
window.RTC.Peer or= {}

class window.RTC.Peer.Peer
    constructor: (@name) ->
        this.connections = []

    connect: (peer) ->
        this.connections.push(
            new window.RTC.Connection.Local(this, peer)
        )

    send: (message) ->
        for connection in this.connections
            connection.send(message)