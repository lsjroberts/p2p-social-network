window.RTC or= {}

window.AudioContext or= window.webkitAudioContext
navigator.getUserMedia or= navigator.webkitGetUserMedia;

class window.RTC.MediaStream
    constructor: (@successCallback = null, @constraints = {}) ->
        Logger.trace('RTC.MediaStream->constructor')
        Logger.log(constraints)

        self = this
        navigator.getUserMedia(
            constraints,
            (stream) -> self.gotStream(stream),
            (error) -> self.failedStream(error)
        )

    gotStream: (@stream) ->
        Logger.trace('RTC.MediaStream->gotStream')

        this.context = new window.AudioContext
        this.source = this.context.createMediaStreamSource(stream)

        this.source.connect(this.context.destination)

        this.successCallback()

    getStream: ->
        this.stream

    getSource: ->
        if window.URL
            return window.URL.createObjectURL(this.stream)

        return this.stream

    failedStream: (error) ->
        Logger.error('RTC.MediaStream failed to get stream')


class window.RTC.AudioStream extends window.RTC.MediaStream
    constructor: (successCallback, constraints = {}) ->
        constraints.audio or= true
        super successCallback, constraints


class window.RTC.VideoStream extends window.RTC.MediaStream
    constructor: (successCallback, constraints = {}) ->
        constraints.video or= true
        super successCallback, constraints


class window.RTC.AudioVideoStream extends window.RTC.MediaStream
    constructor: (successCallback, constraints = {}) ->
        constraints.video or= true
        constraints.audio or= true
        super successCallback, constraints