require 'securerandom'

class IdGenerator
  VERSION = '0.1.1'.freeze

  COUNTER_PART_SIZE = 8
  CONTEXT_PART_SIZE = 2

  RANDOM_PART_BYTES = 11
  COUNTER_START = Time.new(2000).to_i

  class Error < StandardError
  end

  def initialize(context_id)
    raise(IdGenerator::Error, 'Invalid project id') unless context_id_valid?(context_id)

    @context_id = value_to_hex(context_id, CONTEXT_PART_SIZE)
  end

  def generate
    "#{time}-#{@context_id}-#{random_number}"
  end

  private

  def context_id_valid?(context_id)
    return false unless context_id.is_a?(Integer)
    return false unless context_id.between?(0, 255)

    true
  end

  def time
    timestamp = Time.now.to_i - COUNTER_START
    value_to_hex(timestamp, COUNTER_PART_SIZE)
  end

  def random_number
    SecureRandom.hex(RANDOM_PART_BYTES)
  end

  def value_to_hex(value, size)
    format("%0#{size}x", value)
  end
end
