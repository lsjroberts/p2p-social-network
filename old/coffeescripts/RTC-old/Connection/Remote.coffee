window.RTC or= {}
window.RTC.Connection or= {}

class window.RTC.Connection.Remote extends window.RTC.Connection.Connection
    createAnswer: (answer) ->
        this.conn.createAnswer(answer)