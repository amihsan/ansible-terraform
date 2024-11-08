import React from "react";
import styles from "./DetailsModal.module.css";
import travos from "../image/flowchart.drawio.png";

const DetailsModal = ({
  isOpen,
  onClose,
  scenario,
  details,
  onStartEvaluation,
}) => {
  if (!isOpen) return null;

  return (
    <div className={styles.overlay} onClick={onClose}>
      <div className={styles.modal} onClick={(e) => e.stopPropagation()}>
        <h2 className={styles.header}>Working Principles of Travos Model</h2>
        <div className={styles.modalBody}>
          <div className={styles.detailsContainer}>
            <p>
              TRAVOS is a trust framework for Decentralized Web Applications.
              The model is based on the research work by Teacy et al. (
              <a
                href="https://rdcu.be/dt5yU"
                target="_blank"
                rel="noopener noreferrer"
              >
                see details
              </a>
              ). A Flowchart is provided below to give a simplify overview of
              Trust Evaluation Process in TRAVOS.
            </p>
            <div className={styles.image}>
              <img src={travos} alt="Travos Concept" />
            </div>

            <p>
              The flowchart demonstrates that evaluation starts after a message
              is received. Then it calculates experience value and after that
              confidence value. Next, a comparison is done with confidence
              threshold value to determine whether the opinion is necessary or
              not. If confidence value is greater than confidence threshold
              value then opinion is not necessary and experience value will act
              as final trust value. If the opinion is necessary it will then
              calculate weighted average opinion value collected from other
              participants. After that, the opinion value will be compared with
              experience value. If opinion value is greater than experience
              value then opinion value will act as final trust value.
            </p>
          </div>
        </div>
        <div className={styles.buttonContainer}>
          <button className={styles.closeButton} onClick={onClose}>
            Close
          </button>
        </div>
      </div>
    </div>
  );
};

export default DetailsModal;
