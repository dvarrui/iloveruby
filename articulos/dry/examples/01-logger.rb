#!/usr/bin/env ruby
require "dry/logger"

logger = Dry.Logger(:my_app)

logger.info "Hello World"
# Hello World
