require 'redis'

REDIS = Redis.new(url: "redis://localhost:6379/0", timeout: 1)