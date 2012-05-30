module Analects
  module CLI
    # Command line progress bar
    class Progress
      attr_accessor :length, :count
      
      def initialize(total, accuracy = 1000)
        @total = total
        @current = 0
        @length = 60
        @count = 100
        @accuracy = accuracy
      end
      
      def next
        @current += 1
        draw
      end
      
      def draw
        return unless (@current % (Float(@total)/@accuracy).ceil) == 0
        x = pos(@length).floor
        print "\e[%dD\e[32m[\e[31m%s%s\e[32m]\e[34m %d/%d\e[0m" % [@length+10, '='*x, ' '*(@length-x), pos(@count), @count] 
      end
      
      def pos(scale)
        Float(@current)/@total * scale 
      end
    end
  end
end
