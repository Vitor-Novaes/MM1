class Operator
	attr_accessor :queue, :in_service, :time_in_hidle, :hidle

	def initialize
    @start_service = Time.now
    @hidle = Time.now
    @time_in_hidle = 0
    @in_service = false
    @queue = Queue.new
	end

  def push_queue(people)
    time_in_hidle += (Tim.now - hidle) if queue.empty? && !in_service
    time_arrival = people.created - self.start_service
    people.time_arrival = time_arrival
    self.queue << people
    initial_service() if answer_now?
  end
  
  def answer_now?
    return !in_service?
  end

  def initial_service
    people = self.queue.pop
    self.in_service = true
    time = Time.now - people.time_arrival
    people.waiting_time = Time.now - time
    people.initial_service = people.time_arrival + people.waiting_time
    people.end_service = people.initial_service + time_of_processing
    people.total_time = people.end_service - people.time_arrival
    sleep(people.time_of_processing)
    next_step()
  end

  def next_step
    self.in_service = false
    if self.queue.empty?
      self.hidle = Time.now
    else
      initial_service()
    end
  end
end