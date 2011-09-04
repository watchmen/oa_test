require 'ostruct'
require 'yaml'

class OpenStruct
  def _to_hash
    h = @table
    #handles nested structures
    h.each do |k,v|
      if v.class == OpenStruct
        h[k] = v._to_hash
      end
    end
    return h
  end
end

class OAuthTest
  attr_reader :config
  
  protected 
  
  def config_load(ks)
    fl = File.expand_path("~/.oa_test")
    @config = File.exist?(fl) ? YAML.load_file(fl) : OpenStruct.new
    
    #@config = OpenStruct.new(ym)
    puts 'Read config: ~/.oa_test'

    @config.key    = ks[:key].strip    if ks[:key]
    @config.secret = ks[:secret].strip if ks[:secret]
    
    @config.host   = 'http://www.koprol.com' if !@config.host
    @config.api    = '/api/v2'               if !@config.api
    @config.host   = ks[:host]   if ks[:host]
    @config.api    = ks[:api]    if ks[:api]
    
    @config.return = ks[:return] if ks[:return]
    @config.file   = ks[:file]   if ks[:file]
    
    if ks[:key] || ks[:secret] || ks[:return] || ks[:host] || ks[:api] || ks[:file]
      File.open(File.expand_path("~/.oa_test"),'w') { |f| f.puts @config.to_yaml }
    end
  end  
end

