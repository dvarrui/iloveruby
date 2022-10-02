# Kernel#at_exit blocks are invoked when using Kernel#abort.
at_exit { puts 'Last!' }
abort "Something went horribly wrong."

