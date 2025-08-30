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

  def encode(dna), do: do_encode(dna, <<>>)
  
  defp do_encode([], acc), do: acc
  
  defp do_encode([h | t], acc) do
    do_encode(t, <<acc::bitstring, encode_nucleotide(h)::4>>)
  end

  def decode(dna), do: do_decode(dna, [])

  defp do_decode(<<>>, acc), do: reverse(acc)
  
  defp do_decode(<<h::4, t::bitstring>>, acc) do
    do_decode(t, [decode_nucleotide(h) | acc])
  end

  defp reverse(list), do: do_reverse(list, [])
  
  defp do_reverse([], acc), do: acc
  
  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])
  
end
