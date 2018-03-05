# dev stuff

# # #

# check if models can be reserved from different pool in 1 order
# Reservation.all.group_by do |r|
#   [:order_id, :model_id, :start_date, :end_date].map { |k| r[k] }.join(', ')
# end.select do |k,rs|
#   rs.map(&:inventory_pool_id).uniq.count > 1
# end

# --BESTBESTELLER
# SELECT user_id, count(id) as num
# FROM orders
# GROUP BY user_id
# ORDER BY num DESC

# TODO: tasks
# - [X] show ALL *contracts/reservations*, no matter if ordered or not? ==> NO!
# - [ ] group/bundle reservations in order by reservation dates
# - [ ] feature re-order bundle/order
# - [ ] show contracts per (closed/signed) order
# - [ ] show state per order
#     - (submitted, approved, partially open, open, partially closed, closeds)

class Borrow::CustomerOrders < ApplicationPresenter

  # NOTE: shows historical data, potentially going far back in time.
  #       uses `unscoped`, e.g. to show InvPools even if not active anymore

  def initialize(user:, later_than_year: nil)
    @user = user
    start_time = Time.new(later_than_year || defaults[:start_time])
    end_time = Time.now
    @orders = user.orders
      .where(created_at: (start_time.utc..end_time.utc))
      .reorder(created_at: 'DESC')
  end

  def available_filters
    {
      years: @order_years
    }
  end

  def orders_by_year
    @orders.group_by { |o| o.created_at.year }.map do |year, orders|
      [year, orders.map { |r| Borrow::CustomerOrder.new(r) }]
    end.to_h
  end

  def inventory_pools_by_id
    ::InventoryPool.unscoped.distinct
      .joins('INNER JOIN orders ON orders.inventory_pool_id = inventory_pools.id')
      .where(orders: { id: @orders })
      .map do |p|
        [p.id, Borrow::InventoryPool.new(p)]
      end.to_h
  end

  def models_by_id
    ::Model.distinct
      .joins(:reservations)
      .joins('INNER JOIN orders ON orders.id = reservations.order_id')
      .where(reservations: { order_id: @orders })
      .map do |m|
        [m.id, Borrow::Model.new(m, user: @user)]
      end.to_h
  end

  private

  def defaults
    @_defaults ||= {
      start_time: (order_years.max || Time.now.year) - 1000
    }
  end

  def order_years
    @_order_years ||= @user.orders
      .select('DISTINCT EXTRACT(YEAR FROM orders.created_at) AS year')
      .map { |o| o.year.to_i }
  end

end

# # #

class Borrow::CustomerOrder < ApplicationRecordPresenter
  delegate_to_record :inventory_pool_id, :purpose

  def initialize(*args)
    super(*args)
    @reservations = record.reservations
  end

  def state
    reservation_states = @reservations.map(&:status).uniq
    case reservation_states.length
    when 0 then record.state
    when 1 then reservation_states[0]
    else; :in_progress
    end
  end

  def total_date_range
    {
      start: @reservations.minimum(:start_date).as_json,
      end: @reservations.maximum(:end_date).as_json
    }
  end

  def reservations
    partitions = [:start_date, :end_date, :model_id]
    @reservations
      .group_by { |r| r.slice(*partitions) }
      .map do |obj, list|
        obj.merge(quantity: list.reduce(0) { |m, r| m + r[:quantity].to_i })
      end
  end

  def contracts
    # binding.pry
    ::Contract.distinct.joins(:reservations)
      .where(reservations: { order_id: record.id })
  end

end

class Borrow::InventoryPool < ApplicationRecordPresenter
  delegate_to_record :name, :shortname, :logo_url, :is_active
end

class Borrow::Model < ApplicationRecordPresenter
  delegate_to_record \
    :product, :manufacturer, :description, :is_package, :technical_detail

  def active
    @user.models.borrowable.exists?(record.id)
  end

  def url
    borrow_model_path record
  end
end
