import React from "react";
import styles from "./Footer.module.css";

const Footer = () => {
  return (
    <footer className={styles.footer}>
      <p>&copy; 2023 @ihsan</p>
      {"Created for Master Thesis @TU Chemnitz"}
    </footer>
  );
};

export default Footer;
