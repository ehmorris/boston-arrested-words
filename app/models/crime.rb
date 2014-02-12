class Crime < ActiveRecord::Base
  attr_protected

  def self.unique_column_types column_name
    self.select("DISTINCT \"#{column_name}\"")
        .map(&:"#{column_name}")
        .reject(&:nil?)
  end

  def self.value_per_column_type column_type, column_value, value
    self.select("#{value}")
        .where("#{column_type} = ?", column_value)
        .map(&:"#{value}")
        .reject(&:nil?)
  end
end
