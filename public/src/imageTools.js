export const IMGURL = {
  getImg(min, max, w, h) {
    return "https://picsum.photos/"+w+"/"+h+"/";
    // return "https://picsum.photos/"+w+"/"+h+"/?image=" + Math.floor(Math.random()*(max-min+1)+min)
  }
};
