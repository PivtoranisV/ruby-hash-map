# HashMap Implementation in Ruby

## Overview

This project is a custom implementation of a **Hash Map** in Ruby. It supports the basic operations of a hash map, such as setting key-value pairs, retrieving values, checking the existence of keys, and resizing the hash map when necessary. The implementation uses **separate chaining** to handle collisions, meaning that each bucket in the array holds a list of key-value pairs for entries that hash to the same index.

### Features

- **Dynamic resizing**: The hash map automatically resizes when the load factor exceeds a threshold (0.75), ensuring optimal performance as more key-value pairs are inserted.
- **Collision handling**: Collisions are managed via separate chaining, allowing multiple key-value pairs to exist in the same bucket.
- **Basic hash map operations**:
  - `set(key, value)`: Adds or updates a key-value pair.
  - `get(key)`: Retrieves the value associated with a key.
  - `remove(key)`: Removes a key-value pair by the key.
  - `has?(key)`: Checks if a key exists in the hash map.
  - `clear`: Clears all entries from the hash map.
  - `keys`: Returns all keys in the hash map.
  - `values`: Returns all values in the hash map.
  - `entries`: Returns all key-value pairs in the hash map.

## How It Works

The `HashMap` class implements a hash map using an internal array of "buckets," where each bucket contains a list of key-value pairs.

### Hashing

The `hash` method converts a key (a string) into a numeric hash code using a simple polynomial rolling hash function. This hash code is then reduced to a valid index in the bucket array using the modulo operation.

### Load Factor & Resizing

The **load factor** is the ratio of the number of key-value pairs to the size of the bucket array. If the load factor exceeds `0.75`, the array is **dynamically resized** to accommodate more entries, reducing the likelihood of collisions.

## Installation

1. Clone this repository

2. Navigate to the project directory:

   ```bash
   cd ruby-hash-map
   ```

3. Run the project using Ruby:

   ```bash
   ruby main.rb
   ```

## Usage

Here’s a quick example of how to use the HashMap class:

```ruby
# Create a new HashMap instance
hash_map = HashMap.new

# Add key-value pairs
hash_map.set("apple", 10)
hash_map.set("banana", 20)

# Retrieve a value
puts hash_map.get("apple") # Output: 10

# Check if a key exists
puts hash_map.has?("banana") # Output: true

# Remove a key-value pair
hash_map.remove("apple")

# Get all keys
puts hash_map.keys.inspect

# Get all values
puts hash_map.values.inspect

# Clear the hash map
hash_map.clear
```
