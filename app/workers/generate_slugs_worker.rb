# Generates slugs for posts without them
class GenerateSlugsWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find(post_id)
    slug = nil

    raise 'couldn\'t find podcast episode' unless post.postable

    if post.postable
      slug = "#{post.postable.title.parameterize}-#{SecureRandom.hex(5)}"
    else
      slug = "#{SecureRandom.hex(5)}"
    end

    post.update(slug: slug)
  end
end
