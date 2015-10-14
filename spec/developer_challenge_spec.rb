require 'developer_challenge'

describe APIHitter do
  it 'can run threaded workers' do
    tasks = 5.times.map { lambda { return 'done' } }
    results = []
    mutex = Mutex.new
    threads = 2.times.map { APIHitter.create_worker tasks, results, mutex }
    threads.each &:join
    expect(results).to eq(Array.new 5, 'done')
  end
end

describe MinimumPathSummer do
  it 'solves a single line' do
    new_sums = MinimumPathSummer.solve_line [2, 3, 4], [3, 4, 5, 6]
    expect(new_sums).to eq([5, 7, 9])
  end

  it 'catches some illegal triangles' do
    triangles = [[[3],
                  [4, 7, 2]],
                 [[3, 2],
                  [4, 2, 2]],
                 [[3],
                  [4, ' ']],
                 [[]],
                 nil]
    triangles.each do |triangle|
      expect {MinimumPathSummer.verify triangle}.to raise_error(RuntimeError)
    end
  end

  it 'parses triangles' do
    triangle = [[3],
                [4, 7],
                [2, 4, 1],
                [9, 9, 9, 1]]
    file = File.join File.dirname(__FILE__), 'fixtures', 'test1.txt'
    expect(MinimumPathSummer.parse_file file).to eq(triangle)
  end

  it 'solves a parsed triangle' do
    triangle = [[3],
                [4, 7],
                [2, 4, 1],
                [9, 9, 9, 1]]
    expect(MinimumPathSummer.solve(triangle)).to eq(12)
  end

  it 'solves a big challenge from file' do
    file = File.join File.dirname(__FILE__), 'fixtures', 'test2.txt'
    expect(MinimumPathSummer.from_file file).to eq(2768)
  end
end
