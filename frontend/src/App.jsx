import React from "react";
import Header from "./components/Header.jsx";
import Body from "./components/Body.jsx";
import Footer from "./components/Footer.jsx";
import "./App.css";
import "bootstrap/dist/css/bootstrap.min.css";

const App = () => {
  return (
    <div className="app-container">
      <Header />
      <Body />
      <Footer />
    </div>
  );
};

export default App;
