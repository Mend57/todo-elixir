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
    save(list)
    option = parse(Integer, IO.gets("\n1- Remove another task\n2- Return to menu\n"))
    case option do
      1 -> remove_task(list)
      2 -> main()
    end
  end


  def random_task(tasks) do
    [task] = Enum.take_random(tasks, 1)
    IO.puts("\n" <> task)

    option = parse(Integer, IO.gets("\n1- Get another random task\n2- Return to menu\n"))
    case option do
      1 -> random_task(tasks)
      2 -> main()
    end
  end


  def see_list(list) do
    IO.puts("")
    Enum.map(list, fn x -> IO.puts("- " <> x) end)
    IO.gets("\nPress 'enter' to return to menu: ")
    main()
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
      save(list)
      option = parse(Integer, IO.gets("\n1- Insert another task\n2- Return to menu\n"))
      case option do
        1 -> input_tasks(list, old_length, 1)
        2 -> main()
      end
    end
  end


  def save(tasks) do
    binary = :erlang.term_to_binary(tasks)
    File.write("todos", binary)
  end

  def todos_list do
    {_, binary_data} = File.read("todos")
    :erlang.binary_to_term(binary_data)
  end

  def check_option_menu(option) do
    if option == "1" || option == "2" || option == "3" || option == "4" || option == "5" do
      parse(Integer, option)
    else
      {IO.puts("Invalid response."), main()}
    end
  end


  def main do
    option = String.trim(IO.gets("\n1- See your list\n2- Add tasks to your list\n3- Remove a task from your list\n4- Choose a random task\n5- Sair\n")) |> check_option_menu()

    case option do
      1 -> todos_list() |> see_list()
      2 -> todos_list() |> num_inputs()
      3 -> todos_list() |> remove_task()
      4 -> todos_list() |> random_task()
      5 -> exit("")
    end
  end

  # mix run -e Todo.main

end
