import { ReactNode, Component } from "react";
import { Api } from "../services/api";
import Router from "next/router";
import { CurrentUser } from "../services/current-user";

interface Props {
  isCreate:boolean;
}

interface State {
  isCreate:boolean;
  email:string;
  password:string;
  error:string;
  loading:boolean;
}

class Login extends Component<Props, State> {

  constructor(props: Props) {
    super(props);
    this.state = {
      isCreate: props.isCreate || false,
      email: '',
      password: '',
      error: '',
      loading: false,
    }
  }

  private submit(ev:any): void {
    ev.preventDefault();
    this.setState({loading: false, error: ''});
    if (!this.state.email || !this.state.password) {
      return this.setState({error: 'Invalid fields'});
    }
    return this.state.isCreate ? this.doSignin(this.state.email, this.state.password)
      : this.doLogin(this.state.email, this.state.password);
  }

  private doSignin(email:string, password:string): void {
      this.setState({loading: true});
      Api.post('/signin', {
        email,
        password,
      }).then(r => {
        this.doLogin(email, password);
      }).catch(r => this.setState({error: 'Failed to create an account. Try again later'}));
  }

  private doLogin(email:string, password:string): void {
    this.setState({loading: true});
    Api.post('/login', {
      email,
      password,
    }).then(r => {
      Api.setToken((r.data as any).token as string);
      CurrentUser.set(r.data);
      Router.push('/dashboard');
    }).catch(r => this.setState({error: 'Failed to log in. Try again later'}));
  }

  public render(): ReactNode {
    return (
      <div id="index" className="flex-grow flex justify-center align-center">
        <div className="w-2/3 m-auto p-10 bg-white shadow overflow-hidden sm:rounded-lg">
        { this.state.isCreate ? this.signinHeader() : this.loginHeader() }
          <form className="mt-8 space-y-6" onSubmit={(ev) => this.submit(ev) }>
            <input type="hidden" name="remember" value="true" />
            <div className="rounded-md shadow-sm -space-y-px">
              <div>
                <label htmlFor="email-address" className="sr-only">Email address</label>
                <input id="email-address" name="email" type="email" required value={this.state.email} onChange={(ev) => this.setState({email: ev.target.value})}
                  className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm" placeholder="Email address" />
              </div>
              <div>
                <label htmlFor="password" className="sr-only">Password</label>
                <input id="password" name="password" type="password" required value={this.state.password} onChange={(ev) => this.setState({password: ev.target.value})}
                  className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm" placeholder="Password" />
              </div>
            </div>

            <div>
              <button type="submit" onClick={(ev) => this.submit(ev)}
                className="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                { this.state.isCreate ? 'Sign in' : 'Log in' }
              </button>
              { this.state.error ? <p>{this.state.error}</p> : '' }
            </div>
          </form>
        </div>
      </div>
    )
  }

  private loginHeader(): ReactNode {
    return (
      <div className="flex direction-row items-end">
        <div className="flex-grow">
          <h2>Connect to your account</h2>
        </div>
        <a href="#" onClick={() => this.setState({isCreate: true})}>... or create an account</a>
      </div>
    );
  }

  private signinHeader(): ReactNode {
    return (
      <div className="flex direction-row items-end">
        <div className="flex-grow">
          <h2>Create an account</h2>
        </div>
        <a href="#" onClick={() => this.setState({isCreate: false})}>... or connect to your account</a>
      </div>
    );
  }
}

export default Login;