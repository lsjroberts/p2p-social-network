log = {
    trace: function(text) {
        console.log((performance.now() / 1000).toFixed(3) + ": " + text);
    },
    error: function(text) {
        console.error((performance.now() / 1000).toFixed(3) + ": " + text);
    }
}

p2p = {
    createLocalConnection: function() {
        var servers, localPeerConnection;

        localPeerConnection = new RTCPeerConnection(servers, {
            optional: [{RtpDataChannels: true}]
        });
        log.trace('Created local peer connection');

        try {
            sendChannel = localPeerConnection.createDataChannel('sendDataChannel', {
                reliable: false
            });
            log.trace('Created send data channel');
        }
        catch (e) {
            log.error('Failed to create data channel with exception: ' + e.message);
        }
    },

    createRemoteConnection: function() {
        var servers, remotePeerConnection;

        remotePeerConnection = new p2p.connection;
        p2p.connection.connect(new RTCPeerConnection(servers, {
            optional: [{RtpDataChannels: true}]
        }));
        log.trace('Created remote peer connection');


    },

    connection: {
        rtcpc: null,

        connect: function(rtcpc) {
            
        }

        onIceCandidate: function() {

        },

        onOpen: function(event) {

        },

        onClose: function(event) {

        }
    }
}