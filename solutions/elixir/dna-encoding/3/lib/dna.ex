defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0
      ?A -> 1
      ?C -> 2
      ?G -> 4
      ?T -> 8
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0 -> ?\s
      1 -> ?A
      2 -> ?C
      4 -> ?G
      8 -> ?T
    end
  end
  
  def encode([]), do: <<>>
  
  def encode([h | t]) do
    <<encode_nucleotide(h)::4, encode(t)::bitstring>>
  end

  def decode(<<>>), do: []
  
  def decode(<<h::4, t::bitstring>>) do
    [decode_nucleotide(h) | decode(t)]
  end
  
end
