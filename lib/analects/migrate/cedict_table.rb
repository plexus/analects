module Analects
  module Migrate
    module CedictTable
      def change
        create_table :cedicts do |t|
          t.string :simplified
          t.string :traditional
          t.string :pinyin
          t.string :english
          
          t.timestamps
        end
      end
    end
  end
end
