oa_test: OAuth version 1.0x testing console
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

command console: 
~~~~~~~~~~~~~~~~

syntax:
~~~~~~~
-/>oa_test [--consumer:token/secret] --yauth:login/passwd [--return:body|boolean|object] [--host:host] [--api:path]

PATH: http://www.koprol.com/api/v2/..path..
Your instance object stored in OA|oa
Ex: oa.get '/me.json'

ree-2010.02 > oa.public_methods nil
 => ["api", "api=", "delete", "get", "host", "host=", "post", "put", "yauth"] 
ree-2010.02 > oa.get '/me.json'
 => "{"user":{...}}" 
ree-2010.02 > 


Ruby code: 
~~~~~~~~~~
oa = OAuthTest.new(
  :key    => 'consumer_token',
  :secret => 'consumer_secret'
).yauth(
  :login  => 'y_login',
  :passwd => 'y_password'
)
oa.get('/me.json')

========================
Thanks to: wh,rs,le,rchs
------------------------