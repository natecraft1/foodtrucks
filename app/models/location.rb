class Location
  include MongoMapper::Document

  key :text, String
  key :latitude, String
  key :longitude, String

  belongs_to :foodtruck

end
