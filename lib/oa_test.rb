files =Dir[File.join(File.dirname(__FILE__),%w[.. lib oa_test ** *.rb])]
files.each{ |f|require(f) }
OAuthTest.send :include, ::OaTestVersion
