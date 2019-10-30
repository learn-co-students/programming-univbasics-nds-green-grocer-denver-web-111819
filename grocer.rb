require 'pry'

def find_item_by_name_in_collection(name, collection)
  index = 0 
  while index < collection.length do 
    hash = collection[index]
    if name == hash[:item]
      return hash
    end
    index += 1
  end
end

def consolidate_cart(cart)
  array = []
  i = 0 
  while i < cart.length do 
    item_name = find_item_by_name_in_collection(cart[i][:item], array)
    if item_name
      item_name[:count] += 1
    else item_name = {
      :item => cart[i][:item],
      :price => cart[i][:price],
      :clearance => cart[i][:clearance],
      :count => 1
    }
    array << item_name
    end
    i += 1
  end
  array
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0 
  while i < coupons.length do
    item_name = find_item_by_name_in_collection(coupons[i][:item], cart)
    coupon_item = "#{coupons[i][:item]} W/COUPON"
    cart_with_coupon = find_item_by_name_in_collection(coupon_item, cart)
    if item_name && item_name[:count] >= coupons[i][:num]
      if cart_with_coupon
        cart_with_coupon[:count] += coupons[i][:num]
        item_name[:count] -= coupons[i][:num]
      else cart_with_coupon = {
        :item => coupon_item,
        :price => coupons[i][:cost] / coupons[i][:num],
        :count => coupons[i][:num],
        :clearance => item_name[:clearance]
      }
      cart << cart_with_coupon
      item_name[:count] -= coupons[i][:num]
      end
    end
    i += 1
  end
  cart
end

def apply_clearance(cart)
  i = 0 
  while i < cart.length do 
    if cart[i][:clearance] == true 
      cart[i][:price] -= (0.2 * cart[i][:price])
    end
    i += 1
  end
  cart
end

def checkout(cart, coupons)
  all_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(all_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  i = 0 
  total = 0 
  while i < clearance_cart.length do 
    total += (clearance_cart[i][:price] * clearance_cart[i][:count])
    i += 1
  end
  if total > 100
    total -= (total * 0.1)
  end
  total
end
