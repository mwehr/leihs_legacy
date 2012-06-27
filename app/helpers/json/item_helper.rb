module Json
  module ItemHelper

    def hash_for_item(item, with = nil)
      h = {
        id: item.id,
        inventory_code: item.inventory_code,
        type: item.class.to_s.underscore
      }
      
      if with ||= nil
        [:current_borrower, :current_return_date, :in_stock?, :is_broken, :is_incomplete, :price, :inventory_pool].each do |k|
          h[k] = item.send(k) if with[k]
        end
      
        if with[:location]
          h[:location] = (item.owner != item.inventory_pool) ? "#{item.inventory_pool.to_s}, #{item.location.to_s}" : item.location.to_s
        end
      
        if with[:model]
          h[:model] = hash_for item.model, with[:model]
        end
        
        if with[:children] and item.model.is_package? and not item.children.empty?
          h[:children] = hash_for item.children, with[:children]
        end
      end
      
      h
    end

  end
end
