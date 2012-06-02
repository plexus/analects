module Analects
  module CLI
    # Command line progress bar
    class Progress
      attr_accessor :length, :count
      
      def initialize(total, accuracy = 1000, prefix = '')
        @total = total
        @current = 0
        @length = 60
        @count = 100
        @accuracy = accuracy
        @prefix = prefix
      end
      
      def next
        @current += 1
        draw if (@current % (Float(@total)/@accuracy).ceil) == 0 || @current == @total
      end
      
      def draw
        return unless 
        x = pos(@length).floor
        total_count = @count == 100 ? '%' : "/#{@count}"
        print "\e[%dD\e[32m%s[\e[31m%s%s\e[32m]\e[34m %d%s\e[0m" % [@length+10+@prefix.length, @prefix, '='*x, ' '*(@length-x), pos(@count), total_count] 
      end
      
      def pos(scale)
        if @current == @total
          scale
        else
          Float(@current)/@total * scale 
        end
      end
    end
  end
end
