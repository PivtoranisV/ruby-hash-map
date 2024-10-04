# frozen_string_literal: true

class HashMap
  attr_reader :length, :bucket, :capacity

  def initialize
    @capacity = 16
    @bucket = Array.new(capacity) { [] }
    @length = 0
  end

  def set(key, value)
    index = get_bucket_index(key)
    #  TODO grow buckets size

    bucket[index].each do |pair|
      next unless pair[0] == key

      return pair[1] = value
    end

    bucket[index] << [key, value]
    @length += 1
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

  def remove(key)
    index = get_bucket_index(key)
    return nil if bucket[index].empty? # Early return if bucket is empty

    index_to_be_removed = nil
    removed_value = nil

    bucket[index].each_with_index do |pair, idx|
      next unless pair[0] == key

      index_to_be_removed = idx
      removed_value = pair[1]
      break
    end

    return nil unless index_to_be_removed # Return nil if key not found

    bucket[index].delete_at(index_to_be_removed) # Remove the pair
    @length -= 1
    removed_value # Return the removed value
  end

  def clear
    @bucket = Array.new(capacity) { [] }
    @length = 0
  end

  def keys
    keys = []
    bucket.each do |entries|
      entries.each do |pair|
        keys << pair[0]
      end
    end
    keys
  end

  def values
    values = []
    bucket.each do |entries|
      entries.each do |pair|
        values << pair[1]
      end
    end
    values
  end

  def entries
    entry = []
    bucket.each do |entries|
      entries.each do |pair|
        entry << pair
      end
    end
    entry
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
