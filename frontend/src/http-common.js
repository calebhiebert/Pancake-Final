import axios from 'axios';

export const BASEURL = 'https://woodshopapi.piikl.com';

export const GETIMG = (ident) => { return BASEURL + '/images/' + ident};

export const HTTP = axios.create({
  baseURL: BASEURL,
  withCredentials: true
});
