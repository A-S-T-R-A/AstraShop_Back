export function openDatabase(model) {
  return Object.freeze({
    get(req, res) {
      console.log(111);
      res.send(200);
    },
    async post(req, res) {
      let result;

      try {
        result = await model.create(req.body);
      } catch (err) {
        console.error(err);
      }

      // res.status(201);
      res.sendStatus(201);

      return result;
    },
    put() {},
    delete() {},
  });
}
