
# Generate xlsx output times
require 'axlsx'

def generate_xls(clients, operator)
  Axlsx::Package.new do |p|
    wb = p.workbook
    
    # styles
    wb.styles do |s|
      cell_header = s.add_style sz: 16, alignment: { horizontal: :center }
      cell_body = s.add_style sz: 14, alignment: { horizontal: :center }

      # Table/Values
      wb.add_worksheet(name: "Report") do |sheet|
        sheet.add_row [
          "Ordem",
          "Tempo entre chegadas",
          "Chegada no relógio",
          "Tempo de atendimento",
          "Inicío do atendimento no relógio",
          "Tempo de espera",
          "Fim do atendimento no relógio",
          "Tempo total no banco",
        ], style: [cell_header, cell_header, cell_header, cell_header, cell_header, cell_header, cell_header, cell_header]
        clients.each do |label|
          sheet.add_row [
            label.number,
            label.last_time_arrival,
            label.time_arrival,
            label.time_of_processing,
            label.initial_service,
            label.waiting_time,
            label.end_service,
            label.total_time,
          ], style: [cell_body, cell_body, cell_body, cell_body, cell_body, cell_body, cell_body, cell_body]
        end
        sheet.add_row ['Soma: ', "=SUM(B2:B11)", '-', "=SUM(D2:D11)", "-", "=SUM(F2:F11)", "-", "=SUM(H2:H11)"], escape_formulas: true 
        sheet.add_row ['Média: ', "=AVERAGE(B2:B11)", '-', "=AVERAGE(D2:D11)", "-", "=AVERAGE(F2:F11)", "-", "=AVERAGE(H2:H11)" ], escape_formulas: true
      end
    end
    
    # File
    p.serialize('report.xlsx')
  end
end