# scope class for constructing a search of all pages
class Page::Search
  def initialize(base_scope, query_params, params)
    @base_scope = base_scope
    @query_params = query_params
    @params = params
  end

  def all
    # :latest_post is restricted to one post, but eager loading :postable ends up
    # eager loading many more than one associated postable records, so I'm leaving
    # that n+1 for now
    records = @base_scope.includes(:logo, :latest_post)

    records = records.joins(:categories).where(categories:  { name: @query_params[:category] }) unless @query_params[:category].blank?

    records = records.where('pages.name ilike ?', "%#{@query_params[:term].strip}%") unless @query_params[:term].blank?

    if @query_params[:sort_by] == 'title'
      # order is case sensitive
      records = records.order('lower(pages.name) ASC')
    else
      # our default sort is by latest episode
      records = records.joins('INNER JOIN posts ON posts.page_id = pages.id')
        .where('posts.postable_type = ? and posts.publish_time < ?', 'AudioPost', Time.zone.now)
        .group('pages.id')
        .order('max(posts.publish_time) DESC')
    end

    records = records.paginate(page: @params[:page], per_page: 15)

    records
  end
end
