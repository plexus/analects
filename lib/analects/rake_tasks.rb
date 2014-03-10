require 'rake/tasklib'

module Analects
  class RakeTasks < Rake::TaskLib
    def initialize(name = :analects, &blk)
      @name = name
      if block_given?
        if blk.arity == 0
          self.instance_eval(&blk)
        else
          yield self
        end
      end
      define
    end

    def library
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
        namespace :download do
          desc 'download CC-CEDICT'
          task :cedict do
            library.cedict.retrieve!
          end

          desc 'download Chise-IDS'
          task :chise_ids do
            library.chise_ids.retrieve!
          end

          desc 'download all sources'
          task :all => [:cedict, :chise_ids]
        end
      end

    end
  end
end
