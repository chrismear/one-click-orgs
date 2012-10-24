require 'haml/filters'

begin
  require 'rdiscount'
rescue LoadError
  require 'maruku'
  require 'active_support/dependencies/autoload'
  require 'action_controller/vendor/html-scanner'
end

Haml::Filters.remove_filter("Markdown")

module Haml
  module Filters
    # Override Haml's built-in Markdown filter to add escaping of raw HTML.
    module Markdown
      include Base

      def render_with_options(text, options)
        if defined?(::RDiscount)
          ::RDiscount.new(text, :filter_html).to_html.html_safe
        else
          text = ::HTML::FullSanitizer.new.sanitize(text)
          ::Maruku.new(text).to_html.html_safe
        end
      end
    end
  end
end
