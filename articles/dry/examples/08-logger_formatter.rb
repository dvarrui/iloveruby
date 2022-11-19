#!/usr/bin/env ruby
require "dry/logger"

logger = Dry.Logger(:formatter1test)
logger.info verb: "GET", path: "/users", elapsed: "12ms", ip: "127.0.0.1", status: 200, length: 312, params: {}

logger = Dry.Logger(:formatter2, formatter: :string)
logger.info verb: "GET", path: "/users", elapsed: "12ms", ip: "127.0.0.1", status: 200, length: 312, params: {}

logger = Dry.Logger(:formatter3, formatter: :json)
logger.info verb: "GET", path: "/users", elapsed: "12ms", ip: "127.0.0.1", status: 200, length: 312, params: {}

logger = Dry.Logger(:formatter4, formatter: :rack)
logger.info verb: "GET", path: "/users", elapsed: "12ms", ip: "127.0.0.1", status: 200, length: 312, params: {}
# [test] [INFO] [2022-11-17 12:04:30 +0100] GET 200 12ms 127.0.0.1 /users 312
