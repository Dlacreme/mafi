import { Component, ReactNode } from 'react'

class Landing extends Component {
  public render(): ReactNode {
    return (
      <div id="index" className="flex-grow flex justify-center align-center">
        <div className="w-2/3 m-auto p-10 bg-white shadow overflow-hidden sm:rounded-lg">
          We are getting you there...
        </div>
      </div>
    )
  }
}

export default Landing;