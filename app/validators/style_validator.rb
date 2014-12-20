class StyleValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    result = Document.select(:style).where(user_id: record.user_id).where(style: value).where.not(id: record.id)
    unless result.empty?
      record.errors[attribute] << (options[:message] || "already exists.  You may only have one submission of each style")
    end
  end
end