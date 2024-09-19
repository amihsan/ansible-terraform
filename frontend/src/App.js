import React, { useEffect, useState } from "react";

function App() {
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const apiUrl = window.REACT_APP_API_URL;
    console.log("API URL:", apiUrl); // For debugging
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
