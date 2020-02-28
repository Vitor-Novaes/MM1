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
          "Chegada",
          "Tempo de atendimento",
          "Inicío do atendimento",
          "Tempo de espera",
          "Fim do atendimento",
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
      end
    end
    
    # File
    p.serialize('report.xlsx')
  end
end