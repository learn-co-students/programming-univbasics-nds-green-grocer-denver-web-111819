def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  
  collection.each do |i|
    if i[:item] == name
      return i
    end
  end
  
  return nil
  
end

def consolidate_cart(cart)
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  #puts cart
  #sleep(1)
  puts "consolidating cart........."
  items = []
  found = false
  
  cart.each do |item|
    found = false
    itemname = item[:item]
    #puts itemname
    #if items.has_key?(itemname) then
    
    i = 0
    #puts items
    while i < items.length
      #puts "Looking..."
      
      if items[i][:item] == item[:item]
        #puts "found"
        items[i][:count]  = items[i][:count]+  1
        #puts items[i]
        i += 1 
        found = true
        break
      end 
      i += 1
      
    end
    if found == false then
    #puts "not found"
    item[:count] = 1
    items.push(item)
    #items[0]
    end
    
    #puts items.last
    
    #sleep(1)
  end
  
  #puts "All Items"
  #puts items.length
  #puts items
  #sleep(1)
  return items
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  puts "Coupons...."
  puts coupons
  c = 0
  
  puts "Cart......"
  puts cart
  i = 0
  
  item = {}
  
  while c < coupons.length do
    i = 0
    while i < cart.length do
      if cart[i][:item] == coupons[c][:item] && cart[i][:count] >= coupons[c][:num] then
        puts cart[i][:item] + " - Found matching coupons " + coupons[c][:item]
        
        
          item = []
          item = cart[i].clone
          
          item[:item] = item[:item] + " W/COUPON"
          
          #puts "Number of items in cart "
          #puts cart[i][:count] 
          #puts ""
          
          #puts "Number of items in cart eligble for Coupon"
          
          #puts  (cart[i][:count] % coupons[c][:num])
          #puts ""
          
          
          #puts "Applying Coupons........"
          #puts "number of items for coupons"
          #puts coupons[c][:num]
          #puts ""
          #puts "per item price...."
          item[:price] = coupons[c][:cost] / coupons[c][:num]
          #puts "per item price...."
          #uts item[:price]
          
          
          
          #puts "Coupon Cost per item "
          #puts coupons[c][:cost]
          #puts coupons[c][:num]
          #puts coupons[c][:cost] / coupons[c][:num]
          #puts item[:price]
          #puts ""
          
          
          
          
          
          
          #sleep(3)
          #puts "Item......"
          #puts item
          
          
          #puts cart[i][:count]
          #puts coupons[c][:num]
          
          cart[i][:count] = cart[i][:count] -  coupons[c][:num]
          item[:count] -= cart[i][:count]
          
          #puts cart[i][:count]
          #sleep(1)
        
        #while cart[i][:count] >= coupons[i][:num] do
          
        #end
        
        
        
        #coupons[i][:count] = coupons[i][:num]
        
        
        
        
        cart.push(item)
        
        #sleep(2)
      end
      i += 1
    end
    
    
    c += 1
  end
  #puts 'New Cart.........'
  #puts cart
  
  #sleep(1)
  
  return cart
  
  
  
  
  
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < cart.length do
    if cart[i][:clearance] == true then
      puts "CLEARANCE!!!!!!!!   " + cart[i][:item] 
      cart[i][:price] -=  cart[i][:price] * 0.2

      #puts cart[i][:count] 
    #sleep(2)
    end
    i += 1
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
  cart = consolidate_cart(cart)
  
  total = 0
  ptotal = 0
  i = 0
  
  while i < cart.length do
    ptotal += cart[i][:price] * cart[i][:count] 
    i += 1
  end
  puts "Subtotal"
  puts ptotal
  
  
  
  
  cart = apply_coupons(cart, coupons)
  ctotal = 0
  i = 0
  
  while i < cart.length do
    ctotal += cart[i][:price] * cart[i][:count] 
    i += 1
  end
  
  puts "After coupons"
  puts ctotal
  
  
  i = 0
  total = 0
  cart = apply_clearance(cart)
  while i < cart.length do
    total += cart[i][:price] * cart[i][:count] 
      
    i += 1
  end
  
  
  puts "Subtotal"
  puts total
  if total > 100 then
    puts "$Baller discount! (- 10%)"
    puts total * 0.1
    
    total -= total * 0.1
  end
    
  #puts cart
  puts total
  sleep(2)
  return  total
end
