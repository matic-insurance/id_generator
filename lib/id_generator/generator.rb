require 'id_generator/version'
require 'id_generator/config'
require 'securerandom'

module IdGenerator
  class Generator
    def initialize
      @project_id = Config.project_id.to_i
    end

    def generate
      validate_project_id

      "#{time}-#{@project_id}-#{random_number}"
    end

    private

    def validate_project_id
      return if project_id_valid?

      raise(IdGenerator::Config::Error, 'Invalid project id')
    end

    def project_id_valid?
      @project_id.positive?
    end

    def time
      (Time.now.to_i - Time.new(2014).to_i).to_s(16)
    end

    def random_number
      SecureRandom.hex(11)
    end
  end
end
