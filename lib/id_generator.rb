require 'id_generator/version'
require 'id_generator/configuration'
require 'id_generator/errors'
require 'id_generator/generators/timestamped_random'

module IdGenerator
  def self.configure
    yield(configuration)
  end

  def self.generate
    id_generator.generate
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.id_generator
    @id_generator ||= IdGenerator::Generators::TimestampedRandom.new(configuration)
  end
end
