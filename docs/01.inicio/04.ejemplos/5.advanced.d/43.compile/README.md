
# README abou compile ruby

* [AppSignal Blog](https://t.co/5NPeRR2viY?s=35) How to Parse Arguments in Your Ruby C Extension | Let's explore two ways to set up a complex Ruby API written in C.
* [Ruby Inside](https://twitter.com/RubyInside/status/1482093670287425541?t=EM9fbDTKn7tL4Q5__h_dfg&s=09) RubyConf 2021: A History of Compiling Ruby - youtube.com/watch?v=Zg-1_7… #video

## traveling-ruby

## ruby-packer:

## mruby

I've used mruby to compile a few small, simple utilities (custom Nagios
plugins):

https://github.com/hone/mruby-cli

## Java

For systems with Java, I have packaged some utilities as jar files:

https://github.com/jruby/warbler#label-.war+or+.jar-3F

I've never used it, but Glimmer has a packaging option that uses warbler
and jpackage to create DMG/PKG, MSI/EXE, and/or DEB/RPM packages (again
depending on a Java runtime on the target):

https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_PACKAGING_AND_DISTRIBUTION.md


If the system has Java, I agree that JRuby is a good option (assuming
you don't use native gems). I wrote a post here on how to package Ruby
scripts into JAR files at this page:
https://notepad.onghu.com/2021/jruby-win-day2-creating-jar-files/

It's part of my series of posts on JRuby all of which are linked from
the write-up on Why JRuby here:
https://notepad.onghu.com/2022/why-we-use-jruby/

Best Regards,

## Glimmer DSL SWT

https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_PACKAGING_AND_DISTRIBUTION.md

## Natalie

A unique Ruby implementation, compiled to C++ (WIP): https://github.com/natalie-lang/natalie

```
$ cat examples/hello.rb
puts 'hello world'

$ bin/natalie examples/hello.rb -c hello
$ ./hello
hello world
```

```
$ ls -lh hello
-rwxr-xr-x 1 user user 19M Nov  1 15:01 hello
$ file hello
hello: ELF 64-bit LSB pie executable, x86-64, version 1 (GNU/Linux),
dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2,
BuildID[sha1]=c298736e605dcebaf676bb363fad3f092e93c9ea, for GNU/Linux
3.2.0, with debug_info, not stripped
$ ldd hello
	linux-vdso.so.1 (0x00007fff78dc1000)
	libstdc++.so.6 => /lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007a1aee57e000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007a1aee43a000)
	libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007a1aee420000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007a1aee3fe000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007a1aee239000)
	/lib64/ld-linux-x86-64.so.2 (0x00007a1aeeaa7000)
```
