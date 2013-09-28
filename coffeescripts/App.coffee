user = new Social.User({key: 'xfptwovfgvi'})

user.setVideo(new Social.Video(
    document.querySelector('video[data-stream="local"]')
))

document.querySelector('#peerID').innerHTML = user.peerID

document.querySelector('#connect').onclick = (->
    connectID = document.querySelector('#connectID').value
    user.call(connectID, document.querySelector('.video-group .remote'))
)