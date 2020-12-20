import { ReactNode } from "react";
import { PrivateComponent } from "../core/private-component";

class Login extends PrivateComponent {
  public render(): ReactNode {
    return (
      <div id="index" className="flex-grow flex justify-center align-center">
        <div className="w-2/3 m-auto p-10 bg-white shadow overflow-hidden sm:rounded-lg">
          Login form
        </div>
      </div>
    )
  }

}

export default Login;