require 'rails_helper'

describe 'Check user/orders for all users to see ' do

  User.all.each do |u|
    it "user_id: #{u.id}" do
      visit "/borrow/orders.html?fake_user=#{u.id}"
    end
  end

end
