class PuzzleInput
  def call
    File.readlines('input.txt').map do |id|
      id.split("")
    end
  end
end
