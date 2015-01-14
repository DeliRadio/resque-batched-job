# This class was pulled from resque/helpers.rb from 1-x-stable
# to get around an eventual deprecation.
# These methods may not work in future versions of resque.

require 'multi_json'

module Resque
  module Plugins
    module BatchedJob
      module Helpers

        # Direct access to the Redis instance.
        def redis
          # No infinite recursions, please.
          # Some external libraries depend on Resque::Helpers being mixed into
          # Resque, but this method causes recursions. If we have a super method,
          # assume it is canonical. (see #1150)
          return super if defined?(super)

          Resque.redis
        end

        # Given a Ruby object, returns a string suitable for storage in a
        # queue.
        def encode(object)
          if MultiJson.respond_to?(:dump) && MultiJson.respond_to?(:load)
            MultiJson.dump object
          else
            MultiJson.encode object
          end
        end
      end
    end
  end
end