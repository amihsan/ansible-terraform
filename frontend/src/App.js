import React, { useEffect, useState } from "react";

function App() {
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetch(`${process.env.REACT_APP_API_URL}/`)
      .then((response) => {
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        return response.json(); // This line assumes the response is JSON
      })
      .then((data) => {
        setMessage(data.message);
        setLoading(false);
      })
      .catch((err) => {
        console.error(err);

        // Attempt to log the actual response in case it's HTML or something else
        fetch(`${process.env.REACT_APP_API_URL}/`)
          .then((response) => response.text()) // Get the response as text
          .then((text) => console.error("Response text:", text));

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
