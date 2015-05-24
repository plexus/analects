require 'rails/generators/named_base'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module Analects
  module Generators
    class Base < ::Rails::Generators::Base
      include Rails::Generators::Migration

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

      def self.source_root
        @_analects_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'analects', generator_name, 'templates'))
      end
    end
  end
end
