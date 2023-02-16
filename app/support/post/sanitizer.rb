class Post::Sanitizer
  def initialize
    @sanitizer = Rails::Html::Sanitizer.safe_list_sanitizer.new
    @allowed_tags = @sanitizer.class.allowed_tags + [
      ActionText::Attachment.tag_name, # maintain support for Action Text for now
      'figure',
      'figcaption',
      'mark', # highlights
      's', # strikethrough
    ]
    @allowed_attributes = @sanitizer.class.allowed_attributes + ActionText::Attachment::ATTRIBUTES
    @scrubber = nil
  end

  def sanitize(html)
    @sanitizer.sanitize(
      html,
      tags: @allowed_tags,
      attributes: @allowed_attributes,
      scrubber: @scrubber
    ).html_safe
  end
end
