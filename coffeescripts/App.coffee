user = new Social.User({key: 'xfptwovfgvi'})

user.setVideo(new Social.Video(
    document.querySelector('video[data-stream="local"]')
))

document.querySelector('#peerID').innerHTML = user.peerID


# simulate multiple connections
# container = document.querySelector('#remote-video-group')
# for i in [0..3]
#     setTimeout ->
#         remote = document.createElement('div')
#         remote.className = 'video-container remote hide'
#         video = document.createElement('video')
#         remote.appendChild(video)
#         remote.style.left = (Math.floor(Math.random() * (container.clientWidth - 200))) + 'px'
#         remote.style.top = Math.floor(Math.random() * (container.clientHeight - 200)) + 'px'
#         container.appendChild(remote)
#         setTimeout ->
#             remote.className = 'video-container remote'
#         , 1
#     , i * 1000

document.querySelector('#connect').onclick = (->
    connectID = document.querySelector('#connectID').value
    # user.call(connectID, document.querySelector('.video-group .remote'))
)