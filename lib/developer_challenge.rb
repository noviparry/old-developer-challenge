require 'developer_challenge/slowapi'
require 'developer_challenge/minimum_path_sum'

module DeveloperChallenge
  URL = 'http://slowapi.com/delay/0.3'

  def self.do_slowapi(hits, file)
    results = APIHitter.hit_repeatedly URL, hits
    File.write file, results.join("\n")
  end

  def self.do_minimum_path_sum(file)
    return MinimumPathSummer.from_file file
  end
end
