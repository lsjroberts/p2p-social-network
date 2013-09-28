localVideo = document.querySelector('#local')
remoteVideo = document.querySelector('#remote')

connection = new RTC.PeerConnection

videoStream = new RTC.VideoStream(->
    localVideo.src = videoStream.getSource()
    localVideo.play()

    connection.addStream(videoStream)
)