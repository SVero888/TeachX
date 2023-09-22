import Button from 'react-bootstrap/Button';
import Container from 'react-bootstrap/Container';
import Form from 'react-bootstrap/Form';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import NavDropdown from 'react-bootstrap/NavDropdown';
import "./navbars.scss";
import Icon from '@mdi/react';
import { mdiMagnify } from '@mdi/js';
import { InputGroup } from 'react-bootstrap';

export default function Navbars() {
  return (
    <Navbar expand="lg"  variant="dark">
      <Container>
        <Navbar.Brand>TeachX</Navbar.Brand>
        <Navbar.Toggle />
        <Navbar.Collapse>
          <Nav className="nav mx-auto"> 
            <Nav.Link href="#action1">Cursos</Nav.Link>
            <Nav.Link href="#action2">Nosotros</Nav.Link>
            <Nav.Link href="#action2">FAQs</Nav.Link>
            <Nav.Link href="#action2">Recursos</Nav.Link>
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
