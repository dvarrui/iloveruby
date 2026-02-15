# When Kernel#exit is invoked, before exiting Ruby invokes any blocks
# defined by Kernel#at_exit.
at_exit { puts 'Last!' }
exit

