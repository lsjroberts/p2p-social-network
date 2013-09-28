Peer-to-Peer Social Network
===========================

A peer-to-peer social network allows you to own your data. When you share your thoughts and photos with your network nothing is stored on a server, it is just pushed straight to your contacts.

By default everything is private and can only be seen by another person if you explicitly share the data with them.

WebRTC
------

Peer-to-peer communication is provided by WebRTC.

### Media Streams

Media streams handle audio and video data.

**Streams**

```coffee
RTC.MediaStream
RTC.AudioStream
RTC.VideoStream
RTC.AudioVideoStream
```

**Create a new media stream**

```coffee
# Select the video element.
video = document.querySelector('video')

# Create a new video stream.
videoStream = new RTC.VideoStream(->

    # Pass the stream source to the video element.
    video.src = videoStream.getSource()

    # Play the video, rendering the stream to the element.
    video.play()
)
```

The passed callback is run once the stream has been allowed by the user and is successfully retrieved.


### Peer Connections

A peer connection can be used to send a stream to a remote peer.

```coffee
localVideo = document.querySelector('#local')
remoteVideo = document.querySelector('#remote')

# Create the peer connection
connection = new RTC.PeerConnection(->

    videoStream = new RTC.VideoStream(->
        localVideo.src = videoStream.getSource()
        localVideo.play()

        # Add the local video stream to the connection, this will automatically share it
        # with the remote peer.
        connection.addStream(videoStream)
    )
)

# Attempt to fetch the remote stream from the peer.
connection.fetchStream((remoteStream) ->

    # Pass the remote stream source to the video element.
    remoteVideo.src = remoteStream.getSource()

    # Play the video, rendering the stream to the element.
    removeVideo.play()
)
```


### Data Channel

```coffee
connection = new RTC.PeerConnection(->

    connection.send("Hello World!")
    connection.sendJSON({foo: 'bar'})
)
```