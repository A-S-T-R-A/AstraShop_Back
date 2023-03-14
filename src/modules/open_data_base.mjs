export function openDatabase(model) {
  return Object.freeze({
    async get(req) {
      const { query, params } = req;

      if (params.id) {
        let result;

        try {
          result = await model.findByPk(params.id, { raw: true });
        } catch (err) {
          console.error(err);
        }

        return result;
      }

      let result;

      try {
        if (Object.keys(query).length) {
          for (let name in query) {
            query[name] = JSON.parse(query[name]);
          }

          result = await model.findAll(query);
        } else {
          result = await model.findAll();
        }
      } catch (err) {
        console.error(err);
      }

      return result;
    },
    async post(req) {
      const { body } = req;

      if (typeof body === "undefined") {
        throw new Error("invalid params");
      }

      let result;

      try {
        result = await model.create(req.body);
      } catch (err) {
        console.error(err);
      }

      return result;
    },
    put(params) {
      const { body } = params;
    },
    delete() {},
  });
}
