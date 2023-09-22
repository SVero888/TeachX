import { useEffect } from "react";
import { Routes, Route, BrowserRouter } from "react-router-dom";
import WebFont from 'webfontloader';
import Home from "./pages/Home";

function App() {
  useEffect(() => {
    WebFont.load({
      google: {
        families: ['Roboto']
      }
    });
  }, []);

  return (
    <div className="App">
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Home/>} />
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;