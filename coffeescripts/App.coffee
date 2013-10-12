###
Helpers
###

delay = (ms, fn) -> setTimeout fn, ms

animateOut = (el, fn) ->
    el.className = el.className + ' animated fadeOutUp'
    delay 500, ->
        el.className = el.className.replace(' animated fadeOutUp', ' hide')
        if fn?
            fn()

animateIn = (el, fn) ->
    el.className = (el.className + ' animated fadeInDown').replace('hide', '')
    delay 500, ->
        el.className = el.className.replace(' animated fadeInDown', '')
        if fn?
            fn()

###
Elements
###
contactsList = document.querySelector('[data-contacts-list]')

chatGroup = document.querySelector('[data-chat-group]')
chatRoomTitleGroup = document.querySelector('[data-chat-room-title-group]')
chatRoomGroup = document.querySelector('[data-chat-room-group]')
chatRoomTitleStub = document.querySelector('[data-chat-room-title-stub]')
chatRoomStub = document.querySelector('[data-chat-room-stub]')

saveNameButton = document.querySelector('[data-save-name]')
saveNameField  = document.querySelector('[data-name-field]')
nameLabel = document.querySelector('[data-name-label]')


###
Data
###

# Get a reference to the local storage
storage = new Storage.Local;


# Create the user and display their peer id
user = new Social.User({key: 'xfptwovfgvi'})
user.peer.on('open', ->
    document.querySelector('[data-peer-id]').innerHTML = user.peerID
    shareLink = document.querySelector('[data-peer-id-share]')
    if shareLink?
        shareLink.href = shareLink.href.replace('peerID', user.peerID)
)



###
Events
###

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


# Check if the user already has a name
if storage.has('name')
    nameLabel.innerHTML = nameLabel.innerHTML.replace(/__name__/g, storage.get('name'))
    animateOut(saveNameButton)
    animateOut(saveNameField, -> animateIn(nameLabel))

# Save the user's name
saveNameButton.onclick = ->
    name = saveNameField.value
    storage.put('name', name)
    animateOut(saveNameButton)
    animateOut(saveNameField, -> animateIn(nameLabel))


# Append a contact to the list
appendContact = (connection) ->
    contact = document.querySelector('[data-contact-stub]').cloneNode(true)
    contact.removeAttribute('data-contact-stub')
    contact.className = 'contact'
    contact.innerHTML = contact.innerHTML.replace(/__peer__/g, connection.peer)
    animateIn(contact)
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
    videoContainer = user.call(connectID)
    animateIn(videoContainer)
    document.querySelector('[data-video-group]').appendChild(videoContainer)






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
