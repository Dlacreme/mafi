import Head from 'next/head'
import '../styles/index.css';
import { useState, useEffect } from 'react';
import Router from 'next/router';
import { Api } from '../services/api';
import { CurrentUser } from '../services/current-user';

/**
 * For some reason, Next does not support Typescript format for the root component
 */
function MafiApp({ Component, pageProps }) {

  const [isAuth, setIsAuth] = useState(false);

  useEffect(() => {
    Api.init();
    Api.get('/me').then(r => {
      CurrentUser.set(r.data);
      const pathname = window.location.pathname;
      if (pathname === '' || pathname === '/' || pathname.indexOf('login') >= 0) {
        Router.push('/dashboard');
      }
    }).catch(e => {
      Router.push('/login');
    });
    window.addEventListener(CurrentUser.loggedInEvent, () => setIsAuth(true));
    window.addEventListener(CurrentUser.loggedOutEvent, () => setIsAuth(false));
  })

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col">
      <Head>
        <title>Simply Mafi</title>
        <meta name="viewport" content="initial-scale=1.0, width=device-width" />
      </Head>
      { isAuth ? privateNav() : publicNav() }
      <Component className="flex-grow" {...pageProps} />
    </div>
  )

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
      <nav className="bg-gray-800 text-white">
        <div className="container mx-auto margin-auto flex items-center justify-between h-16">
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
}

export default MafiApp;
