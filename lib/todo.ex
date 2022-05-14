defmodule Todo do

  def parse(input, type) do
    {num, _} = type.parse(input)
    num
  end

  def contains(tasks, target) do
    Enum.member?(tasks, target)
  end

  def random_task(tasks) do
    [task] = Enum.take_random(tasks, 1)
    task
  end

  def todos_list do
    ['a', 'b', 'c', 'd', 'e']
  end

  def create_todos do
    num_tasks = IO.gets("Enter the number of tasks you want to add to your list: ") |> parse(Integer)
    task = todos_list() |> random_task()

    if [1,2,3] |> contains(num_tasks) do
      IO.puts(task)
    end
  end

  # mix run -e Todo.

end
