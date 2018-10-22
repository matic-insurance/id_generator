require 'securerandom'

class IdGenerator
  VERSION = '0.1.1'.freeze

  class Error < StandardError
  end

  def initialize(context_id)
    raise(IdGenerator::Error, 'Invalid project id') unless context_id_valid?(context_id)
    @context_id = value_to_hex(context_id, 2)
  end

  def generate
    "#{time}-#{@context_id}-#{random_number}"
  end

  private

  def context_id_valid?(context_id)
    return false unless context_id.is_a?(Integer)
    return false unless context_id < 256
    return false unless context_id > 0
    true
  end

  def time
    value_to_hex(Time.now.to_i - Time.new(2014).to_i, 8)
  end

  def value_to_hex(value, size)
    sprintf("%0#{size}x", value)
  end

  def random_number
    SecureRandom.hex(11)
  end
end
