class UrlParser
  def self.parseUrl(url)
    return url unless Rails.env.production?
    return url["http"] = "https"
  end
end