include ActionView::Helpers::TextHelper

namespace :posts do
  desc 'Adds publish time to posts from podcast episode\'s date'

  task copy_publish_time_from_date: :environment do
    posts = Post.where(publish_time: nil)
    posts.find_each do |post|
      CopyPublishTimeToPosts.perform_async(post.id)
    end
  end

  task generate_slugs: :environment do
    posts = Post.where(slug: nil)
    posts.find_each do |post|
      GenerateSlugsWorker.perform_async(post.id)
    end
  end

  task migrate_description_to_content: :environment do
    posts = Post.includes(:postable).all
    posts.find_each do |post|
      next if post.postable.content.persisted?
      post.postable.content = simple_format(post.postable.description)
      post.postable.content.save
    end
  end

  task migrate_publish_time_from_post: :environment do
    posts = Post.where(postable_type: "PodcastEpisode")
    posts.find_each do |post|
      post.podcast_episode.update(publish_time: post.publish_time.to_datetime)
    end
  end

  task migrate_to_audio_posts: :environment do
    posts = Post.where(postable_type: "PodcastEpisode")
    posts.find_each do |post|
      post.update(postable_type: "AudioPost")
    end
  end
end
