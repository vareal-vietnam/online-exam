module ModuleTrimSpaceContent
  extend ActiveSupport::Concern

  included do
    before_save :trim_space_content
  end

  private

  def trim_space_content
    self.content = content.squish
  end
end
