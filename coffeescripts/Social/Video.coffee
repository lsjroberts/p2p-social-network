window.Social or= {}

class window.Social.Video
    constructor: (element) ->
        self = this

        this.video = element

        this.stream = new RTC.VideoStream(->
            self.video.src = self.stream.getSource()
            self.video.play()
        )

        self.video.addEventListener('loadedmetadata', (->
            self.resize()
        ), false)

    resize: ->
        video = this.video
        videoRatio = video.videoWidth / video.videoHeight

        if videoRatio >= 1
            video.style.width = (video.offsetWidth * videoRatio) + 'px'
            video.style.left = ((video.parentNode.offsetWidth - video.offsetWidth) / 2) + 'px'
        else
            video.style.height = (video.offsetHeight * videoRatio) + 'px'
            video.style.top = ((video.parentNode.offsetHeight - video.offsetHeight) / 2) + 'px'
