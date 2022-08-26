module Shared
  class MethodInfo < Shared::Base
    renders_one :options_list, Shared::OptionsList
    renders_one :description
    renders_one :example, ->(&block) do
      if block.present?
        code = capture(&block)
        "```#{example_lang}\n#{code.strip_heredoc.strip.gsub("&lt;", "<").gsub("&gt;", ">")}\n```"
      end
    end

    attr_reader :name, :title, :example_lang, :display_signature

    def initialize(name:, title: nil, example_lang: :erb, signature: nil, **attrs)
      @name = name
      @title = title || name.to_s
      @example_lang = example_lang
      @display_signature = signature != false
      @signature = signature || name.to_s
      @attrs = attrs
    end

    def signature
      "```ruby\n#{@signature}\n```"
    end
  end
end
