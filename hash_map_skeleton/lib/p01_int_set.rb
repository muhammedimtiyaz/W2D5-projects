class MaxIntSet
  attr_accessor :max, :store

  def initialize(max)
    @store = []
    @max = max
  end

  def insert(num)
    raise "Out of bounds" if num < 0 || num > self.max
    self.store << num
  end

  def remove(num)
    self.store.delete(num)
  end

  def include?(num)
    self.store.include?(num)
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    idx = num % 20
    self.store[idx] << num
  end

  def remove(num)
    idx = num % 20
    self.store[idx].delete(num)
  end

  def include?(num)
    self.store.any? { |array| array.include?(num) }
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    idx = num % num_buckets

    if !self.include?(num) && self.count < num_buckets
      self.store[idx] << num 
      @count += 1
    else
      self.resize!
    end
  end

  def remove(num)
    idx = num % num_buckets
    if self.include?(num)   
      self.store[idx].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self.store.any? { |array| array.include?(num) }
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = self.store
    self.count = 0
    self.store = Array.new(num_buckets * 2) { Array.new }

    old_store.flatten.each { |key| insert(key) }
    end
      
  end
end
