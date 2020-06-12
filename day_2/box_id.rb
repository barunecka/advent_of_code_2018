class BoxId
  def initialize(box_id)
    @box_id = box_id
  end

  attr_reader :box_id

  def contains_threes?
    threes = false

    box_id.each do |char|
      if box_id.count(char) == 3
        threes = true
      end
    end

    threes
  end

  def contains_twos?
    twos = false

    box_id.each do |char|
      if box_id.count(char) == 2
        twos = true
      end
    end

    twos
  end
end
