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
$SEMAPHORE = Mutex.new

# Global variables
$THREADS = []
$CLIENTS = []
$ORDER = 0
$OPERATOR = Operator.new

def execute(last_time_arrival)
	time_of_processing = sort_time_of_processing()
	people_in = People.new($ORDER, last_time_arrival, time_of_processing)
	puts "* Arrival new client #{$ORDER} (service: #{time_of_processing})\n"
	$CLIENTS << people_in
	$OPERATOR.push_queue(people_in, $SEMAPHORE)
end

system('clear')
puts "---- Operator bank ---- \n"
puts "Time now: #{Time.now} -> #{Time.now.to_i} Initial service\n\n"

20.times.map {
	last_time_arrival = sort_last_time_arrival()
	puts "(i): Next client in #{last_time_arrival}\n"
  	sleep(last_time_arrival)
  	$ORDER += 1
	$THREADS << Thread.new { 
    	execute(last_time_arrival)
	}
}

$THREADS.each(&:join)
resume_output($CLIENTS, $OPERATOR)
generate_xls($CLIENTS, $OPERATOR)