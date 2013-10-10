// Generated by CoffeeScript 1.6.3
(function() {
  var appendContact, chatGroup, chatRoomGroup, chatRoomStub, chatRoomTitleGroup, chatRoomTitleStub, contactsList, localVideo, openCall, openChat, user;

  contactsList = document.querySelector('[data-contacts-list]');

  chatGroup = document.querySelector('[data-chat-group]');

  chatRoomTitleGroup = document.querySelector('[data-chat-room-title-group]');

  chatRoomGroup = document.querySelector('[data-chat-room-group]');

  chatRoomTitleStub = document.querySelector('[data-chat-room-title-stub]');

  chatRoomStub = document.querySelector('[data-chat-room-stub]');

  user = new Social.User({
    key: 'xfptwovfgvi'
  });

  user.peer.on('open', function() {
    var shareLink;
    document.querySelector('[data-peer-id]').innerHTML = user.peerID;
    shareLink = document.querySelector('[data-peer-id-share]');
    if (shareLink != null) {
      return shareLink.href = shareLink.href.replace('peerID', user.peerID);
    }
  });

  localVideo = document.querySelector('[data-local-video]');

  if (localVideo != null) {
    localVideo.onclick = function() {
      return user.setVideo(new Social.Video(document.querySelector('video[data-stream="local"]')));
    };
  }

  document.querySelector('[data-connect]').onclick = function() {
    var connectID;
    connectID = document.querySelector('[data-connect-id]').value;
    return user.connect(connectID, {
      reliable: false,
      onOpen: function(connection) {
        return appendContact(connection);
      },
      onData: function(data) {}
    });
  };

  appendContact = function(connection) {
    var contact;
    contact = document.querySelector('[data-contact-stub]').cloneNode(true);
    contact.className = 'contact';
    contact.innerHTML = contact.innerHTML.replace(/__peer__/g, connection.peer);
    contactsList.appendChild(contact);
    return contactsList.lastChild.querySelector('[data-call-user]').onclick = function() {
      return openCall(this.getAttribute('data-call-user'));
    };
  };

  openChat = function(connectID) {
    var connection, room, title;
    connection = user.getConnection(connectID);
    title = chatRoomTitleStub.cloneNode(true);
    title.className = title.className.replace('hide', '');
    title.innerHTML = title.innerHTML.replace(/__peer__/g, connection.peer);
    chatRoomTitleGroup.appendChild(title);
    room = chatRoomStub.cloneNode(true);
    room.className = room.className.replace('hide', '');
    room.innerHTML = room.innerHTML.replace(/__peer__/g, connection.peer);
    return chatRoomGroup.appendChild(room);
  };

  openCall = function(connectID) {
    return user.call(connectID, document.querySelector('[data-video-group]'));
  };

}).call(this);
