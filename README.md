# coffee-contract

coffee-contract makes it easy to write [contracts](https://en.wikipedia.org/wiki/Design_by_contract) without using macros.
This library provides function wrappers to check their preconditions and postconditions.

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
