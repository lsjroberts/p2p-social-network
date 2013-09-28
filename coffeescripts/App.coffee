peerID = Math.random().toString(36).substr(2, 10)
document.querySelector('#peerID').innerHTML = peerID

localVideo = document.querySelector('#localVideo')
remoteVideo = document.querySelector('#remoteVideo')

videoStream = new RTC.VideoStream(->
    localVideo.src = videoStream.getSource()
    localVideo.play()
)

peer = new Peer(peerID, {
    key: 'xfptwovfgvi',
    debug: 3
})

peer.on('open', (id) ->
    Logger.trace('peer.on.open')
    Logger.log(id)
)

peer.on('connection', (conn) ->
    Logger.trace('peer.on.connection')
    Logger.log(conn)
)

peer.on('call', (call) ->
    Logger.trace('peer.on.call')
    Logger.log(call)

    call.answer(videoStream.getStream())
)

peer.on('error', (err) ->
    Logger.error(err.message)
)

document.querySelector('#connect').onclick = (->
    connectID = document.querySelector('#connectID').value
    call = peer.call(connectID, videoStream.getStream())

    Logger.log(call)

    call.on('stream', (stream) ->
        Logger.trace('call.on.stream')
        Logger.log(stream)
        remoteVideo.src = URL.createObjectURL(stream)
        remoteVideo.play()
    )
)