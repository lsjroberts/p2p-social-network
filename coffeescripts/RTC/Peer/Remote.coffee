window.RTC or= {}
window.RTC.Peer or= {}

class window.RTC.Peer.Remote extends window.RTC.Peer.Peer
    connect: (local) ->
        Logger.trace('RTC.Peer.Remote->connect')

        self = this

        this.localConnection  = new RTC.Connection.Local(local.name)
        this.remoteConnection = new RTC.Connection.Remote(this.name)
        this.localConnection.createOffer (desc) -> self.gotLocalDescription(desc)

    gotLocalDescription: (desc) ->
        Logger.trace('RTC.Peer.Remote->gotLocalDescription')
        Logger.log(desc.sdp)

        self = this

        this.localConnection.setLocalDescription(desc)
        this.remoteConnection.setRemoteDescription(desc)
        this.remoteConnection.createAnswer (answer) -> self.gotRemoteDescription(answer)

    gotRemoteDescription: (desc) ->
        Logger.trace('RTC.Peer.Remote->gotRemoteDescription')
        Logger.log(desc.sdp)

        this.remoteConnection.setLocalDescription(desc)
        this.localConnection.setRemoteDescription(desc)