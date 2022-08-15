namespace :downloads do
  desc 'recalculates download count for posts'

  task recalculate: :environment do
    pages = Page.includes(:audio_posts).all

    pages.find_each do |page|
      page.audio_posts.find_each do |post|
        individual_downloads = post.downloads
          .where(feed_source: "individual")
          .where.not(browser: nil)
          .count
        aggregate_feed_downloads = post.downloads
          .where(feed_source: "aggregate_feed")
          .where.not(browser: nil)
          .count

        post.update(
          individual_downloads: individual_downloads,
          aggregate_feed_downloads: aggregate_feed_downloads,
          total_downloads: individual_downloads + aggregate_feed_downloads,
        )
      end
    end
  end

  desc 'creates fake downloads for testing'

  task generate: :environment do
    page = Page.last

    post_1 = page.audio_posts.first

    10_000.times do
      user_agent = Faker::Internet.user_agent
      client = DeviceDetector.new(user_agent)
      url = URI.parse(Faker::Internet.url)
      Download.create(
        audio_post_id: post_1.id,
        page_id: post_1.page.id,
        user_id: nil,
        ip: Faker::Internet.ip_v4_address,
        user_agent: user_agent,
        referrer: url.to_s,
        referring_domain: url.host,
        feed_source: %w[individual aggregate_feed].shuffle.first,
        browser: client.name,
        os: client.os_name,
        device_type: client.device_type,
        country: Faker::Address.country,
        region: Faker::Address.city,
        city: Faker::Address.city,
        latitude: Faker::Address.latitude,
        longitude: Faker::Address.longitude,
        created_at: rand(60.days).seconds.ago,
      )
    end

    post_2 = page.audio_posts.last
    10_000.times do
      user_agent = Faker::Internet.user_agent
      client = DeviceDetector.new(user_agent)
      url = URI.parse(Faker::Internet.url)
      Download.create(
        audio_post_id: post_2.id,
        page_id: post_1.page.id,
        user_id: nil,
        ip: Faker::Internet.ip_v4_address,
        user_agent: user_agent,
        referrer: url.to_s,
        referring_domain: url.host,
        feed_source: %w[individual aggregate_feed].shuffle.first,
        browser: client.name,
        os: client.os_name,
        device_type: client.device_type,
        country: Faker::Address.country,
        region: Faker::Address.city,
        city: Faker::Address.city,
        latitude: Faker::Address.latitude,
        longitude: Faker::Address.longitude,
        created_at: rand(60.days).seconds.ago,
      )
    end
  end
end
