window.RTC or= {}
window.RTC.Peer or= {}

class window.RTC.Peer.Remote extends window.RTC.Peer.Peer
    connect: (local, success = null, failure = null) ->
        Logger.trace('RTC.Peer.Remote->connect')

        self = this

        this.localConnection  = new RTC.Connection.Local(local.name)
        this.remoteConnection = new RTC.Connection.Remote(this.name)
        this.localConnection.createOffer (desc) ->
            self.gotLocalDescription(desc, success, failure)

        return this

    gotLocalDescription: (desc, success = null, failure = null) ->
        Logger.trace('RTC.Peer.Remote->gotLocalDescription')
        Logger.log(desc.sdp)

        self = this

        this.localConnection.setLocalDescription(desc)
        this.remoteConnection.setRemoteDescription(desc)
        this.remoteConnection.createAnswer (answer) ->
            self.gotRemoteDescription(answer, success, failure)

    gotRemoteDescription: (desc, success = null, failure = null) ->
        Logger.trace('RTC.Peer.Remote->gotRemoteDescription')
        Logger.log(desc.sdp)

        this.remoteConnection.setLocalDescription(desc)
        this.localConnection.setRemoteDescription(desc)

        success()

    send: (message) ->
        Logger.trace('RTC.Peer.Remote->send')
        Logger.log(message)

        this.remoteConnection.send(message)