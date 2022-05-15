defmodule Todo do

  def parse(type, input) do
    {num, _} = type.parse(input)
    num
  end


  def contains(list, target) do
    Enum.member?(list, target)
  end


  def remove_task(list) do
    IO.puts("")
    Enum.map(list, fn x -> IO.puts("- " <> x) end)
    task = IO.gets("\nWhich task do you want to remove?\n") |> String.trim()
    if contains(list, task) do
      new_list = List.delete(list, task)
      IO.puts("")
      Enum.map(new_list, fn x -> IO.puts("- " <> x) end)
      return_remove_task(new_list)
    else
      IO.puts("Task not found")
      return_remove_task(list)
    end
  end

  def return_remove_task(list) do
    option = parse(Integer, IO.gets("\n1- Remove another task\n2- Return to menu\n"))
    case option do
      1 -> remove_task(list)
      2 -> create_todos()
    end
  end


  def random_task(tasks) do
    [task] = Enum.take_random(tasks, 1)
    IO.puts("\n" <> task)

    option = parse(Integer, IO.gets("\n1- Get another random task\n2- Return to menu\n"))
    case option do
      1 -> random_task(tasks)
      2 -> create_todos()
    end
  end


  def todos_list do
    ["banana", "apple", "orange"]
  end


  def see_list(list) do
    IO.puts("")
    Enum.map(list, fn x -> IO.puts("- " <> x) end)
    IO.gets("\nPress 'enter' to return to menu: ")
    create_todos()
  end

  def num_inputs(list) do
    num = parse(Integer, IO.gets("\nEnter the number of tasks you want to add to your list: "))
    list |> input_tasks(length(list), num)
  end

  def input_tasks(list, old_length, num_tasks) do
    IO.puts("")
    Enum.map(list, fn x -> IO.puts("- " <> x) end)
    unless length(list) == old_length + num_tasks do
      task = IO.gets("\nEnter a task: ") |> String.trim()
      list = List.insert_at(list, -1, task)
      input_tasks(list, old_length, num_tasks)
    else
      option = parse(Integer, IO.gets("\n1- Insert another task\n2- Return to menu\n"))
      case option do
        1 -> num_inputs(list)
        2 -> create_todos()
      end
    end
  end

  def create_todos do
    option = parse(Integer, IO.gets("\n1- See your list\n2- Add tasks to your list\n3- Remove a task from your list\n4- Choose a random task\n5- \n6- Sair\n"))

    case option do
      1 -> todos_list() |> see_list()
      2 -> todos_list() |> num_inputs()
      3 -> todos_list() |> remove_task()
      4 -> todos_list() |> random_task()
      # 5 ->
      6 -> exit("")

    end
  end

  # mix run -e Todo.

end
