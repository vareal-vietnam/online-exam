module ModuleTrimSpaceName
  extend ActiveSupport::Concern

  included do
    before_save :trim_space_name
  end

  private

  def trim_space_name
    self.name = name.squish
  end
end
