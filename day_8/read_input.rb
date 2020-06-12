class ReadInput
  def call
    File.read('input.txt').chomp!.split(" ").map(&:to_i)
  end
end
