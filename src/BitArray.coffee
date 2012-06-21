class BitArray
  ELEMENT_WIDTH: 24

  constructor: (size, default_value = 0) ->
    @size = size
    initialElements = Math.floor(size / @ELEMENT_WIDTH) + 1
    @field = []
    for i in [0...initialElements]
      @field[i] = 0
  
  # Set a bit (1/0)
  set: (position, value) ->
    if value == 1
      @field[Math.floor(position / @ELEMENT_WIDTH)] |= 1 << (position % @ELEMENT_WIDTH)
    else if (@field[Math.floor(position / @ELEMENT_WIDTH)]) & (1 << (position % @ELEMENT_WIDTH)) != 0
      @field[Math.floor(position / @ELEMENT_WIDTH)] ^= 1 << (position % @ELEMENT_WIDTH)

  get: (position) ->
    return if (@field[Math.floor(position / @ELEMENT_WIDTH)] & 1 << (position % @ELEMENT_WIDTH)) > 0  then 1 else 0
  
  each: (callback) ->
    i=0
    while i < @size
      callback @getValue(i), i
      i++

  # Returns the field as a string like "0101010100111100," etc.
  toString: ->
    c = @
    localField = @field.map (n) -> 
      val = n.toString(2)
      while val.length < c.ELEMENT_WIDTH
        val = '0' + val;
      val
    

    str = localField.reverse().join('')
    str.substr(str.length - c.size)
