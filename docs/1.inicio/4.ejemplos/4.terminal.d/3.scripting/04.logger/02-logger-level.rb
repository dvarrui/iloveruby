#!/usr/bin/env ruby
require 'logger'

logger = Logger.new(STDOUT)
logger.level = Logger::INFO

logger.debug("demo2") { "Apuntamos los fallos!" }
logger.info("demo2") { "Ejecutando el logger..." }
logger.warn("demo2") { "El level es #{logger.level}" }
