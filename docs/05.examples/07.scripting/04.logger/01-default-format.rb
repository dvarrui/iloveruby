#!/usr/bin/env ruby
require 'logger'

logger = Logger.new(STDOUT)

logger.debug("Apuntamos los fallos!")
logger.info("Executando el logger...")
logger.warn("El level es #{logger.level}")
