contactsList = document.querySelector('[data-contacts-list]')

chatGroup = document.querySelector('[data-chat-group]')
chatRoomTitleGroup = document.querySelector('[data-chat-room-title-group]')
chatRoomGroup = document.querySelector('[data-chat-room-group]')
chatRoomTitleStub = document.querySelector('[data-chat-room-title-stub]')
chatRoomStub = document.querySelector('[data-chat-room-stub]')


# Create the user and display their peer id
user = new Social.User({key: 'xfptwovfgvi'})
user.peer.on('open', ->
    document.querySelector('[data-peer-id]').innerHTML = user.peerID
    shareLink = document.querySelector('[data-peer-id-share]')
    shareLink.href = shareLink.href.replace('peerID', user.peerID)
)


# Request the local video stream when the element is clicked
localVideo = document.querySelector('[data-local-video]')
if localVideo?
    localVideo.onclick = ->
        user.setVideo(new Social.Video(
            document.querySelector('video[data-stream="local"]')
        ))


# Manually connect with a remote user
document.querySelector('[data-connect]').onclick = ->
    connectID = document.querySelector('[data-connect-id]').value
    user.connect(connectID, {
        reliable: false,

        onOpen: (connection) ->
            appendContact(connection)
        ,
        onData: (data) ->

    })


# Append a contact to the list
appendContact = (connection) ->
    contact = document.querySelector('[data-contact-stub]').cloneNode(true)
    contact.className = 'contact'
    contact.innerHTML = contact.innerHTML.replace(/__peer__/g, connection.peer)
    contactsList.appendChild(contact)

    # contactsList.lastChild.querySelector('[data-chat-user]').onclick = ->
    #     openChat(this.getAttribute('data-chat-user'))

    contactsList.lastChild.querySelector('[data-call-user]').onclick = ->
        openCall(this.getAttribute('data-call-user'))


# Open chat with a connected user
openChat = (connectID) ->
    connection = user.getConnection(connectID)

    title = chatRoomTitleStub.cloneNode(true)
    title.className = title.className.replace('hide', '')
    title.innerHTML = title.innerHTML.replace(/__peer__/g, connection.peer)
    chatRoomTitleGroup.appendChild(title)

    room = chatRoomStub.cloneNode(true)
    room.className = room.className.replace('hide', '')
    room.innerHTML = room.innerHTML.replace(/__peer__/g, connection.peer)
    chatRoomGroup.appendChild(room)


# Video call a connected user
openCall = (connectID) ->
    user.call(connectID, document.querySelector('[data-video-group]'))






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