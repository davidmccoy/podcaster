class BaseDecorator < SimpleDelegator
  class << self
    def decorate_collection(collection)
      CollectionDecorator.new(collection, self)
    end
  end

  def class
    __getobj__.class
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end
end
