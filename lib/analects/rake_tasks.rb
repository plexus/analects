module Analects
  class RakeTasks < Rake::TaskLib
    def initialize name = :analects
      @name = name
      yield self if block_given?
      define
    end

    def library
      p options
      @library ||= Analects::Library.new(options)
    end

    def options
      @options ||= {}
    end

    def data_dir(dir)
      options[:data_dir] = dir
    end

    def define
      namespace @name do
        namespace :retrieve do
          desc 'download CC-CEDICT'
          task :cedict do
            library.cedict.retrieve
          end

          desc 'download Chise-IDS'
          task :chise_ids do
            library.chise_ids.retrieve
          end

          desc 'download all sources'
          task :all => [:cedict, :chise_ids]
        end
      end

    end
  end
end
