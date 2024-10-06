# frozen_string_literal: true

# HashMap is a custom implementation of a hash map data structure.
# It provides an associative array, mapping keys to values.
# This implementation handles collisions using separate chaining
# and automatically resizes the underlying storage when the load factor exceeds 0.75.
class HashMap
  attr_reader :length, :bucket, :capacity

  # Load factor threshold for resizing the HashMap.
  LOAD_FACTOR = 0.75

  def initialize
    @capacity = 16
    @bucket = Array.new(capacity) { [] }
    @length = 0
  end

  # Associates the specified value with the specified key in the HashMap.
  # If the key already exists, the value is updated.
  # If the load factor exceeds the threshold, the HashMap is resized.
  #
  # @param key [String] The key to be associated with the value.
  # @param value [Object] The value to be associated with the key.
  def set(key, value)
    if length >= capacity * LOAD_FACTOR
      remap
      set(key, value)
    else
      index = get_bucket_index(key)

      bucket[index].each do |pair|
        next unless pair[0] == key

        return pair[1] = value
      end

      bucket[index] << [key, value]
      @length += 1
    end
  end

  # Retrieves the value associated with the specified key.
  #
  # @param key [String] The key whose associated value is to be retrieved.
  # @return [Object, nil] The value associated with the key, or nil if not found.
  def get(key)
    index = get_bucket_index(key)

    bucket[index].each do |pair|
      next unless pair[0] == key

      return pair[1]
    end
    nil
  end

  # Checks whether a key exists in the HashMap.
  #
  # @param key [String] The key to check for existence.
  # @return [Boolean] True if the key exists, false otherwise.
  def has?(key)
    index = get_bucket_index(key)

    bucket[index].each do |pair|
      next unless pair[0] == key

      return true
    end
    false
  end

  # Removes the entry with the specified key from the HashMap.
  #
  # @param key [String] The key of the entry to be removed.
  # @return [Object, nil] The value of the removed entry, or nil if the key was not found.
  def remove(key)
    index = get_bucket_index(key)
    return nil if bucket[index].empty? # Early return if bucket is empty

    bucket[index].each_with_index do |pair, idx|
      if pair[0] == key
        @length -= 1
        return bucket[index].delete_at(idx) # Return the removed value
      end
    end
    nil # Return nil if key not found
  end

  # Clears all entries from the HashMap, resetting it to its initial state.
  def clear
    @bucket = Array.new(capacity) { [] }
    @length = 0
  end

  # Returns an array containing all keys in the HashMap.
  #
  # @return [Array<String>] An array of all keys in the HashMap.
  def keys
    keys = []
    bucket.each do |entries|
      entries.each do |pair|
        keys << pair[0]
      end
    end
    keys
  end

  # Returns an array containing all values in the HashMap.
  #
  # @return [Array<Object>] An array of all values in the HashMap.
  def values
    values = []
    bucket.each do |entries|
      entries.each do |pair|
        values << pair[1]
      end
    end
    values
  end

  # Returns an array containing all key-value pairs in the HashMap as arrays.
  #
  # @return [Array<Array>] An array of all key-value pairs in the HashMap.
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

  # Calculates the bucket index for a given key.
  #
  # @param key [String] The key for which to calculate the index.
  # @return [Integer] The index of the bucket for the key.
  def get_bucket_index(key)
    hash(key) % capacity
  end

  # Computes the hash code for a given key.
  #
  # @param key [String] The key to be hashed.
  # @return [Integer] The computed hash code.
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  # Resizes the HashMap by doubling its capacity and rehashing all entries.
  def remap
    @capacity *= 2
    remapped_bucket = Array.new(capacity) { [] }
    entries.each do |entry|
      index = get_bucket_index(entry[0])

      remapped_bucket[index] << entry
    end
    @bucket = remapped_bucket
  end
end
