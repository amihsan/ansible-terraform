import React, { useEffect, useState } from "react";
import styles from "./Body.module.css";
import DropdownModal from "./DropdownModal.jsx";
import EvaluationModal from "./EvaluationModal.jsx";
import DetailsModal from "./DetailsModal.jsx";
import { Tooltip } from "react-tooltip";
import Dropdown from "react-bootstrap/Dropdown";
import axios from "axios";

const Body = () => {
  const [selectedScenario, setSelectedScenario] = useState(null);
  const [showDetails, setShowDetails] = useState(false);
  const [showFullDetailsModal, setShowFullDetailsModal] = useState(false);
  const [showEvaluationResults, setShowEvaluationResults] = useState(false);
  const [evaluationResults, setEvaluationResults] = useState(null);
  const [scenarioDetails, setScenarioDetails] = useState(null);
  const [scenarios, setScenarios] = useState([]);
  const [showThreeButtons, setShowThreeButtons] = useState(false);

  // Access the API URL from environment variables
  const baseUrl = import.meta.env.VITE_API_URL || window._env_.VITE_API_URL;

  // console.log(baseUrl); // debug api url

  useEffect(() => {
    axios
      .get(`${baseUrl}/api/getAllScenarios`)
      .then((response) => {
        setScenarios(response.data);
      })
      .catch((error) => {
        console.error("Error fetching scenarios:", error);
      });
  }, [baseUrl]);

  useEffect(() => {
    // Fetch scenario data when selectedScenario changes
    if (selectedScenario) {
      axios
        .get(`${baseUrl}/api/getScenarioDetails/${selectedScenario}`)
        .then((response) => {
          setScenarioDetails(response.data);
          setShowDetails(true);
        })
        .catch((error) => {
          console.error("Error fetching scenario details:", error);
        });
    }
  }, [selectedScenario, baseUrl]);

  const handleScenarioChange = (eventKey) => {
    console.log("Selected Scenario:", eventKey);

    // Toggle details visibility if the same scenario is selected again
    if (eventKey === selectedScenario) {
      setShowDetails(!showDetails);
    } else {
      // Fetch scenario data when a new scenario is selected
      axios
        .get(`${baseUrl}/api/getScenarioDetails/${eventKey}`)
        .then((response) => {
          setScenarioDetails(response.data);
          // setShowEvaluationResults(false);
          setShowDetails(true);
        })
        .catch((error) => {
          console.error("Error fetching scenario details:", error);
        });
    }

    // Update the selected scenario
    setSelectedScenario(eventKey);
  };

  const handleStartEvaluation = () => {
    // Check if a scenario is selected
    if (selectedScenario) {
      // Make a request to start evaluation for the selected scenario
      axios
        .post(`${baseUrl}/api/startEvaluation`, {
          scenario: selectedScenario,
        })
        .then((response) => {
          console.log("Evaluation started:", response.data);
          setEvaluationResults(response.data);
          setShowDetails(false);
          setShowEvaluationResults(true);
        })
        .catch((error) => {
          console.error("Error starting evaluation:", error);
        });
    } else {
      console.error("No scenario selected for evaluation");
    }
  };

  const handleCloseModal = () => {
    setShowDetails(false);
    setShowFullDetailsModal(false);
    setShowEvaluationResults(false);

    setShowThreeButtons(false);
  };

  const handleFullDetailsClick = (e) => {
    setShowFullDetailsModal(true);
  };

  const handleShowDropdownModal = (showThreeButtons) => {
    setShowEvaluationResults(false);
    setShowDetails(true);
    setShowThreeButtons(showThreeButtons);
  };

  return (
    <main className={styles.main}>
      <div className={styles.textDiv}>
        <h2>
          TRAVOS: A Probabilistic Model to Evaluate Trust in the Redecentralized
          Web
        </h2>
        <div className={styles.howItWorks}>
          <p>How it Works:</p>
          <p>a) It calculates Direct Trust between two Web Applications</p>
          <p>
            b) If Direct Trust is not sufficient, then it calculates Reputation
            Trust.{" "}
            <span
              data-tip="see details"
              data-for="fullDetailsTooltip"
              className={`${styles.tooltipLink} ${styles.tooltipLinkTeal}`}
              onClick={handleFullDetailsClick}
            >
              (<strong>see more details</strong>)
            </span>
          </p>
        </div>
      </div>

      <div className={styles.dropdownDiv}>
        <p>
          Please select a Demo Scenario provided below to check the results.
        </p>
        <h2>Choose a Scenario</h2>
        <Dropdown onSelect={handleScenarioChange}>
          <Dropdown.Toggle variant="primary">
            {selectedScenario
              ? `Scenario ${selectedScenario}`
              : "Select a Scenario"}
          </Dropdown.Toggle>

          <Dropdown.Menu
            style={{
              backgroundColor: "#E8E8E8",
            }}
          >
            {scenarios.map((scenario, index) => (
              <Dropdown.Item
                key={index + 1}
                eventKey={index + 1}
                className={styles.dropdownItem}
              >
                {`Scenario ${index + 1}`}
              </Dropdown.Item>
            ))}
          </Dropdown.Menu>
        </Dropdown>
      </div>

      {showDetails && (
        <DropdownModal
          isOpen={showDetails}
          onClose={handleCloseModal}
          scenario={selectedScenario}
          details={scenarioDetails}
          onStartEvaluation={handleStartEvaluation}
          showThreeButtons={showThreeButtons}
          showDropdownModalThreeButtons={handleShowDropdownModal}
        />
      )}
      {showEvaluationResults && (
        <EvaluationModal
          isOpen={showEvaluationResults}
          onClose={handleCloseModal}
          scenario={selectedScenario}
          details={evaluationResults}
          onStartEvaluation={handleStartEvaluation}
          scenarioDetails={scenarioDetails}
          showDropdownModalThreeButtons={handleShowDropdownModal}
        />
      )}

      {showFullDetailsModal && (
        <DetailsModal
          isOpen={showFullDetailsModal}
          onClose={handleCloseModal}
          scenario="Full Details"
          details="Add your full details content here."
        />
      )}
      {/* React-tooltip configuration */}
      <Tooltip
        id="fullDetailsTooltip"
        place="bottom"
        effect="solid"
        className={styles.tooltipClass}
      >
        Click to see full details
      </Tooltip>
    </main>
  );
};

export default Body;
