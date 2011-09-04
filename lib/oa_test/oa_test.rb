require 'json'
require 'OAuth'
require 'HTTParty'

class OAuthTest
  attr_accessor :host,:api
  attr_reader :resp

  def initialize(ks)
    config_load(ks)
    @key    = config.key
    @secret = config.secret
    @return = config.return 
    @host   = config.host   
    @api    = config.api    
    @typ    = {
     :json => {"Accept" => "application/json", "Content-Type" => "application/json"},
     :xml  => {"Accept" => "application/xml", "Content-Type" => "application/xml"},
    }
  end

  def yauth(lp)
    get_part(lp).get_token()
  end

  def get(path)
    rtn @access_token.get(@host+@api+path,typ(path))
  end

  def post(path,params)
    rtn @access_token.post(@host+@api+path,params.to_json,typ(path))
  end

  def put(path,params)
    rtn @access_token.put(@host+@api+path,params.to_json,typ(path))
  end

  def delete(path)
    rtn @access_token.delete(@host+@api+path,typ(path))
  end

  protected

  def get_part(lp)
    url     = "https://login.yahoo.com/WSLogin/V1/get_auth_token"	
    content = {:query=>{:oauth_consumer_key=>@key, :passwd=>lp[:passwd], :login=>lp[:login]}}
    @part   = HTTParty.get(url, content).parsed_response.split('=')[1].gsub("\n","")
    self
  end

  def get_token
    consumer     = OAuth::Consumer.new(@key,@secret, { :site => "https://api.login.yahoo.com", :access_token_path => "/oauth/v2/get_token" })
    req_token    = OAuth::RequestToken.new(consumer, @part)
    token_hash   = consumer.token_request(:post, "/oauth/v2/get_token", req_token)
    @access_token= OAuth::AccessToken.new(consumer,token_hash["oauth_token"],token_hash["oauth_token_secret"])
    self
  end

  def typ(path)
    @ext = path[/.(json|xml)($|\?)/,1]
    @ext = 'json' if !@ext
    @typ[@ext.to_sym]
  end

  def rtn(resp)
    @resp = resp
    puts resp.class
    if @return==nil || resp.class!=Net::HTTPOK || @return==:body
      resp.body
    elsif @return==:body_hash && resp.class==Net::HTTPOK 
      if @ext=='json'
        Hash.from_json(resp.body)
      elsif @ext=='xml'
        Hash.from_xml(resp.body)
      end
    elsif @return==:boolean
      resp.class==Net::HTTPOK 
    else
      resp
    end
  end
end
