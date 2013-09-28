window.Social or= {}

class window.Social.User
    constructor: (options = {}) ->
        self = this

        this.peerID = this.generatePeerID()
        this.peer = new Peer(this.peerID, options)

        this.peer.on('open', (id) ->
            Logger.trace('peer.on.open')
            Logger.log(id)
        )

        this.peer.on('connection', (conn) ->
            Logger.trace('peer.on.connection')
            Logger.log(conn)
        )

        this.peer.on('call', (call) ->
            Logger.trace('peer.on.call')
            Logger.log(call)

            call.answer(self.video.stream.getStream())
        )

        this.peer.on('error', (err) ->
            Logger.error(err.message)
        )

    call: (connectID, parentNode) ->
        call = this.peer.call(connectID, this.video.stream.getStream())

        call.on('stream', (stream) ->
            Logger.trace('call.on.stream')
            Logger.log(stream)

            remoteVideo = document.createElement('video')
            remoteVideo.autoplay = true

            remoteVideo.src = URL.createObjectURL(stream)
            remoteVideo.play()

            parentNode.appendChild(remoteVideo)
        )

    send: (remote, message) ->
        this.peer.send(remote.peerID, message)

    broadcast: (message) ->
        for remote in this.connections
            this.send(remote, message)

    setVideo: (video) ->
        this.video = video

    generatePeerID: ->
        Math.random().toString(36).substr(2, 10)