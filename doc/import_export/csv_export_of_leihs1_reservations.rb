res = Reservation.find_ausgeliehene(1)
ueb = Reservation.find_ueberfaellige(1)

avz_res = []

res.each { |r| avz_res << r if r.geraetepark_id == 1 }

ueb.each { |r| avz_res << r if r.geraetepark_id == 1 }

csv_array = []
csv_array << ['inventarcode', 'modellbezeichnung', 'person', 'von', 'bis']

avz_res.each do |r|
  puts 'Trying reservation ' + r.id.to_s

  if r.pakets && r.pakets.count > 0
    puts '+++ Has packages'
    r.pakets.each do |p|
      p.gegenstands.each do |g|
        csv_array <<
          [
            'AVZ' + g.original_id.to_s,
            g.modellbezeichnung,
            r.user.name,
            r.startdatum.strftime('%d.%m.%y'),
            r.enddatum.strftime('%d.%m.%y')
          ]
      end
    end
  end
end

CSV.open(
  '/tmp/leihs1_reservationen.csv', 'w', { col_sep: ';', quote_char: '"', force_quotes: true }
) { |csv| csv_array.each { |i| csv << i } }
