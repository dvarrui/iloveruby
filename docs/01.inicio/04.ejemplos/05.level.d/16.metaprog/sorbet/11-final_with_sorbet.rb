#!/usr/bin/env ruby
# https://sorbet.org/docs/final

require 'sorbet-runtime'

# (1) Call this once per project, ideally right after `require 'sorbet-runtime'`
T::Configuration.enable_final_checks_on_hooks

module HasFinalMethod
  extend T::Sig

  # (2) The special `sig(:final)` syntax declares this method final:
  sig(:final) {void}
  def foo; end
end

begin
  module HasFinalMethod
    def foo
      puts "redefined"
    end
  end
rescue => e
  puts "[INFO] foo method is final!: #{e}"
end

