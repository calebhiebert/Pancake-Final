import axios from 'axios';

export const BASEURL = 'https://wood.piikl.com';

export const GETIMG = (ident, ext) => { return BASEURL + '/uploads/' + ident + ext};

export const HTTP = axios.create({
  baseURL: BASEURL,
  withCredentials: true
});
