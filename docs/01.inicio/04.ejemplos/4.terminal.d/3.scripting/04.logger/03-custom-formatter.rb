#!/usr/bin/env ruby
require 'logger'

logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG
logger.datetime_format = '%Y-%m-%d %H:%M:%S'

logger.formatter = proc do |severity, datetime, progname, msg|
  "#{datetime} [#{severity.ljust(6)}] #{progname}: #{msg}\n"
end

progname = "demo3"
logger.debug(progname) { "Apuntamos los fallos!" }
logger.info(progname) { "Executando el logger..." }
logger.warn(progname) { "El level es #{logger.level}" }
