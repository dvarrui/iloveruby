#!/usr/bin/env ruby
require "dry/logger"

logger = Dry.Logger(:test1)
logger.info "Hello World"

logger = Dry.Logger(:test2, template: :details)
logger.info "Hello World"
# [test] [INFO] [2022-11-17 11:43:52 +0100] Hello World

# logger = Dry.Logger(:test3, template: :crash, key_entry: "log_entry")
# logger.info "Hello World"

# logger = Dry.Logger(:test4, template: :rack)
# logger.info "Hello World"
