import * as dotenv from "dotenv";
import Stripe from "stripe";
import { Database } from "../../database/index.mjs";

dotenv.config();

const { STRIPE_SECRET_KEY, PAYMENT_SUCCESS_URL, PAYMENT_CANCEL_URL } =
  process.env;

const stripe = new Stripe(STRIPE_SECRET_KEY);

export async function createOrder(req, res) {
  const db = Database().getInstance();

  const { product } = db.models;

  const { order } = req.body;

  let productsResult;

  try {
    productsResult = await product.findAll({
      where: {
        id: order.map((product) => product.id),
      },
      attributes: ["id", "name", "price"],
    });
  } catch (err) {
    console.log(err);
    return res.status(500);
  }

  productsResult = productsResult.map((product) => product.toJSON());

  let lineItems = productsResult.map((product) => {
    return {
      price_data: {
        currency: "usd",
        product_data: {
          name: product.name,
        },
        unit_amount: product.price * 100,
      },
      quantity: product.quantity,
    };
  });

  let checkoutSession;

  // try {
  //   checkoutSession = await stripe.checkout.sessions.create({
  //     line_items: lineItems,
  //     mode: "payment",
  //     success_url: `${PAYMENT_SUCCESS_URL}`,
  //     cancel_url: `${PAYMENT_CANCEL_URL}`,
  //   });
  // } catch (err) {
  //   console.log(err);
  //   return res.status(500);
  // }

  const { orders } = db.models;

  let result;

  lineItems = lineItems.map((lineItem) => {
    return {
      info: lineItem,
    };
  });

  try {
    result = await orders.bulkCreate(lineItems);
  } catch (err) {
    console.log(err);
    return res.status(500);
  }

  // res.status(201).json({ url: checkoutSession.url });

  // let result;

  // try {
  //   result = await orders.create({ product_id });
  // } catch (err) {
  //   console.log(err);
  // }

  // res.json(result);
}
