import * as dotenv from "dotenv";
import Stripe from "stripe";
import { Database } from "../../database/index.mjs";

dotenv.config();

const { STRIPE_SECRET_KEY, PAYMENT_SUCCESS_URL, PAYMENT_CANCEL_URL } =
  process.env;

const stripe = new Stripe(STRIPE_SECRET_KEY);

export async function createOrder(req, res) {
  const db = Database().getInstance();

  const {
    order: { products },
  } = req.body;

  let checkoutSession;

  const lineItems = products.map((product) => {
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

  try {
    checkoutSession = await stripe.checkout.sessions.create({
      line_items: lineItems,
      mode: "payment",
      success_url: `${PAYMENT_SUCCESS_URL}`,
      cancel_url: `${PAYMENT_CANCEL_URL}`,
    });
  } catch (err) {
    console.log(err);
    return res.status(500);
  }

  res.status(201).json({ url: checkoutSession.url });

  // const { orders } = db.models;

  // let result;

  // try {
  //   result = await orders.create({ product_id });
  // } catch (err) {
  //   console.log(err);
  // }

  // res.json(result);
}
