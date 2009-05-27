require 'ziya/core_ext/string'

module Ziya
  module HtmlHelpers
    module Base

      def mime()        "application/x-shockwave-flash"; end
      def plugin_url()  "http://www.macromedia.com/go/getflashplayer"; end

      # Set the wmode to opaque if a bgcolor is specified. If not set to
      # transparent mode unless user overrides it    
      def setup_wmode( options )
        if options[:bgcolor]
          options[:wmode] = "opaque" unless options[:wmode]
        else
          options[:wmode]   = "transparent" unless options[:wmode]
          options[:bgcolor] = "#FFFFFF"
        end
      end
  
      # Check args for size option in the format wXy (Submitted by Sam Livingston-Gray)                                  
      def setup_movie_size( options )
        if options[:size] =~ /(\d+)x(\d+)/
          options[:width]  = $1
          options[:height] = $2
          options.delete :size
        end
      end
    
      # escape url    
      def escape_url( url )
        url ? CGI.escape( url.gsub( /&amp;/, '&' ) ) : url
      end
   
      # # All this stolen form rails to make Ziya work with other fmks....    
      def tag(name, options = nil, open = false, escape = true)
       "<#{name}#{tag_options(options, escape) if options}" + (open ? ">" : " />")
      end    
        
      def escape_once(html)
        html.to_s.gsub(/[\"><]|&(?!([a-zA-Z]+|(#\d+));)/) { |special| escape_chars[special] }
      end
        
      def tag_options(options, escape = true)
        unless !options or options.empty?
          attrs = []
          if escape
            options.each do |key, value|
              next unless value
              key = key.to_s
              value = escape_once(value)
              attrs << %(#{key}="#{value}")
            end
          else
            attrs = options.map { |key, value| %(#{key}="#{value}") }
          end
          " #{attrs.sort * ' '}" unless attrs.empty?
        end
      end
      #   
      # def content_tag(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
      #   if block_given?
      #     options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
      #     content = capture_block(&block)
      #     content_tag = content_tag_string(name, content, options, escape)
      #     block_is_within_action_view?(block) ? concat(content_tag, block.binding) : content_tag
      #   else
      #     content = content_or_options_with_block
      #     content_tag_string(name, content, options, escape)
      #   end
      # end
      #   
      # def capture_block( *args, &block )
      #     block.call(*args)
      # end
      #   
      # def content_tag_string(name, content, options, escape = true)
      #   tag_options = tag_options(options, escape) if options
      #   "<#{name}#{tag_options}>#{content}</#{name}>"
      # end
      # 
      # def block_is_within_action_view?(block)
      #   eval("defined? _erbout", block.binding)
      # end  
      #   
      def escape_chars 
        { '&' => '&amp;', '"' => '&quot;', '>' => '&gt;', '<' => '&lt;' }
      end          
    end
  end
end