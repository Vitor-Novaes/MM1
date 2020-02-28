class Operator
  attr_accessor :queue, :in_service, :time_in_idle, :idle
  attr_reader :start_service

	def initialize
    @start_service = Time.now.to_i
    @idle = Time.now.to_i
    @time_in_idle = 0
    @in_service = false
    @queue = Queue.new
	end

  def push_queue(people)
    time_in_idle = time_in_idle.to_i + (Time.now.to_i - idle) if queue.empty? && !in_service
    time_arrival = (people.created - start_service)
    people.time_arrival = time_arrival
    puts "Time arrival client: #{people.time_arrival}"
    queue << people
    return initial_service() if answer_now?
    puts "Client in waiting\n\n"
  end
  
  def answer_now?
    return !in_service
  end

  def initial_service
    people = queue.pop
    in_service = true
    people.waiting_time = Time.now.to_i - people.created
    people.initial_service = people.time_arrival + people.waiting_time
    puts "Start service: client #{people.number} -> #{people.initial_service}\n"
    people.end_service = people.initial_service + people.time_of_processing
    people.total_time = people.end_service - people.time_arrival
    sleep(people.time_of_processing)
    puts "End service: client #{people.number} -> #{people.end_service}\n\n"
    next_step()
  end

  def next_step
    in_service = false
    if queue.empty?
      idle = Time.now.to_i
    else
      initial_service()
    end
  end
end