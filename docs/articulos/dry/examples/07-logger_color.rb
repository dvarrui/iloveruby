#!/usr/bin/env ruby
require "dry/logger"

logger = Dry.Logger(:test, template: "[%<severity>s] <blue>%<verb>s</blue> <green>%<path>s</green>")

# This is now colorized, you gotta trust us
logger.info verb: "GET", path: "/users"
# [INFO] GET /users

