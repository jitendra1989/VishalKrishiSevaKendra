json.array! @products do |product|
  json.id product.id
  json.title product.name
  json.price product.price_with_taxes.round(2)
end