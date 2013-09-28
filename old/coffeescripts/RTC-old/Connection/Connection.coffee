window.RTC or= {}
window.RTC.Connection or= {}

###
Handles a standard connection between two peers used to send data in one
direction from the local to the remote peer.
@author Laurence Roberts <lsjroberts@outlook.com>
###
class window.RTC.Connection.Connection

    ###
    Constructor.
    @param string name
    @param string channelName
    ###
    constructor: (@name, @channelName = name + 'SendDataChannel') ->
        servers = null

        this.conn = new RTCPeerConnection(servers, {
            optional: [{RtpDataChannels: true}]
        })

        this.conn.onconnection   = this.onConnection
        this.conn.onicecandidate = this.onIceCandidate
        this.conn.ondatachannel  = this.onDataChannel
        this.conn.onopen         = this.onOpen
        this.conn.onclose        = this.onClose

        this.channel = this.conn.createDataChannel(channelName, {reliable: false})

    ###
    Set the local description.
    @param [type] desc
    ###
    setLocalDescription: (desc) ->
        this.conn.setLocalDescription(desc)

    ###
    Set the remote description.
    @param [type] desc
    ###
    setRemoteDescription: (desc) ->
        this.conn.setRemoteDescription(desc)

    ###
    Create an offer to attempt to connect the local description to the remote
    description.
    @param [type] offer
    ###
    createOffer: (offer) ->
        this.conn.createOffer(offer)

    ###
    Send a message to the remote peer.
    @param mixed message
    ###
    send: (message) ->
        Logger.trace('RTC.Connection.Connection->send')
        if this.channel
            this.channel.send(message)
        else
            Logger.error('Could not send message, no channel set on connection')

    ###
    Connection listener.
    ###
    onConnection: ->
        Logger.trace('RTC.Connection.Connection->onConnection')
        # this.channel = new DataChannel(this.channelName , this.conn)

    ###
    Interactive Connectivity Establishment (ICE) Candidate listener.
    ###
    onIceCandidate: ->
        Logger.trace('RTC.Connection.Connection->onIceCandidate')

    onDataChannel: (event) ->
        Logger.trace('RTC.Connection.Connection->onDataChannel')

    ###
    Connection open listener.
    ###
    onOpen: ->
        Logger.trace('RTC.Connection.Connection->onOpen')

    ###
    Connection close listener.
    ###
    onClose: ->
        Logger.trace('RTC.Connection.Connection->onClose')