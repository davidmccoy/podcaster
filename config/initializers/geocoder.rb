Geocoder.configure(
  ip_lookup: :ipinfo_io,
  api_key: ENV['APINFO_API_KEY'],
  cache: Redis.new(url: ENV["REDIS_URL"]),
)
