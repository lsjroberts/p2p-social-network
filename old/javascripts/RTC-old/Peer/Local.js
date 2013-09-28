// Generated by CoffeeScript 1.6.3
(function() {
  var _base,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.RTC || (window.RTC = {});

  (_base = window.RTC).Peer || (_base.Peer = {});

  window.RTC.Peer.Local = (function(_super) {
    __extends(Local, _super);

    function Local(name) {
      Local.__super__.constructor.call(this, name);
      this.connections = [];
    }

    Local.prototype.connect = function(remote, success, failure) {
      if (success == null) {
        success = null;
      }
      if (failure == null) {
        failure = null;
      }
      return this.connections.push(remote.connect(this, success, failure));
    };

    Local.prototype.send = function(message) {
      var connection, _i, _len, _ref, _results;
      Logger.trace('RTC.Peer.Local->send');
      Logger.log(message);
      _ref = this.connections;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        connection = _ref[_i];
        _results.push(connection.send(message));
      }
      return _results;
    };

    return Local;

  })(window.RTC.Peer.Peer);

}).call(this);