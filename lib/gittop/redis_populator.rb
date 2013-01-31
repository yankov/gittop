class RedisPopulator
  attr_accessor :redis

  def initialize(settings)
    settings ||= { host: 'localhost', port: 6379 }
    
    @redis = Redis.new(settings)
  end

  def save(leaderboards)
    leaderboards.each do |name, data| 
      data.each do |position|
        score, author, email  = position

        @redis.zadd("#{name}_leaderboard", score, author)
      end
    end
  end
  
end