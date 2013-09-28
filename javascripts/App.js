// Generated by CoffeeScript 1.6.3
(function() {
  var user;

  user = new Social.User({
    key: 'xfptwovfgvi'
  });

  user.setVideo(new Social.Video(document.querySelector('video[data-stream="local"]')));

  document.querySelector('#peerID').innerHTML = user.peerID;

  document.querySelector('#connect').onclick = (function() {
    var connectID;
    connectID = document.querySelector('#connectID').value;
    return user.call(connectID, document.querySelector('.video-group .remote'));
  });

}).call(this);
