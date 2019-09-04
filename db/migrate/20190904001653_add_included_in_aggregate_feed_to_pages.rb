class AddIncludedInAggregateFeedToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :included_in_aggregate_feed, :boolean, default: false
    add_index :pages, :included_in_aggregate_feed
  end
end
