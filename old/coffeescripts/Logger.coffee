class Logger
    levels: {
        none: 0,
        error: 1,
        trace: 2,
        log: 3
    }

    setLevel: (@level) ->

    log: (thing) ->
        if this.level >= this.levels.log
            console.log(thing);

    trace: (text) ->
        if this.level >= this.levels.trace
            console.log((performance.now() / 1000).toFixed(3) + ": " + text);

    error: (text) ->
        if this.level >= this.levels.error
            console.error((performance.now() / 1000).toFixed(3) + ": " + text);

window.Logger = new Logger
window.Logger.setLevel(window.Logger.levels.log)