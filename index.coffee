{ all } = require './matchers'

class Contract
  constructor: (@parent, @beforeCheckers = [], @afterCheckers = []) ->

  disable: ->
    constructor.enabled = false

  enable: ->
    constructor.enabled = true

  isEnabled: ->
    constructor.enabled

  before: (checker) -> @_spawn([@beforeCheckers..., checker], @afterCheckers)
  after: (checker) -> @_spawn(@beforeCheckers, [@afterCheckers..., checker])

  args: (matchers...) -> @before((givenArgs) -> all(matchers)(givenArgs) )
  rtn: (matcher) -> @after((_args, rtn) -> matcher(rtn))

  wrap: (func) =>
    self = this
    (args...) ->
      if self.isEnabled()
        self._checkBefore(this, args)
        rtn = func.apply(this, args)
        self._checkAfter(this, args, rtn)
        rtn
      else
        func.apply(this, args)

  _spawn: (beforeCheckers, afterCheckers) ->
    new @constructor((@root ? this), beforeCheckers, afterCheckers)

  _checkBefore: (callee, args) ->
    for checker in @beforeCheckers
      throw new Error() if checker.call(callee, args) is false

  _checkAfter: (callee, args, rtn) ->
    for checker in @afterCheckers
      throw new Error() if checker.call(callee, args, rtn) is false

module.exports = new Contract
module.exports.enable()
