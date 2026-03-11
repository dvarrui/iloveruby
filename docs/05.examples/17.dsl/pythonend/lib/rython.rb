
require_relative "import"
require_relative "booleans"
require_relative "none"
require_relative "hashes"
require_relative "ranges"
require_relative "strings"
require_relative "type"

def print(*args)
  if args.is_a? Array
    puts args.join(" ")
  else
    puts(args)
  end
end
