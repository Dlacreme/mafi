import React, { useState } from 'react';

export enum UserRole {
  Admin = 'admin',
  User = 'user',
}

export class CurrentUser {

  public readonly id:string;
  public readonly name:string;
  public readonly role:UserRole;

  public static readonly loggedInEvent = 'logged-in';
  public static readonly loggedOutEvent = 'logged-out';
  private static instance:CurrentUser = undefined;

  constructor(id:string, name:string, role:UserRole) {
    this.id = id;
    this.name = name;
    this.role = role;
  }

  public static try_get():CurrentUser|undefined {
    return this.instance;
  }

  public static get():CurrentUser {
    return this.instance!;
  }

  public static set(user:any):CurrentUser {
    this.instance = new CurrentUser(user.id, `${user.first_name} ${user.last_name}`, user.role);
    window.dispatchEvent(new CustomEvent(this.loggedInEvent));
    return this.get();
  }

  public static logout(): void {
    delete this.instance;
    window.dispatchEvent(new CustomEvent(this.loggedOutEvent));
  }
}