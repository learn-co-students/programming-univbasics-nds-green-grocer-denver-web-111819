require 'pry'

def find_item_by_name_in_collection(name, collection)
  
counter = 0 
while counter < collection.length
  if collection[counter][:item] == name
    return collection[counter]
  end
  counter += 1 
 end
end

def consolidate_cart(cart)
   
new_cart = []
counter = 0 

while counter < cart.length
  new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
  if new_cart_item != nil 
    new_cart_item[:count] += 1 
  else 
    new_cart_item = {
      :item => cart[counter][:item],
      :price => cart[counter][:price],
      :clearance => cart[counter][:clearance],
      :count => 1 
    }
    new_cart << new_cart_item
  end 
    
  counter += 1 
 end 
 new_cart
end 

  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.


def apply_coupons(cart, coupons)

counter = 0 

while counter < coupons.length
  cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
  couponed_item_name = "#{coupons[counter][:item]} W/COUPON"  
  cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else 
      cart_item_with_coupon = {
        :item => couponed_item_name,
        :price => coupons[counter][:cost] / coupons[counter][:num],
        :count => coupons[counter][:num], 
        :clearance => cart_item[:clearance]
      }  

      cart << cart_item_with_coupon 
      cart_item[:count] -= coupons[counter][:num]
      end
    end 
  counter += 1
end
cart
end


def apply_clearance(cart)
 counter = 0 
 
 while cart.length > counter do 
   current_product_details = cart[counter]
   is_current_item_on_clearance = current_product_details[:clearance]
   twenty_percent_off_item = (current_product_details[:price] * 0.8).round(2)
   if is_current_item_on_clearance 
     current_product_details[:price] = twenty_percent_off_item
    end
    counter +=1
 end 
 cart
 end



def checkout(cart, coupons)
  
 consolidated_cart = consolidate_cart(cart)
 couponeder_cart = apply_coupons(consolidated_cart, coupons)
 clearenced_cart = apply_clearance(couponeder_cart)
 
counter = 0 
cart_total = 0 

while clearenced_cart.length > counter do 
  cart_total += (clearenced_cart[counter][:count] * clearenced_cart[counter][:price])
counter += 1
end 
if cart_total > 100
  cart_total = (cart_total * 0.9).round(2)
  
end
cart_total
end
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

