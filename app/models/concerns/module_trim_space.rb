module ModuleTrimSpace
  def trim_space_name
    self.name = name.squish
  end

  def trim_space_content
    self.content = content.squish
  end
end
