// import React from "react";
// import styles from "./Footer.module.css";

// const Footer = () => {
//   return (
//     <footer className={styles.footer}>
//       <p>&copy; 2023 @ihsan</p>
//       {"Created for Master Thesis @TU Chemnitz"}
//     </footer>
//   );
// };

// export default Footer;

// src/components/Footer.jsx
import React from "react";
import styles from "./Footer.module.css";

const Footer = () => {
  const currentYear = new Date().getFullYear(); // Get the current year dynamically

  return (
    <footer className={styles.footer}>
      <p>&copy; {currentYear} @Ihsan. All rights reserved. </p>
      <p>Developed as part of the Master's Thesis @TU Chemnitz.</p>
    </footer>
  );
};

export default Footer;
