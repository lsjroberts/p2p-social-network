# connection = new RTC.Connection 'test'

localVideo = document.querySelector('#local')
remoteVideo = document.querySelector('#remote')

connection = new RTC.PeerConnection

videoStream = new RTC.VideoStream(->
    localVideo.src = videoStream.getSource()
    localVideo.play()

    connection.addStream(videoStream)
)

# local = new window.RTC.Peer.Local 'foo'

# remote = new window.RTC.Peer.Remote 'bar'

# local.connect(
#     remote,
#     ->
#         local.send("Hello")
#     ->
#         Logger.error("FAILED")
# )