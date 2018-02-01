class Borrow::CustomerOrders < ApplicationPresenter

  def initialize(user:)
    @user = user
    @orders = user.orders.reorder(created_at: 'DESC')
  end

  def orders_by_year
    @orders.group_by { |o| o.created_at.year }.map do |year, orders|
      [year, orders.map { |r| Borrow::CustomerOrder.new(r) }]
    end.to_h
  end

  def inventory_pools_by_id
    @orders.map(&:inventory_pool_id).uniq.map do |id|
      Borrow::InventoryPool.new(::InventoryPool.unscoped.find_by(id: id))
    end
  end

  def models_by_id
    @orders.map(&:model_ids).uniq.map do |id|
      Borrow::Model.new(::Model.unscoped.find_by(id: id))
    end
  end

end

# # #

class Borrow::CustomerOrder < ApplicationRecordPresenter
  delegate_to_record :inventory_pool_id, :state, :purpose, :model_ids, :option_ids
end

class Borrow::InventoryPool < ApplicationRecordPresenter
  delegate_to_record :name, :shortname, :logo_url, :is_active
end

class Borrow::Model < ApplicationRecordPresenter
  delegate_to_record \
    :product, :manufacturer, :description, :is_package, :technical_detail
end
