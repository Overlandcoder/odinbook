class Profile < ApplicationRecord
  belongs_to :user

  def display_name
    name.empty? ? "-" : name.titleize
  end

  def display_gender
    gender.empty? ? "-" : gender.capitalize
  end

  def display_age
    age.nil? ? "-" : age
  end

  def display_location
    location.empty? ? "-" : location.capitalize
  end
end
