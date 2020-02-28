
def resume_output(clients, operator_1)
  clients.each { |pp| 
    puts "\n\n\t| order: #{pp.number}"
    puts "\t| time arrival: #{pp.time_arrival}"
    puts "\t| time of processing: #{pp.time_of_processing}"
    puts "\t| initial service: #{pp.initial_service}"
    puts "\t| end service: #{pp.end_service}"
    puts "\t| waiting time: #{pp.waiting_time}"
    puts "\t| total time: #{pp.total_time}"
    puts "\t| last time arrival: #{pp.last_time_arrival}"
  }

  puts "\n\n Operator resume:"
  puts "Time in idle: #{operator_1.time_in_idle}"
  puts "Time in service: #{operator_1.start_service - operator_1.time_in_idle}"
end