import Button from 'react-bootstrap/Button';
import Container from 'react-bootstrap/Container';
import Form from 'react-bootstrap/Form';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import "./navbars.scss";
import Icon from '@mdi/react';
import { mdiMagnify } from '@mdi/js';
import { InputGroup } from 'react-bootstrap';
import { NavLink } from 'react-router-dom';

export default function Navbars() {
  return (
    <Navbar expand="lg"  variant="dark">
      <Container>
        <Navbar.Brand className='brand'><NavLink to={'/'}>TeachX</NavLink></Navbar.Brand>
        <Navbar.Toggle />
        <Navbar.Collapse>
          <Nav className="nav mx-auto"> 
            <NavLink to={'/cursos'}>Cursos</NavLink>
            <NavLink to={'/nosotros'}>Nosotros</NavLink>
            <NavLink to={'/faqs'}>FAQs</NavLink>
            <NavLink to={'/recursos'}>Recursos</NavLink>
          </Nav>
        </Navbar.Collapse>
        
        <div className="navbar-right">
          <Navbar.Collapse>
            <InputGroup className="outlined-search-box">
              <Form.Control
                type="search"
                placeholder="Buscar"
                className="search-input"
                
              />
              <InputGroup.Text className='search-icon'>
                <Icon path={mdiMagnify} size={1} />
              </InputGroup.Text>
            </InputGroup>
          </Navbar.Collapse>
        </div>
      </Container>
    </Navbar>
  );
}
