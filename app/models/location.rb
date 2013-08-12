class Location
  include MongoMapper::Document
  include Geocoder::Model::Mongoid

  key :text, String
  key :latitude, String
  key :longitude, String

  belongs_to :foodtruck

end
