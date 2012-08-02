module Availability
  module InventoryPool

    def overbooking_availabilities
      # TODO get multiple cached key: Rails.cache.fetch("/model/#{.*}/inventory_pool/#{id}/changes")

      models.collect do |model|
        a = model.availability_in(self)
        a if a.changes.any? {|k, c| c.quantities.any? {|g, q| q.in_quantity < 0 } }
      end.compact
    end
   
  end
end
