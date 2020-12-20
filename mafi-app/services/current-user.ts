import React, { useState } from 'react';

export class CurrentUser {

  public static readonly loggedInEvent = 'logged-in';
  public static readonly loggedOutEvent = 'logged-out';
  private static instance:CurrentUser = undefined;

  constructor() {
    console.log('current user created');
  }

  public static try_get():CurrentUser|undefined {
    return this.instance;
  }

  public static get():CurrentUser {
    return this.instance!;
  }

  public static set(user:any):CurrentUser {
    this.instance = new CurrentUser();
    window.dispatchEvent(new CustomEvent(this.loggedInEvent));
    return this.get();
  }

  public static logout(): void {
    delete this.instance;
    window.dispatchEvent(new CustomEvent(this.loggedOutEvent));
  }
}