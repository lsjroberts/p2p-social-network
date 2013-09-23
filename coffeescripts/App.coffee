local = new window.RTC.Peer.Local

remote = new window.RTC.Peer.Peer

if local.connect(remote)
    local.send("Hello")
else
    window.Logger.error("No way")