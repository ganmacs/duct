module Dukt
  class Engine
    class << self
      def load_all
        input = File.join(File.dirname(__FILE__), 'input')
        output = File.join(File.dirname(__FILE__), 'output')
        client = File.join(File.dirname(__FILE__), 'client')
        load_dir(input)
        load_dir(output)
        load_dir(client)
      end

      def load_dir(dir)
        Dir.entries(dir).each do |fname|
          if fname =~ /\.rb$/
            require File.join(dir, fname)
          end
        end
      end

      def define(input, output)
        in_class =  ::Dukt::Input.const_get(camelize(input))
        out_class = ::Dukt::Input.const_get(camelize(output))
        v = in_class.new.start
        p v
        # out_class.new
      end

      def camelize(v)
        v.split('_').map { |e| e[0].upcase + e[1..-1] }.join
      end
    end
  end
end
