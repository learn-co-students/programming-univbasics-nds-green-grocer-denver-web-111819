def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  while index < collection.length do
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  updated_cart = []
  index = 0
  while index < cart.length do
    item_name = cart[index][:item]
    if find_item_by_name_in_collection(item_name, updated_cart)
      updated_cart_index = 0
      while updated_cart_index < updated_cart.length do
        if updated_cart[updated_cart_index][:item] == item_name
          updated_cart[updated_cart_index][:count] += 1
        end
        updated_cart_index += 1
      end
    else
      updated_cart << cart[index]
      updated_cart[-1][:count] = 1
    end
    index += 1
  end
  updated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  #while index < cart.length do
    #item_name = cart[index][:item]
    #coupon_hash = find_item_by_name_in_collection(item_name, coupons)
    #if find_item_by_name_in_collection(item_name, coupons) && cart[index][:count] > coupon_hash[:num]
      #if there's a coupon and more than the required items
      #cart[index][:count] -= coupon_hash[:num]
    #end
    #if find_item_by_name_in_collection(item_name, coupons) && cart[index][:count] == coupon_hash[:num]
      #if there's a coupon and exactly the required items
      #cart[index][:item] = "#{item_name} W/COUPON"
      #new_price = coupon_hash[:cost]/coupon_hash[:num]
      #cart[index][:price] = new_price

    #end
  #end

end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < cart.length do
    if cart[index][:clearance] do
      cart[index][price] *= 0.8
    end
    index += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
