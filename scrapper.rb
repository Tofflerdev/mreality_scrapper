require 'watir'
require 'nokogiri'

browser = Watir::Browser.new :chrome

browser.goto 'https://proptx.midland.com.hk/utx/index.jsp?est_id=E000014413&lang=en'

browser.td(text: 'All Transaction').click

sleep 10

doc = Nokogiri::HTML(browser.html)
    t = doc.at_css('table#Tx_hist_table')
    table = []
    t.search('tr').each do |r|
        row = []
        r.search('td').each  do |cell|
           row << cell.text.strip.gsub("\t","").gsub("\n","")
        end
        table << row
    end

table.each do |r|
    p r.join(';')
end    
# browser.trs(class: 'bldg_NotCurr').each do |tr|
#     tr.a.click
#     browser.td(text: 'All Transaction').click
#     doc = Nokogiri::HTML(browser.html)
#     t = doc.at_css("table#Tx_hist_table")
#     puts t.inspect
# end

browser.quit