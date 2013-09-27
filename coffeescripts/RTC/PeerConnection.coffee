window.RTC or= {}

window.RTCPeerConnection or= window.webkitRTCPeerConnection


class window.RTC.SignalingChannel
    constructor: ->
        Logger.trace('RTC.SignalingChannel->constructor')

    send: (message) ->
        Logger.trace('RTC.SignalingChannel->send')
        Logger.log(message)

    sendJSON: (message) ->
        Logger.trace('RTC.SignalingChannel->sendJSON')
        Logger.log(message)

        this.send(JSON.stringify(message))

    onMessage: (event) ->
        Logger.trace('RTC.SignalingChannel->onMessage')

        this.onMessageCallback(event)

    setOnMessageCallback: (callback) ->
        this.onMessageCallback = callback


class window.RTC.PeerConnection
    constructor: (@config = null, @channel = new RTC.SignalingChannel) ->
        Logger.trace('RTC.PeerConnection->constructor')

        this.conn = new RTCPeerConnection(config)

        this.conn.onicecandidate = this.onIceCandidate
        this.conn.onaddstream = this.onAddStream

        self = this

        this.channel.setOnMessageCallback((event) -> self.onMessage(event))

    addStream: (stream) ->
        Logger.trace('RTC.PeerConnection->addStream')
        Logger.log(stream)

        self = this

        this.conn.addStream(stream.getStream())

    gotDescription: (desc) ->
        this.conn.setLocalDescription(desc)
        this.channel.sendJSON({sdp: desc})

    onIceCandidate: (event) ->
        Logger.trace('RTC.PeerConnection->onIceCandidate')
        Logger.log(event)

        this.channel.sendJSON({'candidate': event.candidate})

    onAddStream: (event) ->
        Logger.trace('RTC.PeerConnection->onAddStream')
        Logger.log(event)

        this.streams.push(event.stream)

    onMessage: (event) ->
        Logger.trace('RTC.PeerConnection->onMessage')


class window.RTC.LocalPeerConnection extends window.RTC.PeerConnection
    addStream: (stream) ->
        super stream
        this.conn.createOffer((desc) -> self.gotDescription(desc))

    onMessage: (event) ->
        super event
        signal = JSON.parse(event.data)

        if signal.sdp
            this.conn.setRemoteDescription(new RTCSessionDescription(signal.sdp))
        else if signal.candidate
            this.conn.addIceCandidate(new RTCIceCandidate(signal.candidate))


class window.RTC.RemotePeerConnection extends window.RTC.PeerConnection
    addStream: (stream) ->
        super stream
        this.conn.createAnswer(this.remoteDescription, (desc) -> self.gotDescription(desc))