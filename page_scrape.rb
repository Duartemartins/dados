require 'watir'
require 'CSV'

client = Selenium::WebDriver::Remote::Http::Default.new
@browser = Watir::Browser.new :chrome, http_client: client
position = @browser.window.move_to 1400, 0

@col_sep = '|'

def scrape(distrito, concelho, freguesia)
  distrito_list = @browser.select_lists(aria_label: 'Distrito/Região Autónoma')
  distrito_list[0].wait_until(&:present?).select(text: distrito)
  concelho_list = @browser.select_lists(aria_label: 'Concelho')
  concelho_list[0].wait_until(&:present?).select(text: concelho)
  freguesia_list = @browser.select_lists(aria_label: 'Freguesia')
  freguesia_list[0].wait_until(&:present?).select(text: freguesia)
  sleep 2
  rows = @browser.divs(class: 'chart-row')
  row_arr = []
  rows.each { |td| row_arr << td.text.to_s.gsub("\n", ' | ') }
  content = row_arr.reject(&:empty?).join(', ').gsub('votos, ', '| ')
  content = content.gsub(/\s+/, '').gsub('votos', '').split('|')
  CSV.open('corrections_table.csv', 'a+', col_sep: @col_sep,
                                          headers: %w[Distrito Concelho Freguesia Partido Voto(%) Votos]) do |csv|
    csv << [distrito.to_s, concelho.to_s, freguesia.to_s].push(*content)
  end
end

s = "Bragança|Bragança|Sendas
Bragança|Macedo de Cavaleiros|Peredo
Bragança|Mirandela|Avidagos, Navalho e Pereira
Évora|Montemor-o-Novo|Santiago do Escoural
Porto|Amarante|Aboadela, Sanche e Várzea
Santarém|Ferreira do Zêzere|Areias e Pias
Viana do Castelo|Valença|São Julião e Silva
Viana do Castelo|Viana do Castelo|Mujães
Açores|Ponta Delgada|Ponta Delgada (São Pedro)
Açores|Ponta Delgada|Relva
Açores|Ponta Delgada|Remédios
Açores|Ponta Delgada|Rosto do Cão (Livramento)
Açores|Ponta Delgada|Rosto do Cão (São Roque)
Açores|Ponta Delgada|Santa Bárbara
Açores|Ponta Delgada|Santa Clara
Açores|Ponta Delgada|Santo António
Açores|Ponta Delgada|São Vicente Ferreira
Açores|Ponta Delgada|Sete Cidades"

a = s.split(/\n+/)
a = a.map { |e| e.split('|') }
@browser.goto 'https://www.legislativas2022.mai.gov.pt/resultados/territorio-nacional'
@browser.link(text: 'Localidades').click
a.each do |e|
  scrape(e[0], e[1], e[2])
end
@browser.close
# distritos.each do |d|
#   distrito[0].wait_until(&:present?).select(text: d)
#   # puts browser.h1.text
#   # puts browser.h2.text
#   concelho = browser.select_lists(aria_label: 'Concelho')
#   sleep 1
#   a_two = []
#   concelho.each { |e| a_two << e.innertext }
#   concelhos = a_two[0].to_s.split(/\n+/).drop(1)
#   concelhos
#   sleep 2
#   concelhos.each do |c|
#     # puts browser.h1.text
#     # puts browser.h2.text
#     concelho[0].wait_until(&:present?).select(text: c)
#     freguesia = browser.select_lists(aria_label: 'Freguesia')
#     sleep 1
#     a = []
#     freguesia.each { |e| a << e.innertext }
#     freguesias = a[0].to_s.split(/\n+/).drop(1)
#     # freguesias.each {|f| puts "#{d}|#{c}|#{f}" }
#     sleep 1
#     freguesias.each do |f|
#       freguesia[0].wait_until(&:present?).select(text: f)
#       sleep 2
#       rows = browser.divs(class: 'chart-row')
#       row_arr = []
#       rows.each { |td| row_arr << td.text.to_s.gsub("\n", ' | ') }
#       content = row_arr.reject(&:empty?).join(', ').gsub('votos, ', '| ')
#       content = content.gsub(/\s+/, '').gsub('votos', '').split('|')
#       total = "#{d}|#{c}|#{f}|#{content}"
#       CSV.open('table.csv', 'a+', col_sep: col_sep,
#                                   headers: %w[Distrito Concelho Freguesia Partido Voto(%) Votos]) do |csv|
#         csv << [d.to_s, c.to_s, f.to_s].push(*content)
#       end
#       # File.open('table.csv', 'w') { |file| file.puts "#{d}|#{c}|#{f}|#{content}" }
#     end
#   end
# end
# browser.close

# distrito = distrito
# concelho = browser.select_lists(aria_label: "Concelho")
# concelho = concelho.drop(1)
# freguesia = browser.select_lists(aria_label: "Freguesia")
# freguesia = freguesia.drop(1)

# rows = browser.divs(class:"chart-row")
# row_arr = []
# rows.each {|td|  row_arr << td.text}
# row_arr.each {|e| e.to_s.gsub("\n", ", ")}
