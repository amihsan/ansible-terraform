import React, { useEffect, useState } from "react";

// Access the API URL from environment variables
const apiUrl = window._env_.REACT_APP_API_URL;

function App() {
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    console.log("API URL:", apiUrl); // Debug log
    fetch(`${apiUrl}/`)
      .then((response) => {
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        return response.json();
      })
      .then((data) => {
        setMessage(data.message);
        setLoading(false);
      })
      .catch((err) => {
        console.error("Fetch error:", err); // Debug log
        setError("Failed to fetch message.");
        setLoading(false);
      });
  }, []);

  if (loading) {
    return <h2>Loading...</h2>;
  }

  if (error) {
    return <h2>{error}</h2>;
  }

  return (
    <div>
      <h1>{message}</h1>
      <h2>Ansible</h2>
      <h2>Terraform</h2>
    </div>
  );
}

export default App;

// import React from "react";

// // Access the API URL from environment variables
// const apiUrl = window._env_.REACT_APP_API_URL;

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <h1>Hello Ansible & Terraform</h1>
//         <p>API URL: {apiUrl}</p>
//       </header>
//     </div>
//   );
// }

// export default App;
