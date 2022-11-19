#!/usr/bin/env ruby

require "dry/logger"

logger = Dry.Logger(:test, template: :details).add_backend(stream: "logs/test.log")

# This goes to $stdout and logs/test.log too
logger.info "Hello World"
# [test] [INFO] [2022-11-17 11:46:12 +0100] Hello World

