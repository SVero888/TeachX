import { Route, Routes } from 'react-router-dom';
import './assets/styles/index.css'
import Home from './pages/home';
import Dashboard from './pages/dashboard';
import Minter from './pages/minter';
import Students from './pages/students';
import Courses from './pages/courses';
import Profile from './pages/profile';

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Home />}/>
      <Route path="/cursos" element={<Courses />}/>
      <Route path="/perfil" element={<Profile />}/>
      <Route path="/dashboard" element={<Dashboard />}/>
      <Route path="/dashboard/mintear" element={<Minter />}/>
      <Route path="/dashboard/alumnos" element={<Students />}/>
    </Routes>
  )
}