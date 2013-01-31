require 'date'
require 'erb'
require 'redis'

require_relative "gittop/git_repo"
require_relative "gittop/js_generator"
require_relative "gittop/redis_populator"

@repo = GitRepo.new("/Users/yankov/ruby/badgeville")

leaderboards = { :all_time => @repo.leaderboard(:all_time),
                 :monthly  => @repo.leaderboard(:monthly),
                 :weekly   => @repo.leaderboard(:weekly),
                 :daily    => @repo.leaderboard(:daily) }

# save data to js file
JSGenerator.save(leaderboards)

# save data to redis
redis = RedisPopulator.new(host: 'localhost', port: 6379 )
redis.save(leaderboards)
