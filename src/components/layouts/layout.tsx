import React, { ReactNode } from 'react';
import Navbars from '../navbars/navbars';
import Footer from '../footer/footer';

interface LayoutProps {
  children: ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
  return (
    <>
      <Navbars />
        {children}
      <Footer />
    </>
  )
};

export default Layout;