import React from "react";
import styled from "styled-components";

const Modal = styled.div`
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: white;
  padding: 32px;
  border: 1px solid #ccc;
  z-index: 1000;
`;

const Overlay = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  z-index: 999;
`;

const TaskModal = ({ task, onClose }) => (
  <>
    <Overlay onClick={onClose} />
    <Modal>
      <h2>{task.name}</h2>
      <p>Data: {task.execution_date}</p>
      <p>Local: {task.location}</p>
      <p>Prioridade: {task.priority}</p>
      <p>Descrição: {task.description}</p>
      <h3>Anexos:</h3>
      <ul>
        {task.attachments.map((attachment) => (
          <li key={attachment.id}>
            <a href={attachment.url} target="_blank" rel="noopener noreferrer">
              {attachment.url}
            </a>
          </li>
        ))}
      </ul>
      <button onClick={onClose}>Fechar</button>
    </Modal>
  </>
);

export default TaskModal;
