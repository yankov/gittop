class GitRepo
  attr_accessor :path

  def initialize(path)
    self.path = path
  end

  def git_summary(options={})
    opts = options[:since] ? [ "--since #{options[:since]}" ] : []

    opts << "--until #{options[:until]}" if options[:until]

    puts "git --git-dir=#{@path}/.git shortlog -sne #{opts.join(' ')} --all"

    output = `git --git-dir=#{@path}/.git shortlog -sne #{opts.join(' ')} --all`.chop

    output.split("\n").map{|s| s.split("\t")}.map! do |r| 
      name, email = r.last.split(/ \<(.*)\>/)

      # now userpic can be found http://www.gravatar.com/avatar/#{email_hash}"
      email_hash = Digest::MD5.hexdigest(email.downcase)

      [r.first.to_i, name, email]
    end
  end

  def today
    Date.today
  end

  def leaderboard(type=nil)
    case type
    when :all_time, nil
      all_time_leaderboard
    when :daily
      daily_leaderboard
    when :weekly
      weekly_leaderboard
    when :monthly
      monthly_leaderboard
    else
      raise "#{type} leaderboard is not supported"
    end
  end

  def all_time_leaderboard
    git_summary
  end

  def monthly_leaderboard
    beginning_of_month = today.strftime('%Y-%m-01')

    git_summary(:since => beginning_of_month)
  end

  def weekly_leaderboard
    monday = (today - today.wday + 1).strftime('%Y-%m-%d')

    git_summary(:since => monday)
  end

  def daily_leaderboard
    date_of_today = today.strftime('%Y-%m-%d')

    git_summary(:since => date_of_today)
  end

end