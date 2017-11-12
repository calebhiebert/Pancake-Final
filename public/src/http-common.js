import axios from 'axios';

export const BASEURL = 'http://localhost';

export const GETIMG = (ident, ext) => { return BASEURL + '/uploads/' + ident + ext};

export const HTTP = axios.create({
  baseURL: BASEURL,
  withCredentials: true
});
