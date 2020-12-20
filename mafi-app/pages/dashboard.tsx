import { ReactNode } from "react";
import { PrivateComponent } from "../core/private-component";

class Dashboard extends PrivateComponent {

  public render(): ReactNode {
    return (
      <div id="index" className="flex-grow flex justify-center align-center">
        <div className="w-2/3 m-auto p-10 bg-white shadow overflow-hidden sm:rounded-lg">
          Dashboard
        </div>
      </div>
    )
  }

}

export default Dashboard;