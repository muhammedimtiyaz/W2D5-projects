class HashSet
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    idx = key.hash % num_buckets

    if !self.include?(key) && self.count < num_buckets
      self.store[idx] << key
      @count += 1
    else
      resize!
    end
  end

  def remove(key)
    idx = key.hash % num_buckets
    if self.include?(key)   
      self.store[idx].delete(key)
      @count -= 1
    end
  end

  def include?(key)
    self.store.any? { |array| array.include?(key) }
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
