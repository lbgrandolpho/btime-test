import React from "react";
import styled from "styled-components";

const Card = styled.div`
  border: 1px solid #ccc;
  padding: 16px;
  margin: 8px;
  cursor: pointer;
  width: 240px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  background-color: #fff;
`;

const TaskCard = ({ task, onClick }) => (
  <Card onClick={() => onClick(task)}>
    <h3>{task.name}</h3>
    <p>Data: {task.execution_date}</p>
    <p>Local: {task.location}</p>
    <p>Prioridade: {task.priority}</p>
  </Card>
);

export default TaskCard;
