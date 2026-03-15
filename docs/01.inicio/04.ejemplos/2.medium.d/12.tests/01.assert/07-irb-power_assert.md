
* `gem install irb-power_assert`, installation
* `irb -r irb-power_assert`, run irb with this gem
* Using `pa` with String
```
irb(main):001:0> pa %q{ "0".class == "3".to_i.times.map {|i| i + 1 }.class }
result: false

 "0".class == "3".to_i.times.map {|i| i + 1 }.class
     |     |      |    |     |                |
     |     |      |    |     |                Array
     |     |      |    |     [1, 2, 3]
     |     |      |    #<Enumerator: ...>
     |     |      3
     |     false
     String
=> nil
```

