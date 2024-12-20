import React, { useState } from "react";
import { useQuery, gql } from "@apollo/client";
import styled from "styled-components";
import TaskCard from "./TaskCard";
import TaskModal from "./TaskModal";

const GET_TASKS = gql`
  query GetTasks(
    $name: String
    $description: String
    $executionDate: Date
    $priority: String
    $location: String
  ) {
    tasks(
      name: $name
      description: $description
      execution_date: $executionDate
      priority: $priority
      location: $location
    ) {
      id
      name
      execution_date
      location
      priority
      description
      attachments {
        id
        url
      }
    }
  }
`;

const Container = styled.div`
  margin: 30px;
`;

const FilterContainer = styled.div`
  display: flex;
  flex-direction: row;
  gap: 10px;
  margin-bottom: 20px;
`;

const CardsContainer = styled.div`
  display: flex;
  flex-wrap: wrap;
  justify-content: left;
  gap: 16px;
`;

const TaskList = () => {
  const [selectedTask, setSelectedTask] = useState(null);
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [executionDate, setExecutionDate] = useState("");
  const [priority, setPriority] = useState("");
  const [location, setLocation] = useState("");
  const [searchQuery, setSearchQuery] = useState({});
  const { loading, error, data } = useQuery(GET_TASKS, {
    variables: searchQuery,
  });

  const handleKeyDown = (event) => {
    if (event.key === "Enter") {
      setSearchQuery({
        name,
        description,
        executionDate: executionDate
          ? new Date(executionDate).toISOString().split("T")[0]
          : null,
        priority,
        location,
      });
    }
  };

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  return (
    <Container>
      <FilterContainer>
        <input
          type="text"
          placeholder="Pesquisar por nome..."
          value={name}
          onChange={(e) => setName(e.target.value)}
          onKeyDown={handleKeyDown}
        />
        <input
          type="text"
          placeholder="Pesquisar por descrição..."
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          onKeyDown={handleKeyDown}
        />
        <input
          type="text"
          placeholder="Prioridade"
          value={priority}
          onChange={(e) => setPriority(e.target.value)}
          onKeyDown={handleKeyDown}
        />
        <input
          type="text"
          placeholder="Local de execução"
          value={location}
          onChange={(e) => setLocation(e.target.value)}
          onKeyDown={handleKeyDown}
        />
        Data de Execução:
        <input
          type="date"
          placeholder="Data de execução"
          value={executionDate}
          onChange={(e) => setExecutionDate(e.target.value)}
          onKeyDown={handleKeyDown}
        />
      </FilterContainer>
      <CardsContainer>
        {data.tasks.map((task) => (
          <TaskCard key={task.id} task={task} onClick={setSelectedTask} />
        ))}
      </CardsContainer>
      {selectedTask && (
        <TaskModal task={selectedTask} onClose={() => setSelectedTask(null)} />
      )}
    </Container>
  );
};

export default TaskList;
