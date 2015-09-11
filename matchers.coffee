expect = require 'expect.js'

matchernize = (name) ->
  (matcherArgs...) ->
    (actual) ->
      expect(actual).to[name](matcherArgs...)

module.exports =
  has: (matcherDict) -> (actual) ->
    for key, value of matcherDict
      value(actual[key])

  all: (matchers) -> (actual) ->
    for v, i in actual
      matchers[i](v)

names = ['a', 'an', 'contain', 'key', 'keys', 'within', 'above', 'below', 'equal', 'match']
for name in names
  module.exports[name] = matchernize(name)
