local = new window.RTC.Peer.Local 'foo'

remote = new window.RTC.Peer.Remote 'bar'

###
if local.connect(remote)
    local.send("Hello")
else
    window.Logger.error("No way")
###

local.connect(remote)