import Button from 'react-bootstrap/Button';
import Container from 'react-bootstrap/Container';
import Form from 'react-bootstrap/Form';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import "./footer.scss";
import Icon from '@mdi/react';
import { mdiMagnify } from '@mdi/js';
import { Col, InputGroup, Row } from 'react-bootstrap';
import { NavLink } from 'react-router-dom';
import { mdiInstagram } from '@mdi/js';
import { mdiTwitter } from '@mdi/js';
import { mdiLinkedin } from '@mdi/js';

export default function Footer() {
  const footerStyle: React.CSSProperties = {
    position: 'fixed',
    bottom: 0,
    width: '100%',
    backgroundColor: 'dark',
  };


  return (
    <Navbar expand="lg"  variant="dark" style={footerStyle}>
      <Container>
        <Navbar.Brand className='brand'><NavLink to={'/'}>TeachX</NavLink></Navbar.Brand>
        <Navbar.Toggle />
        <Navbar.Collapse>
          <Nav className="nav mx-auto"> 
            <NavLink to={'/terminos-y-condiciones'}>Términos y condiciones</NavLink>
            <NavLink to={'/contacto'}>Contacto</NavLink>
            <NavLink to={'/politicas'}>Políticas</NavLink>
          </Nav>
        </Navbar.Collapse>
        
        <div className="footer-right">
          <Navbar.Collapse>
            <Row>
              <Col xs={4} sm={2}>
                <Button variant="link">
                  <Icon path={mdiInstagram} size={1} className="footer-btn" />
                </Button>
              </Col>
              <Col xs={4} sm={2}>
                <Button variant="link">
                  <Icon path={mdiTwitter} size={1} className="footer-btn" />
                </Button>
              </Col>
              <Col xs={4} sm={2}>
                <Button variant="link">
                  <Icon path={mdiLinkedin} size={1} className="footer-btn" />
                </Button>
              </Col>
            </Row>
          </Navbar.Collapse>
        </div>
      </Container>
    </Navbar>
  )
}