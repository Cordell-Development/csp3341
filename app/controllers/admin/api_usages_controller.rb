class Admin::ApiUsagesController < Admin::BaseController
  def index
    @total = ApiUsage.count()
    @cache_hits = ApiUsage.where(cache_hit: true).count
    @hit_ratio = @total.zero? ? 0 : (@cache_hits.to_f / @total * 100).round(1)
    @top_locations = ApiUsage.joins(:location)
      .group("locations.city_name")
      .order("count_all DESC")
      .limit(10)
      .count
    @recent = ApiUsage.order(created_at: :desc).limit(20)
  end
end
