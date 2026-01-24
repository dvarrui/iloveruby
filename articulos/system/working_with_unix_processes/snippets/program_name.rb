puts $PROGRAM_NAME

10.downto(1) do |num|
  $PROGRAM_NAME = "Process: #{num}"
  puts $PROGRAM_NAME
end

