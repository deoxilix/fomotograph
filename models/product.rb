%w{
  httparty
  json
}.each{ |gem| require gem }

class Product
  attr_reader :id, :title, :summary, :location, :price, :url

  url = "https://fomotograph-api.udacity.com/products.json"
  DATA = HTTParty.get(url)["photos"]
  LOCATIONS = ['canada', 'england', 'france', 'ireland', 'mexico', 'scotland', 'taiwan', 'us']

  def initialize( product_data = {} )
    @id = product_data['id']
    @title = product_data['title']
    @summary = product_data['']
    @location = product_data['location']
    @price = product_data['price']
    @url = product_data['url']
  end

  def self.all
    DATA.map{ |product| new(product) }
  end

  def self.sample_location
    @products = []
    LOCATIONS.each do |location|
      @products << self.all.select{ |product| product.location == location }.sample
    end
    @products
  end

  def self.find_by_location(location)
    self.all.select{ |product| product.location == location }
  end

  def self.find(id)
    self.all.find{ |product| product.id == id }
  end

  def self.find_by_price(price)
    self.all.select{ |product| product.price < price }
  end
end
