require 'thread'
require 'open-uri'

module APIHitter
  MAX_THREAD_COUNT = 8 # OPTIMISE
  RETRIES = 3
  WAIT = 1

  def self.hit(url)
    tries ||= RETRIES
    return URI.parse(url).read
  rescue OpenURI::HTTPError => error
    tries -= 1
    if tries > 0
      puts "Error hitting url #{url} - #{error.io.status}"
      puts "Retrying in #{WAIT}..."
      sleep WAIT
      retry
    else
      return error.io.status
    end
  end

  # A threaded worker that pops tasks off a list, executes them, and pushes results to a list.
  # REVIEW can't I pull this off a shelf?
  def self.create_worker(tasks, results, mutex)
    return Thread.new(tasks, results) do |tasks, results|
      while task = mutex.synchronize { tasks.pop }
        result = task.call
        mutex.synchronize { results.push result }
      end
    end
  end

  def self.hit_repeatedly(url, repeat)
    tasks = repeat.times.map { lambda { hit url } }
    responses = []
    mutex = Mutex.new
    threads = MAX_THREAD_COUNT.times.map { create_worker tasks, responses, mutex }
    threads.each &:join
    return responses
  end
end
