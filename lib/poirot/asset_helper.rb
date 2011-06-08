module Poirot
  module AssetHelper
    def template_include_tag(*sources)
      options = sources.extract_options!.stringify_keys
      options[:partial] ||= false

      sources.collect do |source|
        template_path = Rails.root.join('app/views', controller_name, "_#{source}.html.mustache")
        template = File.open(template_path, "rb")
        content_options_hash = {:type => "text/html", :id => "#{source.dasherize}"}
        content_options_hash[:class] = "partial" if options[:partial]
        content_tag :script, template.read.html_safe, content_options_hash
      end.join("\n").html_safe
    end
  end
end