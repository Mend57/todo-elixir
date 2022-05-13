defmodule Todo do

  def add1 num do
    num + 1
  end

  def mult5 num do
    num * 5
  end

  def add1thenmult5 do
    mult5(add1(5))
  end

end
