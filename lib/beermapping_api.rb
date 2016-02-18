class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    smart_fetch(city, expires_in: 60.minutes) { fetch_places_in(city) }
  end

  def self.smart_fetch(name, options = {}, &blk)
    in_cache = Rails.cache.fetch(name)
    return in_cache if in_cache
    if block_given?
      val = yield
      Rails.cache.write(name, val, options)
      return val
    end
  end

  private

  def self.fetch_places_in(city)
    # url = 'http://stark-oasis-9187.herokuapp.com/4e5e7f509ff55c2e617a4357968e80d5/'
    url = 'http://stark-oasis-9187.herokuapp.com/api/'
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do | place |
      Place.new(place)
    end
  end

  def self.key
    raise "APIKEY env variable not defined" if ENV['APIKEY'].nil?
    ENV['APIKEY']
  end

end