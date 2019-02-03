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
end
