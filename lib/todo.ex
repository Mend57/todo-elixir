defmodule Todo do

  def parse(type, input) do
    {num, _} = type.parse(input)
    num
  end

  def contains(tasks, target) do
    Enum.member?(tasks, target)
  end

  def random(tasks) do
    [task] = Enum.take_random(tasks, 1)
    IO.puts(task)
    IO.gets("Press 'enter' to return to menu:")
    create_todos()
  end

  # def show_list(list) do
  #   [head | tail] = list
  #   unless Enum.empty?(list) do
  #     IO.puts("- " <> list[head])
  #     show_list(list[tail])
  #   end
  #   create_todos()
  # end

  def todos_list do
    ["a", "b", "c"]
  end

  # def random_task do
  #   task = todos_list() |> random()
  #   IO.puts(task)
  #   create_todos()
  # end

  # def num_tasks() do
  #   num = parse(Integer, IO.gets("Enter the number of tasks you want to add to your list: "))
  #   old_length = Enum.count(todos_list())
  #   input_tasks(old_length, old_length, num)
  # end

  # def input_tasks(length, old_length, num) do
  #   unless length == old_length > num do
  #     task = IO.gets("Enter a task:")
  #     List.insert_at(todos_list(), -1, task)
  #   end
  #   create_todos()
  # end


  def create_todos do
    option = parse(Integer, IO.gets("1- Add a task to your list\n2- Choose a random task\n3- See your list\n4- Sair\n"))

    case option do
      # 1 -> num_tasks()
      2 -> todos_list() |> random()
      # 3 -> todos_list() |> show_list()
      4 -> exit("")
    end

  end

  # mix run -e Todo.

end
