import Router from 'next/router';
import '../styles/index.css';
import { useState } from 'react';
import { CurrentUser } from '../services/current-user';
import { Api } from '../services/api';

/**
 * For some reason, Next does not support Typescript format for the root component
 */
function MafiApp({ Component, pageProps }) {

  const [isAuth, setIsAuth] = useState(false);

  function componentDidMount() {
    Api.init();
    Api.get('/me').then(r => {
      const pathname = window.location.pathname;
      if (pathname === '' || pathname === '/') {
        Router.push('/dashboard');
      }
    }).catch(e => {
      Router.push('/login');
    });
    window.addEventListener(CurrentUser.loggedInEvent, () => setIsAuth(true));
    window.addEventListener(CurrentUser.loggedOutEvent, () => setIsAuth(false));
  }

  function publicNav() {
    return (
      <nav className="bg-gray-800">
        <div className="flex items-center justify-center h-16">
          <h1 className="text-white text-2xl">MAFI</h1>
        </div>
      </nav>
    );
  }

  function privateNav() {
    return (
      <nav className="bg-gray-800">
        <div className="flex items-center justify-between h-16">
          <div className="flex items-center">
            <div className="flex-shrink-0">
              <h1>MAFI</h1>
            </div>
            <div className="md:block">
              <div className="ml-10 flex items-baseline space-x-4">
                <a href="#" className="bg-gray-900 text-white px-3 py-2 rounded-md text-sm font-medium">Dashboard</a>
              </div>
            </div>
          </div>
        </div>
      </nav>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      { isAuth ? privateNav() : publicNav() }
      <Component className="flex-grow" {...pageProps} />
    </div>
  )
}

export default MafiApp;
