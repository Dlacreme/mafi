import Router from "next/router";
import { Component } from "react";
import { CurrentUser } from "../services/current-user";

export interface None {}

export class PrivateComponent<P, S> extends Component<P, S> {
  public componentDidMount(): void {
    return this.preventUnauthorizedUser();
  }

  protected preventUnauthorizedUser(): void {
    if (CurrentUser.try_get() === undefined) {
      Router.push('/login');
    }
  }
}