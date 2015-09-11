# coffee-contract

coffee-contract make it easy to write contracts without using macros.

```coffee
C = require 'coffee-contract'
{ an } = require 'coffee-contract/matchers'

methodWithContract = C.args(an('number')).rtn(an('number')).wrap (num) -> num + 1

methodWithContract(2) # => 3
methodWithContract([]) # Error: expected [] to be a number

C.disable()
methodWithContract([]) # => '1'
```

# License
MIT
