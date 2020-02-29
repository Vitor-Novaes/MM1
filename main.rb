=begin
  Universidade Estadual do Ceará
  Nome: Vitor Monteiro de Novaes Menezes - 1426695
  Análise e desempenho de Software
=end

# Models
require File.expand_path 'lib/models/people'
require File.expand_path 'lib/models/operator'

# Helpers
require File.expand_path 'lib/helpers/sort_timer'
require File.expand_path 'lib/helpers/axlsx'
require File.expand_path 'lib/helpers/resume_output'

require 'thread'

# Global variables
$THREADS = []
$CLIENTS = []
$TEMP = []
$ORDER = 0
$BREAK = false
$TIME = 0
$OPERATOR = Operator.new

def arrival_clients(last_time_arrival)
	time_of_processing = sort_time_of_processing()
	puts "* Arrival new client #{$ORDER} (service: #{time_of_processing})\n"
	People.new($ORDER, last_time_arrival, time_of_processing)
end

system('clear')
puts "---- Operator bank ---- \n"
puts "Time now: #{Time.now} -> #{Time.now.to_i} Initial service\n\n"

$THREADS << Thread.new do
  3.times do
    puts 'Executeed'
    last_time_arrival = sort_last_time_arrival()
    puts "(i): Next client in #{last_time_arrival}\n"
    sleep(last_time_arrival)
    $ORDER += 1
    $CLIENTS << arrival_clients(last_time_arrival)
    $TEMP << $CLIENTS.last
  end
  $CLIENTS.each { |c| $TIME += c.time_of_processing.to_i }
  sleep($TIME)
  $BREAK = true;
end

$THREADS << Thread.new do  
  loop do
    sleep(1)
    if !$TEMP.empty?
      temp = $TEMP.pop
      $OPERATOR.push_queue(temp)
    end
    break if $BREAK
  end
end

$THREADS.each(&:join)
resume_output($CLIENTS, $OPERATOR)
generate_xls($CLIENTS, $OPERATOR)