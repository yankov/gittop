class CLI

  class << self
    def parse_options(args)
      options = {}

      opts = OptionParser.new do |opts|
        opts.banner = "Usage: gittop [repository_path] [options]"
        opts.separator ""
        opts.separator "Generates leaderboards of commiters from a git repository."
        opts.separator "Saves data either as JS array in a file or in Redis."
        opts.separator ""
        opts.separator "Examples:"
        opts.separator ""
        opts.separator "gittop -f                                       Save leaderboards in a JS file"
        opts.separator "gittop /ruby/myproj                             Specifies path to repository"
        opts.separator "gittop /ruby/myproj --redis localhost:6379      Generate leaderboards and store in Redis"
        opts.separator ""
        opts.separator "Specific options:"

        opts.on("-h","--help", "Display this screen") do 
          puts opts
          exit
        end

        opts.on("-f", "--file [FILENAME]", String, "Save leaderboards in a JS file") do |filename|
          filename = "leaderboards.js" if filename.nil?

          options[:filename] = filename
        end

        opts.on("-r", "--redis REDIS_URL", String, "Save leaderboards in Redis") do |redis_url|
          redis_url = "redis://#{redis_url}" unless redis_url =~ /^redis\:\/\//

          options[:redis_url] = URI.parse(redis_url)
        end

      end

      begin
        opts.parse!(args)
        options[:repo_path] = ARGV.first || "."
        raise OptionParser::MissingArgument if options[:filename].nil? && options[:redis_url].nil?
      rescue OptionParser::InvalidOption, OptionParser::MissingArgument      
        puts opts                                                          
        exit                                                                   
      end                                                                      

      options
    end  # parse_options()

  end # class << self
end  # class CLI