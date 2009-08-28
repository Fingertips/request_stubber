if RAILS_ENV == 'development'
  require File.expand_path('../lib/request_stubber', __FILE__)
  ActionController::Base.send :extend, RequestStubber
end