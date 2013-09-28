class Log
    log: (thing) ->
        console.log(thing);

    trace: (text) ->
        console.log((performance.now() / 1000).toFixed(3) + ": " + text);

    error: (text) ->
        console.error((performance.now() / 1000).toFixed(3) + ": " + text);


class Peer
    constructor: (@name, @peers=[]) ->

class Local extends Peer
    connect: (remote) ->
        remote.connectToLocal(this)
        this.peers.push(remote)

    send: (message) ->
        this.connection.send(message)

class Remote extends Peer
    connectToLocal: (local) ->
        this.localConnection = new LocalConnection(local.name, local.name + 'SendDataChannel')
        this.remoteConnection = new RemoteConnection(name)
        this.localConnection.createOffer(this.gotLocalDescription)

    gotLocalDescription: (desc) ->
        logger.trace('Offer from local connection: \n' + desc.sdp)
        this.localConnection.setLocalDescription(desc)
        this.remoteConnection.setRemoteDescription(desc)
        this.remoteConnection.setAnswer(this.gotRemoteDescription)

    gotRemoteDescription: (desc) ->
        logger.trace('Answer from remote connection: \n' + desc.sdp)
        this.remoteConnection.setLocalDescription(desc)
        this.localConnection.setRemoteDescription(desc)


class Connection
    constructor: (@name, @channelName) ->
        servers = null;
        this.rtcpc = new RTCPeerConnection(servers, {
            optional: [{RtpDataChannels: true}]
        });
        this.rtcpc.onconnection = this.onConnection
        this.rtcpc.onicecandidate = this.onIceCandidate
        this.rtcpc.onopen = this.onOpen
        this.rtcpc.onClose = this.onClose

    send: (message) ->
        if (this.channel not null)
            this.channel.send(message)
        else
            logger.error('Could not send message, no channel set on connection.')

    setLocalDescription: (desc) ->
        this.rtcpc.setLocalDescription(desc)

    setRemoteDescription: (desc) ->
        this.rtcpc.setRemoteDescription(desc)

    onConnection: ->
        logger.trace('Connection.onConnection')
        this.channel = new DataChannel(this.channelName, this.rtcpc)

    onIceCandidate: (event) ->
        logger.trace('Connection.onIceCandidate')

    onMessage: (event) ->
        logger.trace('Connection.onMessage')
        logger.log(event)

    onOpen: ->
        logger.trace('Connection.onOpen')

    onClose: ->
        logger.trace('Connection.onClose')


class LocalConnection extends Connection
    onOpen: ->
        super
        this.send("Hello Remote!")

    createOffer: (offer) ->
        this.rtcpc.createOffer(offer)


class RemoteConnection extends Connection
    onOpen: ->
        super
        this.send("Hello Local!")

class Channel
    constructor: (@name) ->

class DataChannel extends Channel
    constructor: (@name, @connection) ->
        super @name
        try
            this.channel = this.connection.createDataChannel(this.name, {
                reliable: false
            });

        catch error
            logger.error('Failed to create data connection with exception: ' + error)


class Collection
    constructor: (@items=[]) ->

    add: (key, value) ->
        this.items[key] = value

    remove: (key) ->
        this.items[key] = null


logger = new Log;
connections = new Collection
local = new Local('Local');

local.connect(new Remote('remote1'))