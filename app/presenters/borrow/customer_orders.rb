class Borrow::CustomerOrders < ApplicationPresenter

  # NOTE: shows historical data, potentially going far back in time.
  #       uses `unscoped`, e.g. to show InvPools even if not active anymore

  DEFAULTS = {
    start_time: (Time.now.year - 100)
  }.freeze

  def initialize(user:, later_than_year: nil)
    @user = user
    start_time = Time.new(later_than_year || DEFAULTS[:start_time])
    @orders = user.orders
      .where(created_at: (start_time.utc..Time.now.utc))
      .reorder(created_at: 'DESC')
  end

  def orders_by_year
    @orders.group_by { |o| o.created_at.year }.map do |year, orders|
      [year, orders.map { |r| Borrow::CustomerOrder.new(r) }]
    end.to_h
  end

  def inventory_pools_by_id
    @orders.map(&:inventory_pool_id).uniq.map do |id|
      [id, Borrow::InventoryPool.new(::InventoryPool.unscoped.find_by(id: id))]
    end.to_h
  end

  def models_by_id
    @orders.map(&:model_ids).flatten.uniq.map do |id|
      [id, Borrow::Model.new(::Model.unscoped.find_by(id: id), user: @user)]
    end.to_h
  end

end

# # #

class Borrow::CustomerOrder < ApplicationRecordPresenter
  delegate_to_record \
    :inventory_pool_id, :state, :purpose,
    :model_ids, :option_ids

  def reservations
    record.reservations.as_json
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

# def hashify(id)
#   [id, yield].to_h
# end
