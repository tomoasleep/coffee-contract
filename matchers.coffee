inspect = require 'object-inspect'

class ContractError
  @fail: (message) ->
    throw new Error(message)

class Matchers
  kindof: (kind) -> (actual) ->
    if typeof kind is 'string'
      unless typeof actual is kind
        ContractError.fail "The type of #{inspect(actual)} is not #{inspect(kind)}."
    else
      unless actual instanceof kind
        ContractError.fail "The type of #{inspect(actual)} is not #{inspect(kind)}."

  a: @::kindof
  an: @::kindof

  key: (keys...) -> (actual) ->
    for key in keys
      unless actual[key]?
        ContractError.fail "#{inspect(actual)} does not has '#{inspect(key)}' key."

  keys: @::key

  equal: (expect) -> (actual) ->
    if expect isnt actual
      ContractError.fail "#{inspect(actual)} does not equal #{inspect(expect)}."

  has: (matcherDict) -> (actual) ->
    for key, value of matcherDict
      value(actual[key])

  all: (matchers) -> (actual) ->
    for v, i in actual
      matchers[i](v)

module.exports = do ->
  obj = {}
  matchers = new Matchers
  for key, value of matchers
    obj[key] = value
  obj
