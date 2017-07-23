module WikisHelper
  def markdown(text)
    options = {
      filter_html: true,
      prettify: true
    }

    extensions = {
      autolink: true,
      quote: true,
      disable_intended_code_blocks: true,
      superscript: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
