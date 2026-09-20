#!/usr/bin/env ruby
require "tty-logger"

logger = TTY::Logger.new do |config|
  config.level = :info
  config.metadata = [:date, :time]
  config.handlers = [
    [:console, output: $stdout, level: :debug],
    [:stream, output: File.open("errors.log", "a"), level: :error]
  ]
end

logger.debug "mensaje 1"
logger.info "mensaje 2"
logger.warn "mensaje 3"
logger.error "mensaje 4"

logger.success "Done!"
