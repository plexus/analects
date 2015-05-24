require 'generators/analects'

module Analects
  module Generators
    class CedictGenerator < Analects::Generators::Base
      desc %(Description:
    Copy analects CC-CEDICT files to your application.
)

      def analects_create_cedict_table
        migration_template 'create_cedict_table.rb', 'db/migrate/create_cedict_table.rb'
      end

      def analects_populate_cedict_table
        migration_template 'populate_cedict_table.rb', 'db/migrate/populate_cedict_table.rb'
      end

      def analects_cedict_model
        template 'model.rb', 'app/models/cedict.rb'
      end
    end
  end
end
