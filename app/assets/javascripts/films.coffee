change = ->
    for player in document.getElementsByClassName 'video-js'
        video = videojs('video_player')
        console.log("Change, assigning video")

before_load = ->
    for player in document.getElementsByClassName 'video-js'
        video = videojs('video_player')
        video.dispose()
        console.log("before_load, disposing of video")

$(document).on('turbolinks:load', change)
$(document).on('turbolinks:before-visit', before_load)
