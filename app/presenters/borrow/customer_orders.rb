class Borrow::CustomerOrders < ApplicationPresenter

  # NOTE: shows historical data, potentially going far back in time.
  #       uses `unscoped`, e.g. to show InvPools even if not active anymore

  def initialize(user:, later_than_year: nil)
    @user = user
    defaults = build_defaults(user: user)
    start_time = Time.new(later_than_year || defaults[:start_time])
    end_time = Time.now
    @orders = user.orders
      .where(created_at: (start_time.utc..end_time.utc))
      .reorder(created_at: 'DESC')
  end

  def orders_by_year
    @orders.group_by { |o| o.created_at.year }.map do |year, orders|
      [year, orders.map { |r| Borrow::CustomerOrder.new(r) }]
    end.to_h
  end

  def inventory_pools_by_id
    # @orders.map(&:inventory_pool_id).uniq.map do |id|
    #   [id, Borrow::InventoryPool.new(::InventoryPool.unscoped.find_by(id: id))]
    # end.to_h
    ::InventoryPool.unscoped
      .distinct
      .joins('INNER JOIN orders ON orders.inventory_pool_id = inventory_pools.id')
      .where(orders: { id: @orders })
      .map do |p|
        [p.id, Borrow::InventoryPool.new(p)]
      end.to_h
  end

  def models_by_id
    # @orders.map(&:model_ids).flatten.uniq.map do |id|
    #   [id, Borrow::Model.new(::Model.unscoped.find_by(id: id), user: @user)]
    # end.to_h
    ::Model.distinct
      .joins(:reservations)
      .joins('INNER JOIN orders ON orders.id = reservations.order_id')
      .where(reservations: { order_id: @orders })
      .map do |m|
        [m.id, Borrow::Model.new(m, user: @user)]
      end.to_h
  end

  private

  def build_defaults(user:)
    last_order = user.orders.reorder(created_at: 'DESC').first
    {
      start_time: last_order ? last_order.created_at.year : Time.now.year
    }
  end

end

# # #

# dev stuff

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

# # #

class Borrow::CustomerOrder < ApplicationRecordPresenter
  delegate_to_record :inventory_pool_id, :state, :purpose

  def initialize(*args)
    super(*args)
    @reservations = record.reservations
  end

  def daterange
    {
      start: @reservations.minimum(:start_date).as_json,
      end: @reservations.maximum(:end_date).as_json
    }
  end

  def reservations
    partitions = [:start_date, :end_date]
    @reservations
      .group_by { |r| partitions.map { |k| r[k] } }
      .map do |dates, list|
        { start_date: dates[0], end_date: dates[1],
          model_id: list.first.model_id,
          quantity: list.reduce(0) { |m, r| m + r[:quantity].to_i } }
      end
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
