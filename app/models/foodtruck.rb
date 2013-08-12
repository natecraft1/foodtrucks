class Foodtruck
  include MongoMapper::Document

  key :name, String
  key :twitter, String

  many :locations

end
