class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashed = self.map do |el|
      el * 23 + 200 / 5
    end

    hashed.join.to_i
  end
end

class String
  def hash
    hashed = []
    self.each_char do |ch|
      hashed << ch.ord * 23 + 200 / 5
    end

    hashed.join.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = 0
    self.each do |key, value|
      hashed += (key.to_s.ord * 23 + 200 / 5 + value.ord)
    end

    hashed
  end

end
