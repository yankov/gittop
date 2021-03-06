module JSGenerator
  
  TEMPLATE = "templates/leaderboard.js.erb"

  class << self
    
    def template_file
      @file ||= File.read(File.dirname(__FILE__) + "/" + TEMPLATE)
    end

    def template
      ERB.new(template_file)
    end

    def save(filename, leaderboards)
      @now = Time.now
      File.open(filename, 'w') do |f|
        f.write template.result(binding)
      end
    end

  end # class << self

end