require 'pp'

def find_item_by_name_in_collection(name, collection)
  collection.each do |item|
    if name == item[:item]
      return item
    end
  end
  nil
end

def consolidate_cart(cart)
  new_array = []
  cart.each do |item|
    item_found = false
    new_array.each do |new_item|
      if item[:item] == new_item[:item]
        new_item[:count] += 1 
        item_found = true 
      end 
    end
    if !item_found 
      new_array.push(item.merge({:count => 1}))
    end
  end
  new_array
end

def apply_coupons(cart, coupons)
  #loop ONLY through original array
  cart_length = cart.length
  for i in 0..cart_length
  
    # get the cart item at the 'i' index
    item = cart[i]
    
    # loop through each coupon
    coupons.each do |coupon|
      
      # if the cart item is the same as the coupon item
      if item[:item] == coupon[:item] && item[:count] >= coupon[:num]
        
        # attempt to select the discounted item from the cart
        discounted_item = cart.select{|x| x[:item] == "#{item[:item]} W/COUPON"}[0]
        
        # if we found an item with coupon
        if discounted_item != nil
          # then update that item's count by adding the coupon num
          discounted_item[:count] += coupon[:num]
        else
          # create a copy of the original item
          discounted_item = item.clone()
          
          # update the name so it's 'original item W/COUPON'
          discounted_item[:item] = "#{discounted_item[:item]} W/COUPON"
          
          # set the price to the coupon cost divided by the num covered by the coupon
          discounted_item[:price] = coupon[:cost] / coupon[:num]
          
          # initialize the coupon item's count to the num of the coupon
          discounted_item[:count] = coupon[:num]
          
          # add the coupon item to the cart
          cart.push(discounted_item)
        end
        item[:count] -= coupon[:num]
      end
    end
  end
  # return the cart (Holy Jebus)
  cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance] == true
     item[:price] = (item[:price] * 0.8).round(2)
    end
  end  
end

def checkout(cart, coupons)
  sum = 0 
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  apply_clearance(consolidated_cart_with_coupons)
  consolidated_cart_with_coupons.each do |item|
    sum += item[:price] * item[:count] 
  end 
  if sum > 100
    sum = (sum * 0.9).round(2)
  end
  sum
end
