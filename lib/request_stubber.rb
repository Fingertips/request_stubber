# Allows you to stub a request by either delaying the request time,
# returning a specific response code, or a combination of both.
#
# Note that the RequestStubber module should normally only be used in
# development mode.
module RequestStubber
  # Delays the process time of the request, by n seconds.
  #
  #   class UsersController
  #     def index
  #       # ...
  #     end
  #
  #     # Any request send to :index will be delayed 2 seconds.
  #     delay :index, 2
  #   end
  def delay(action, duration)
    add_request_stub action, :delay => duration
  end
  
  # Returns the specified response code.
  #
  #   class UsersController
  #     def index
  #       # ...
  #     end
  #
  #     # Any request send to :index will return a 404 response code.
  #     respond :index, 404
  #   end
  def respond(action, status)
    add_request_stub action, :respond => status
  end
  
  private
  
  def add_request_stub(action, stub)
    request_stubs[action] ||= {}
    request_stubs[action].merge!(stub)
  end
  
  def self.extended(klass)
    klass.class_inheritable_accessor :request_stubs
    klass.request_stubs = HashWithIndifferentAccess.new
    
    klass.prepend_before_filter do |controller|
      controller.instance_eval do
        if stubs = request_stubs[params[:action]]
          if delay = stubs['delay']
            logger.debug("  \e[44mRequestStubber delayed the response by #{delay} seconds.\e[0m")
            sleep delay
          end
          if status = stubs['respond']
            logger.debug("  \e[44mRequestStubber forced a #{status} response.\e[0m")
            head status
            false
          end
        end
      end
    end
  end
end