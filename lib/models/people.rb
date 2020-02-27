
class People
  attr_reader :number, :last_time_arrival, :time_of_processing, :created
  attr_accessor :time_arrival, :total_time, :initial_service, :end_service, :waiting_time

  def initialize number, last_time_arrival, time_of_processing
    @number = number
    @last_time_arrival = last_time_arrival # TEC
    @time_of_processing = time_of_processing # TS
    @time_arrival = nil # Tempo de chegada no relógio
    @waiting_time = nil #Tempo de espera
    @total_time = nil # Total de tempo no banco
    @created = Time.now.to_i # Tempo de chegada no banco
    @initial_service = nil # Tempo inicial do atendimento
    @end_service = nil # Tempo final do atendimento
  end
end