import Router from "next/router";
import { Component } from "react";
import { CurrentUser } from "../services/current-user";

export class PrivateComponent extends Component {
  public componentDidMount(): void {
    return this.preventUnauthorizedUser();
  }

  protected preventUnauthorizedUser(): void {
    if (CurrentUser.try_get() === undefined) {
      Router.push('/login');
    }
  }
}