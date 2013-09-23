window.RTC or= {}
window.RTC.Connection or= {}

class window.RTC.Connection.Connection
    constructor: (@local, @remote) ->
        servers = null
        this.conn = new RTCPeerConnection(servers, {
            optional: [{RtpDataChannels: true}]
        })
        this.conn.onconnection   = this.onConnection
        this.conn.onicecandidate = this.onIceCandidate
        this.conn.onopen         = this.onOpen
        this.conn.onclose        = this.onClose

    send: (message) ->
        window.Logger.trace('RTC.Connection.Connection->send')
        if this.channel
            this.channel.send(message)
        else
            window.Logger.error('Could not send message, no channel set on connection')

    onConnection: ->
        window.Logger.trace('RTC.Connection.Connection->onConnection')
        this.channel = new DataChannel('test' , this.conn)

    onIceCandidate: ->
        window.Logger.trace('RTC.Connection.Connection->onIceCandidate')

    onOpen: ->
        window.Logger.trace('RTC.Connection.Connection->onOpen')

    onClose: ->
        window.Logger.trace('RTC.Connection.Connection->onClose')