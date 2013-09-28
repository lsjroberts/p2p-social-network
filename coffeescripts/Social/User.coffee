window.Social or= {}

class window.Social.User
    constructor: (options = {}) ->
        this.peerID = this.generatePeerID()
        this.peer = new Peer(this.peerID, options)

    call: (remote, stream) ->
        call = this.peer.call(remote.peerID, stream)

    send: (remote, message) ->
        this.peer.send(remote.peerID, message)

    broadcast: (message) ->
        for remote in this.connections
            this.send(remote, message)

    generatePeerID: ->
        Math.random().toString(36).substr(2, 10)