window.Social or= {}

class window.Social.User
    constructor: (options = {}) ->
        self = this

        this.connections = {}

        # Check local storage for peerID
        storage = new Storage.Local('p2p')
        storage.forget('peerID')
        this.peerID = storage.get('peerID') ? this.generatePeerID()
        storage.put('peerID', this.peerID)

        this.peer = new Peer(this.peerID, options)

        this.peer.on('open', (id) ->
            Logger.trace('peer.on.open')
            Logger.log('Connected as: ' + id)
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

    call: (connectID, parentNode, callback) ->
        call = this.peer.call(connectID, this.video.stream.getStream())

        call.on('stream', (stream) ->
            Logger.trace('call.on.stream')
            Logger.log(stream)

            # parentNode = callback() ? parentNode

            remoteVideo = document.createElement('video')
            remoteVideo.autoplay = true

            remoteVideo.src = URL.createObjectURL(stream)
            remoteVideo.play()

            container = document.createElement('div')
            container.className = 'video-container'
            container.appendChild(remoteVideo)

            parentNode.appendChild(container)
        )

    connect: (connectID, options = {}) ->
        self = this

        connection = this.peer.connect(connectID, options)

        connection.on('open', ->
            Logger.trace('connection.on.open')
            self.addConnection(connection)

            if options.onOpen?
                options.onOpen(connection)
        )

        connection.on('data', (data) ->
            Logger.trace('connection.on.data')
            Logger.log(data)
        )

        connection.on('close', ->
            Logger.trace('connection.on.close')
        )

        connection.on('error', ->
            Logger.trace('connection.on.error')
        )

    send: (remote, message) ->
        this.peer.send(remote.peerID, message)

    broadcast: (message) ->
        for remote in this.connections
            this.send(remote, message)

    setVideo: (video) ->
        this.video = video

    addConnection: (connection) ->
        this.connections[connection.peer] = connection

    getConnection: (peerID) ->
        this.connections[peerID]

    generatePeerID: ->
        Math.random().toString(36).substr(2, 10)