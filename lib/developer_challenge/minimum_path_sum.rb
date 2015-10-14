module MinimumPathSummer
  FILE_FIELD_SEPARATOR = ' '

  def self.verify(triangle)
    unless triangle.respond_to? 'each'
      raise "Invalid triangle - not a list."
    end
    unless triangle.flatten.length > 0
      raise "Invalid triangle - empty."
    end

    triangle.each.with_index do |line, i|
      unless line.respond_to? 'each'
        raise "Invalid triangle - line #{line} is not a list."
      end
      unless line.all? { |n| n.is_a? Numeric }
        raise "Invalid triangle - line #{line} contains values that are not integers or floats."
      end
      unless line.length == i + 1
        raise "Invalid triangle - line 1 should have 1 number, line 2 should have 2 numbers, etc."
      end
    end
  end

  # Process a line of the triangle. Given line
  # 2 3 4
  # with smallest path sums below it of
  # 3 4 5 6
  # returns new sums
  # 5 7 9
  def self.solve_line(line, sums)
    new_sums = []
    line.each.with_index do |number, i|
      new_sums.push number + [sums[i], sums[i + 1]].min
    end
    return new_sums
  end

  # Solve triangle by making it recursively smaller, from the bottom up
  # (no guaranteed tail recursion in ruby, so we'll iterate)
  def self.solve(triangle)
    sums = triangle[-1]
    triangle.reverse.drop(1).each do |line|
      sums = solve_line line, sums
    end
    return sums[0]
  end

  def self.parse_file(file)
    triangle = []
    File.open(file, "r") do |infile|
      while (line = infile.gets)
        nums = line.strip.split FILE_FIELD_SEPARATOR
        nums = nums.map { |n| n.to_f }
        triangle.push nums
      end
    end
    return triangle
  end

  def self.from_file(file)
    triangle = parse_file file
    verify triangle
    return solve triangle
  end
end
