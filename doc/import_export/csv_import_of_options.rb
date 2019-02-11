ip = InventoryPool.find(169)
log = File.open('/tmp/optionen.log', 'a+')

CSV.open('/tmp/optionen.csv', 'r', { col_sep: 'undefined', quote_char: '"', headers: true })
  .each do |csv|
  csv['price'] ? price = BigDecimal.new(csv['price']) : price = 0.0

  option =
    ip.options.find_or_create_by(
      inventory_code: csv['inventory_code'], product: csv['model_name'], price: price
    )
  if option
    log.puts "Success: #{csv['inventory_code']}"
  else
    log.puts "Error: #{csv['inventory_code']}: #{option.errors.full_messages}"
  end
end

log.close
