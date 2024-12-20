import React from "react";
import { ApolloProvider } from "@apollo/client";
import styled from "styled-components";
import client from "./apolloClient";
import TaskList from "./components/TaskList";

const Container = styled.div`
  background-color: #f0f2f5;
  min-height: 100vh;
  padding: 20px;
`;

const App = () => (
  <Container>
    <ApolloProvider client={client}>
      <div>
        <h1>Tasks</h1>
        <TaskList />
      </div>
    </ApolloProvider>
  </Container>
);

export default App;
