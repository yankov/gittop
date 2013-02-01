class CLI

  class << self
    def parse_options(args)
      options = {}

      opts = OptionParser.new do |opts|
        opts.banner = "Usage: gittop [repository_path] [options]"
        opts.separator ""
        opts.separator "By default generates and stores leaderboards positions in a JS file"
        opts.separator "Separate array for each leaderboard."
        opts.separator ""
        opts.separator "Examples:"
        opts.separator ""
        opts.separator "gittop                                          Use repo in a current folder"
        opts.separator "gittop /ruby/myproj                             Specifies path to repository"
        opts.separator "gittop /ruby/myproj --redis localhost:6379      Generate leaderboards and store in Redis"
        opts.separator ""
        opts.separator "Specific options:"

        opts.on("-h","--help", "Display this screen") do 
          puts opts
          exit
        end

        opts.on("-r", "--redis [REDIS_URL]", String, "Write leaderboards to Redis") do |redis_url|
          p redis_url
          options[:redis] = true 
          options[:redis_url] = redis_url
        end

      end

      begin
        opts.parse!(args)
        options[:repo_path] = ARGV.first || "."

      rescue OptionParser::InvalidOption, OptionParser::MissingArgument      
        puts $!.to_s                                                           
        puts opts                                                          
        exit                                                                   
      end                                                                      

      options
    end  # parse_options()

  end # class << self
end  # class CLI