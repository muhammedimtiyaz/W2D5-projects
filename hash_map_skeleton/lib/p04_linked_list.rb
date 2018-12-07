require 'byebug'
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
include Enumerable

attr_accessor :head, :tail
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    if i.is_a?(Integer)
      each_with_index { |link, j| return link if i == j }
      nil
    else
      self.get(i)
    end
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    # self.[](key)
    # debugger
    self.each do |node|
      return node.val if node.key == key
    end

    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    self.tail.prev.next = new_node
    new_node.prev = self.tail.prev
    new_node.next = self.tail
    self.tail.prev = new_node

    new_node
  end

  def update(key, val)
    unless self.empty?
      # self[key].val = val
      self.each do |node|
        node.val = val if node.key == key
      end
    end
  end

  def remove(key)
    unless self.empty?
      self.each do |node|
        if node.key == key
          prev_node = node.prev
          next_node = node.next
          prev_node.next = next_node
          next_node.prev = prev_node
        end
      end
    end
  end

  def each(&prc)
    current_node = @head.next
    until current_node == @tail
      prc.call(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

end
