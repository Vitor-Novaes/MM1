class Operator
  attr_accessor :queue, :time_in_service, :idle, :busy
  attr_reader :start_service

	def initialize
    @start_service = Time.now.to_i
    @idle = Time.now.to_i
    @time_in_service = 0
    @queue = Queue.new
    @busy = false
	end

  def push_queue(people, semaphore)
    time_arrival = (people.created - start_service) #ok
    people.time_arrival = time_arrival # ok
    if answer_now?()
      in_processing(people, semaphore)
    else
      queue << people
    end
  end

  def idle_operator_register(people)
    people.time_operator_idle = Time.now.to_i - idle
  end
  
  def answer_now?
    queue.empty? && !busy
  end

  def pop_queue
    queue.pop
  end

  def in_processing(people, semaphore)
    semaphore.synchronize do 
      idle_operator_register(people)
      busy = true
      people.waiting_time = Time.now.to_i - people.created.to_i
      people.initial_service = people.time_arrival + people.waiting_time
      people.end_service = people.initial_service + people.time_of_processing
      people.total_time = people.end_service - people.time_arrival
      time_in_service = time_in_service.to_i + people.time_of_processing.to_i
  
      puts "Start service: client #{people.number} -> #{people.initial_service}\n"
      sleep(people.time_of_processing)
      puts "End service: client #{people.number} -> #{people.end_service}\n\n"
      busy = false
      idle = Time.now.to_i
      return 1
    end
    next_step(semaphore)
  end

  def next_step(semaphore)
    if answer_now?      
      idle = Time.now.to_i
    else
      people_in = pop_queue()
      in_processing(people_in, semaphore)
    end
  end
end