import { useEffect, useState } from 'react';
import './index.css';
import Home from './pages/home/home';
import { Route, Routes } from 'react-router-dom';
import About from './pages/about/about';
import Courses from './pages/courses/courses';
import Faqs from './pages/faqs/faqs';
import Resources from './pages/resources/resources';
import Terms from './pages/terms/terms';
import Contact from './pages/contact/contact';
import Policy from './pages/policy/policy';
function App() {
  return (
    <Routes>
      <Route path='/' element={<Home />} />
      <Route path='/cursos' element={<Courses />} />
      <Route path='/nosotros' element={<About />} />
      <Route path='/faqs' element={<Faqs />} />
      <Route path='/recursos' element={<Resources />} />
      <Route path='/terminos-y-condiciones' element={<Terms />} />
      <Route path='/contacto' element={<Contact />} />
      <Route path='/politicas' element={<Policy />} />
    </Routes>
  );
}

export default App;
