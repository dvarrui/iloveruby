
# Curses problem (Jan 2022)


**shugo:** Which version of underlying curses library do you use?

`$ ruby -r curses -e 'p Curses::VERSION'`

I guess the underlying library doesn't support colors().
Could you install ncurses (and a development package like ncurses-dev) before installing curses.gem?

**dvarrui**:

```
$ gem uninstall curses
$ sudo zypper install ncurses ncurses-devel
```

```
$ gem install curses

Fetching curses-1.4.3.gem
Building native extensions. This could take a while...
Successfully installed curses-1.4.3
Parsing documentation for curses-1.4.3
Installing ri documentation for curses-1.4.3
Done installing documentation for curses after 0 seconds
1 gem installed
```

```
$ ruby -r curses -e 'p Curses::VERSION'
"ncurses 6.1.20180317"
```

```
$ ./colors.rb
./colors.rb:14:in `colors': colors() function is unimplemented on this machine (NotImplementedError)
	from ./colors.rb:14:in `<main>'
```
