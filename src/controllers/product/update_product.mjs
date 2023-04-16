export async function updateProduct(req, res) {
  const db = Database().getInstance();

  const { product } = db.models;

  const { id } = req.params;

  const { name, description, price } = req.body;

  let result;

  try {
    result = await product.update(
      {
        name,
        description,
        price,
      },
      {
        where: {
          id,
        },
      }
    );
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }

  res.sendStatus(204);
}
