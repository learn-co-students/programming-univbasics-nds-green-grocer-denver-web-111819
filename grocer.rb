def find_item_by_name_in_collection(name, collection)
  collection.each{|x| x[:item] == name ? (return x) : nil} 
  nil
end

def consolidate_cart(cart)
  var = []
  new_arr = []
  var = cart.each{|items_array| items_array[:count] ? items_array[:count] += 1: items_array[:count] = 1}
  var.uniq
end 
   
def apply_coupons(cart, coupons)
  if coupons == []
    return cart
  end
  coupons.each do |x|
    item = x[:item]
    cart.each_with_index do |y, index|
      if item == y[:item] && y[:count] >= x[:num]
        pushHash = {:item => "#{item} W/COUPON", :price => x[:cost] / x[:num], :clearance => y[:clearance], :count => x[:num]}
        cart.push(pushHash)
        y[:count] -= x[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |x|
    if x[:clearance] == true
      x[:price] = x[:price] * 4 / 5
    end
  end
  cart
end

def checkout(cart, coupons)
  return_float = 0.0
  if cart.any?{|x| x[:count]}
    consolidated_cart = cart
  else
    consolidated_cart = consolidate_cart(cart)
  end
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  clearance_applied = apply_clearance(coupons_applied)
  clearance_applied.each{|x| return_float += x[:price] * x[:count]}
  if return_float > 100
    return_float = return_float * 9/10
  end
  return_float
end

