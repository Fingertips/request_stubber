$: << File.expand_path('../../', __FILE__)

require 'rubygems'
require 'active_support'
require 'action_controller'
require 'action_controller/test_case'
require 'action_controller/test_process'

require 'test/unit'
require 'test/spec'

RAILS_ENV = 'development'
require 'init'

logger = Object.new
%w{ debug info }.each do |attr|
  eval "def logger.#{attr}(str); end"
  eval "def logger.#{attr}?; false; end"
end
ActionController::Base.logger = logger
ActionController::Routing::Routes.reload rescue nil

class ApplicationController < ActionController::Base
  def rescue_action(e) raise e end;
end

class StubbedController < ApplicationController
  
  def delayed_action
    render :text => 'this action was delayed!'
  end
  delay :delayed_action, 2
  
  def respond_with_404
    render :text => 'this text should not arrive!'
  end
  respond :respond_with_404, 404
  
  def delayed_and_respond_with_500
    render :text => 'this text should not arrive!'
  end
  delay :delayed_and_respond_with_500, 3
  respond :delayed_and_respond_with_500, 500
end

class NonStubbedController < ApplicationController
  def index
    render :nothing => true
  end
end

describe "A controller with stubbed requests", ActionController::TestCase do
  tests StubbedController
  
  it "should add the defined stubs for the controller to the request_stubs hash" do
    StubbedController.request_stubs.should == {
      'delayed_action' => { 'delay' => 2 },
      'respond_with_404' => { 'respond' => 404 },
      'delayed_and_respond_with_500' => { 'delay' => 3, 'respond' => 500 }
    }
  end
  
  it "should be able to delay the duration of a request" do
    should_be_delayed_by(2) do
      get :delayed_action
      @response.body.should == 'this action was delayed!'
    end
  end
  
  it "should be able to respond with a specific status code" do
    get :respond_with_404
    @response.response_code.should == 404
    @response.body.should.be.blank
  end
  
  it "should be to mix a delay and respond stub" do
    should_be_delayed_by(3) do
      get :delayed_and_respond_with_500
      @response.response_code.should == 500
      @response.body.should.be.blank
    end
  end
  
  private
  
  def should_be_delayed_by(seconds)
    start = Time.now
    yield
    Time.now.should >= start + seconds
  end
end

describe "A controller without stubbed requests", ActionController::TestCase do
  tests NonStubbedController
  
  it "should still work" do
    get :index
    @response.response_code.should == 200
  end
end