import React from "react";

// Access the API URL from environment variables
const apiUrl = window._env_.REACT_APP_API_URL;

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>Hello Ansible & Terraform</h1>
        <p>API URL: {apiUrl}</p>
      </header>
    </div>
  );
}

export default App;
