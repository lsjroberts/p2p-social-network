localVideo = document.querySelector('video[data-stream="local"]')
remoteVideo = document.querySelector('video[data-stream="remote"]')

localVideo.addEventListener('loadedmetadata', (->
    # resizeVideo(this)
    drawVideoToCanvas(this)
), false)
remoteVideo.addEventListener('loadedmetadata', (->
    # resizeVideo(this)
    drawVideoToCanvas(this)
), false)

resizeVideo = ((video) ->
    videoRatio = video.videoWidth / video.videoHeight

    if videoRatio >= 1
        video.style.width = (video.offsetWidth * videoRatio) + 'px'
        video.style.left = ((video.parentNode.offsetWidth - video.offsetWidth) / 2) + 'px'
    else
        video.style.height = (video.offsetHeight * videoRatio) + 'px'
        video.style.top = ((video.parentNode.offsetHeight - video.offsetHeight) / 2) + 'px'
)

drawVideoToCanvas = ((video) ->
    requestAnimationFrame(-> drawVideoToCanvas(video));
    source = video.nextSibling.nextSibling.getContext('2d')
    source.drawImage(video, 0, 0, video.videoWidth, video.videoHeight, 0, 0, source.canvas.width, source.canvas.height)
)

videoStream = new RTC.VideoStream(->
    localVideo.src = videoStream.getSource()
    localVideo.play()
)

user = new Social.User({key: 'xfptwovfgvi'})

document.querySelector('#peerID').innerHTML = user.peerID

user.peer.on('open', (id) ->
    Logger.trace('peer.on.open')
    Logger.log(id)
)

user.peer.on('connection', (conn) ->
    Logger.trace('peer.on.connection')
    Logger.log(conn)
)

user.peer.on('call', (call) ->
    Logger.trace('peer.on.call')
    Logger.log(call)

    call.answer(videoStream.getStream())
)

user.peer.on('error', (err) ->
    Logger.error(err.message)
)

document.querySelector('#connect').onclick = (->
    connectID = document.querySelector('#connectID').value
    call = user.peer.call(connectID, videoStream.getStream())

    call.on('stream', (stream) ->
        Logger.trace('call.on.stream')
        Logger.log(stream)
        remoteVideo.src = URL.createObjectURL(stream)
        remoteVideo.play()
    )
)