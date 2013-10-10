class Logger
    levels: {
        none: 0,
        error: 1,
        log: 2,
        trace: 3
    }

    setLevel: (@level) ->

    trace: (text) ->
        if this.level >= this.levels.trace
            console.log((performance.now() / 1000).toFixed(3) + ": " + text);

    log: (thing) ->
        if this.level >= this.levels.log
            console.log(thing);

    error: (text) ->
        if this.level >= this.levels.error
            console.error((performance.now() / 1000).toFixed(3) + ": " + text);

window.Logger = new Logger
window.Logger.setLevel(window.Logger.levels.trace)