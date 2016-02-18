class UrlParser
  def self.parseUrl(url)

    url["http"] = "https" if Rails.env.production?
    url

  end
end
