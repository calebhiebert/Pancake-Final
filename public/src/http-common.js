import axios from 'axios';

export const HTTP = axios.create({
  baseURL: 'http://192.168.1.110:3000',
  withCredentials: true
});
