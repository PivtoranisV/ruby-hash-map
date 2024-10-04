# frozen_string_literal: true

class HashMap
  attr_accessor :bucket, :capacity

  def initialize
    @capacity = 16
    @bucket = Array.new(capacity) { [] }
  end

  def set(key, value)
    index = get_bucket_index(key)
    #  TODO grow buckets size

    bucket[index].each do |pair|
      next unless pair[0] == key

      return pair[1] = value
    end

    bucket[index] << [key, value]
  end

  def get(key)
    index = get_bucket_index(key)

    bucket[index].each do |pair|
      next unless pair[0] == key

      return pair[1]
    end
    nil
  end

  def has?(key)
    index = get_bucket_index(key)

    bucket[index].each do |pair|
      next unless pair[0] == key

      return true
    end
    false
  end

  private

  def get_bucket_index(key)
    hash(key) % capacity
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end
end
