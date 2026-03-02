
class Hash
  def to_s
    values = self.map do
      value1 = _1
      value1 = "'#{_1}'" if _1.is_a? String
      value2 = _2
      value2 = "'#{_2}'" if _2.is_a? String
      "'#{value1}': #{value2}"
    end
    "{ #{values.join(", ")} }"
  end
end
