
class Apply

  def self.evaluate(combination1, combination2)
    included = evaluate_included(combination1, combination2)
    in_position = evaluate_in_position(combination1, combination2)
    { included: included, in_position: in_position }
  end

  def self.evaluate_included(combination1, combination2)
    included = 0

    digit0 = combination2.value[0]
    digit1 = combination2.value[1]
    digit2 = combination2.value[2]

    included +=1 if combination1.value.include? digit0
    included +=1 if combination1.value.include? digit1
    included +=1 if combination1.value.include? digit2

    included
  end

  def self.evaluate_in_position(combination1, combination2)
    in_position = 0

    input0 = combination2.value[0]
    input1 = combination2.value[1]
    input2 = combination2.value[2]

    in_position += 1 if input0 == combination1.value[0]
    in_position += 1 if input1 == combination1.value[1]
    in_position += 1 if input2 == combination1.value[2]

    in_position
  end
end
