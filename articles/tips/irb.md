
# irb measure

> (Kirill Shevchenko @kirill_shevch) https://twitter.com/kirill_shevch/status/1590021218157006848?t=r8CXdeobRo8lnq5EB4hb_Q&s=35

IRB tiene la palabra clave `measure` incorporada para la evaluación comparativa. Además, admite la integración con `stackprof`.

![](https://pbs.twimg.com/media/FhDjuTfWAAAhiaW?format=jpg&name=small)

```ruby
irb> measure
TIME is added.
=> nil                         
irb> (0..9999).each { "iterate" }
processing time: 0.003317s
=> 0..9999                                                                     
irb> (0..99999).each { "iterate" }
processing time: 0.033485s
=> 0..99999
```

```ruby                               
irb> measure :stackprof
STACKPROF is added.
processing time: 0.001214s                                                     
=> nil                                                                         
irb> (0..99999).each { "iterate" }
Please run "gem install stackprof" before measuring by StackProf.
processing time: 0.010604s                                                     
=> 0..99999                                                                    
```
