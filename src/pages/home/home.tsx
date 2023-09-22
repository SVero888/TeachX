import { Button, Col, Row } from "react-bootstrap";
import Layout from "../../components/layouts/layout";
import Nav from "../../components/navbars/navbars";
import "./home.scss";

export default function Home() {
  return (
    <Layout>
      <div className="hero">
        <h1>Aprende más con TeachX desde hoy</h1>
        <p>Donde aprender sobre blockchain, criptomonedas y la web3 es simple, fácil y gratis. Desde tú pais. Inicia tu formación profesional hacia la web3.</p>
        <div className="cta">
          <Button variant="link" className="gradient-btn">Inicia hoy mismo</Button>
          <Button variant="link">Ver más</Button>
        </div>
      </div>
    </Layout>
  )
}