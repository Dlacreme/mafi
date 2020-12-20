export interface ApiResult<T> {
  message:string;
  error?:any;
  data?:T;
}

export interface AsyncApiResult<T> extends Promise<ApiResult<T>> {}

export class Api {
  private static baseUrl = 'http://localhost:3000';

  private static token = '';
  private static readonly tokenStorageKey = 'MAFI.AUTH.TOKEN';

  constructor() {}

  public static init(): void {
    try {
      const t = window.localStorage.getItem(this.tokenStorageKey);
      if (t) {
        this.setToken(t);
      }
    } catch {}
  }

  public static setToken(token:string): void {
    window.localStorage.setItem(this.tokenStorageKey, token);
    this.token = token;
  }

  public static logout(): void {
    window.localStorage.setItem(this.tokenStorageKey, '');
  }

  /**
   * Execute a GET query
   * @endpoint url endpoint. Base url should not be included
   */
  public static get<T>(endpoint:string):AsyncApiResult<T> {
    return this.query<T>(endpoint, 'GET');
  }

  /**
   * Execute a POST query
   * @endpoint url endpoint. Base url should not be included
   */
  public static post<T>(endpoint:string, payload:any):AsyncApiResult<T> {
    return this.query<T>(endpoint, 'POST', payload);
  }

  /**
   * Execute a PUT query
   * @endpoint url endpoint. Base url should not be included
   */
  public static put<T>(endpoint:string, payload:any):AsyncApiResult<T> {
    return this.query<T>(endpoint, 'PUT', payload);
  }

  /**
   * Execute a DELETE query
   * @endpoint url endpoint. Base url should not be included
   */
  public static delete<T>(endpoint:string):AsyncApiResult<T> {
    return this.query<T>(endpoint, 'DELETE');
  }

  private static query<T>(endpoint:string, method:'GET'|'POST'|'PUT'|'DELETE', payload?:any):Promise<ApiResult<T>> {
    return new Promise<ApiResult<T>>((onRes, onErr) => {
      const fetchOptions:any = {
        method: method,
      };
      if (payload) {
        fetchOptions.body = JSON.stringify(payload);
      }
      const headers = this.token ? {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${this.token}`,
      } : {
        'Content-Type': 'application/json',
      }
      window.fetch(`${this.baseUrl}${endpoint}`, {
        method: method,
        body: payload ? JSON.stringify(payload) : undefined,
        headers,
      }).then(res => {
        if (!res.ok) {
          onErr(`Fetch error: ${res.statusText}`);
          return;
        }
        onRes(res.json());
      }).catch(err => onErr(err));
    });
  }
}