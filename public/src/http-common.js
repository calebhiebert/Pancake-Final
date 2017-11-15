import axios from 'axios';

export const BASEURL = 'http://192.168.1.110:3000';

export const GETIMG = (ident, ext) => { return BASEURL + '/uploads/' + ident + ext};

export const HTTP = axios.create({
  baseURL: BASEURL,
  withCredentials: true
});
