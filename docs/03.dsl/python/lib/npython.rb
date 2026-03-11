
require_relative "import"
require_relative "booleans"
require_relative "copyright"
require_relative "credits"
require_relative "none"
require_relative "hashes"
require_relative "license"
require_relative "ranges"
require_relative "strings"
require_relative "type"
require_relative "version"

def print(*args)
  if args.is_a? Array
    puts args.join(" ")
  else
    puts(args)
  end
end

