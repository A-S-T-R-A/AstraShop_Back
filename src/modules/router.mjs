export function RouterModule() {
  let path = "";
  let methods = {};

  return Object.freeze({
    getPath() {
      return path;
    },
    setPath(data) {
      path = data;
    },
    getMethods() {
      return methods;
    },
    setMethods(data) {
      methods = data;
    },
  });
}
