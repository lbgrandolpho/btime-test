alias Backend.Repo
alias Backend.Model.{Task, Attachment}

create_task_with_attachments = fn task_attrs, attachments_attrs ->
  task = %Task{}
  |> Task.changeset(task_attrs)
  |> Repo.insert!()

  Enum.each(attachments_attrs, fn attachment_attrs ->
    %Attachment{}
    |> Attachment.changeset(Map.put(attachment_attrs, :task_id, task.id))
    |> Repo.insert!()
  end)
end

generate_data = fn num_tasks, num_attachments_per_task ->
  for i <- 1..num_tasks do
    task_attrs = %{
      name: "Task #{i}",
      description: "Description of Task #{i}",
      execution_date: ~D[2023-10-01] |> Date.add(i),
      location: "Location #{i}",
      priority: Enum.random(["High", "Critical", "Low"])
    }

    attachments_attrs = for j <- 1..num_attachments_per_task do
      %{
        url: "http://example.com/file#{i}_#{j}",
        identifier: "file#{i}_#{j}"
      }
    end

    %{task: task_attrs, attachments: attachments_attrs}
  end
end

num_tasks = 100
num_attachments_per_task = 5

tasks_with_attachments = generate_data.(num_tasks, num_attachments_per_task)

Enum.each(tasks_with_attachments, fn %{task: task_attrs, attachments: attachments_attrs} ->
  create_task_with_attachments.(task_attrs, attachments_attrs)
end)
