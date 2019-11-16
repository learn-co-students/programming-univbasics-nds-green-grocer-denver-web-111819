require 'pp'

def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    if name == collection[i][:item]
      return collection[i]
    end
    i += 1 
  end
end

def consolidate_cart(cart)
  cart_items = []
  i = 0 
  while i < cart.length do 
    cart_item = find_item_by_name_in_collection(cart[i][:item], cart_items)
    if cart_item 
      cart_item[:count] += 1 
    else 
      cart[i][:count] = 1 
      cart_items.push(cart[i])
    end
    i += 1 
  end 
  cart_items
end 
  
def apply_coupons(cart, coupons)
  i = 0 
  while i < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    coupon_item = "#{coupons[i][:item]} W/COUPON"
    cart_item_w_coupon = find_item_by_name_in_collection(coupon_item, cart)
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_w_coupon
        cart_item_w_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      else cart_item_w_coupon = {
        :item => coupon_item,
        :count => coupons[i][:num],
        :price => coupons[i][:cost] / coupons[i][:num],
        :clearance => cart_item[:clearance]
      }
      cart.push(cart_item_w_coupon)
      cart_item[:count] -= coupons[i][:num]
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
  full_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(full_cart, coupons)
  clearance_cart = apply_clearance(couponed_cart)
  
  total = 0.0
  i = 0 
  while i < clearance_cart.length do 
    total += (clearance_cart[i][:price] * clearance_cart[i][:count])
  end
  i += 1 
  if total > 100 
    total -= (total * 0.1)
  end
  total
end
