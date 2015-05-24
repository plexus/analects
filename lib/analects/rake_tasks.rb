require 'rake/tasklib'

module Analects
  class RakeTasks < Rake::TaskLib
    def initialize(name = :analects, &blk)
      @name = name
      if block_given?
        if blk.arity == 0
          instance_eval(&blk)
        else
          yield self
        end
      end
      define
    end

    def library
      @library ||= Analects::Library.new(options)
    end

    def sources
      library.sources
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
          sources.each do |source|
            desc "download #{source.name}"
            task source.name do
              source.retrieve!
            end
          end

          desc 'download all sources'
          task all: sources.map(&:name)
        end
      end
    end
  end
end
