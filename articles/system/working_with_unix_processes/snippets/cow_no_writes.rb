arr = [1,2,3]

fork do
  # At this point the child process has been initialized.
  # Using CoW this process doesn't need to copy the arr variable, 
  # since it hasn't modified any shared values it can continue reading 
  # from the same memory location as the parent process.
  p arr
end

