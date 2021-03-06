// Generated by CoffeeScript 1.6.3
(function() {
  window.Social || (window.Social = {});

  window.Social.User = (function() {
    function User(options) {
      var self, storage, _ref;
      if (options == null) {
        options = {};
      }
      self = this;
      this.connections = {};
      storage = new Storage.Local('p2p');
      this.peerID = (_ref = storage.get('peerID')) != null ? _ref : this.generatePeerID();
      storage.put('peerID', this.peerID);
      this.peer = new Peer(this.peerID, options);
      this.peer.on('open', function(id) {
        Logger.trace('peer.on.open');
        return Logger.log('Connected as: ' + id);
      });
      this.peer.on('connection', function(conn) {
        Logger.trace('peer.on.connection');
        return Logger.log(conn);
      });
      this.peer.on('call', function(call) {
        Logger.trace('peer.on.call');
        Logger.log(call);
        return call.answer(self.video.stream.getStream());
      });
      this.peer.on('error', function(err) {
        return Logger.error(err.message);
      });
    }

    User.prototype.call = function(connectID) {
      var call, container;
      call = this.peer.call(connectID, this.video.stream.getStream());
      container = document.createElement('div');
      container.className = 'video-container';
      call.on('stream', function(stream) {
        var remoteVideo;
        Logger.trace('call.on.stream');
        Logger.log(stream);
        remoteVideo = document.createElement('video');
        remoteVideo.autoplay = true;
        remoteVideo.src = URL.createObjectURL(stream);
        remoteVideo.play();
        return container.appendChild(remoteVideo);
      });
      return container;
    };

    User.prototype.connect = function(connectID, options) {
      var connection, self;
      if (options == null) {
        options = {};
      }
      self = this;
      connection = this.peer.connect(connectID, options);
      connection.on('open', function() {
        Logger.trace('connection.on.open');
        self.addConnection(connection);
        if (options.onOpen != null) {
          return options.onOpen(connection);
        }
      });
      connection.on('data', function(data) {
        Logger.trace('connection.on.data');
        return Logger.log(data);
      });
      connection.on('close', function() {
        return Logger.trace('connection.on.close');
      });
      return connection.on('error', function() {
        return Logger.trace('connection.on.error');
      });
    };

    User.prototype.send = function(remote, message) {
      return this.peer.send(remote.peerID, message);
    };

    User.prototype.broadcast = function(message) {
      var remote, _i, _len, _ref, _results;
      _ref = this.connections;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        remote = _ref[_i];
        _results.push(this.send(remote, message));
      }
      return _results;
    };

    User.prototype.setVideo = function(video) {
      return this.video = video;
    };

    User.prototype.addConnection = function(connection) {
      return this.connections[connection.peer] = connection;
    };

    User.prototype.getConnection = function(peerID) {
      return this.connections[peerID];
    };

    User.prototype.generatePeerID = function() {
      return Math.random().toString(36).substr(2, 10);
    };

    return User;

  })();

}).call(this);
