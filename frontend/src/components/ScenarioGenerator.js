import React from "react";

const ScenarioGenerator = ({ users, observations, history }) => {
  return (
    <div className="details-container">
      <div className="section">
        <strong>Users</strong>: <b>{users.join(", ")}</b>
      </div>
      <div className="section">
        <strong>Observation:</strong>
        <ul style={{ listStyleType: "none" }}>
          {observations.map((observation, index) => (
            <li key={index}>
              <b>{index + 1}</b>. {observation}
            </li>
          ))}
        </ul>
      </div>

      <div className="section">
        <strong>History:</strong>
        {history.map((userHistory, index) => (
          <div key={index}>
            <p>
              <strong>{userHistory.user}</strong>'s previous history with:
            </p>
            <ul>
              {userHistory.details.map((detail, subIndex) => (
                <li key={subIndex}>{detail}</li>
              ))}
            </ul>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ScenarioGenerator;
