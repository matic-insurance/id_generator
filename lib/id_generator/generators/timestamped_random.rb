require 'securerandom'

module IdGenerator
  module Generators
    class TimestampedRandom
      COUNTER_PART_SIZE = 8
      CONTEXT_PART_SIZE = 2

      RANDOM_PART_BYTES = 11
      COUNTER_START = Time.new(2000).to_i

      attr_reader :config

      def initialize(config)
        @config = config
      end

      def generate
        "#{time}-#{context_id}-#{random_number}"
      end

      private

      def time
        timestamp = Time.now.to_i - COUNTER_START
        value_to_hex(timestamp, COUNTER_PART_SIZE)
      end

      def context_id
        value_to_hex(config.context_id, CONTEXT_PART_SIZE)
      end

      def random_number
        SecureRandom.hex(RANDOM_PART_BYTES)
      end

      def value_to_hex(value, size)
        format("%0#{size}x", value)
      end
    end
  end
end
