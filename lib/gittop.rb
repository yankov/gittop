require 'date'
require 'erb'
require 'redis'
require 'optparse'

require_relative "gittop/git_repo"
require_relative "gittop/js_generator"
require_relative "gittop/redis_populator"
require_relative "gittop/cli"

options = CLI.parse_options(ARGV)

@repo = GitRepo.new(options[:repo_path])

leaderboards = { :all_time => @repo.leaderboard(:all_time),
                 :monthly  => @repo.leaderboard(:monthly),
                 :weekly   => @repo.leaderboard(:weekly),
                 :daily    => @repo.leaderboard(:daily) }


if options[:redis]
  redis = RedisPopulator.new(host: 'localhost', port: 6379 )
  redis.save(leaderboards)
else
  JSGenerator.save(leaderboards) 
end
