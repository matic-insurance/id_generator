require 'securerandom'

class IdGenerator
  VERSION = '0.1.0'.freeze

  class Error < StandardError
  end

  def initialize(context_id)
    @context_id = context_id.to_i
  end

  def generate
    validate_context_id

    "#{time}-#{@context_id}-#{random_number}"
  end

  private

  def validate_context_id
    return if context_id_valid?

    raise(IdGenerator::Error, 'Invalid project id')
  end

  def context_id_valid?
    @context_id.positive?
  end

  def time
    (Time.now.to_i - Time.new(2014).to_i).to_s(16)
  end

  def random_number
    SecureRandom.hex(11)
  end
end
