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

  if (!order) {
    return res.status(400).json({ message: "No order" });
  }

  let productsResult;

  try {
    productsResult = await product.findAll({
      where: {
        id: order.map((product) => product.id),
      },
      attributes: ["id", "name", "price"],
    });

    if (productsResult.length < order.length) {
      return res.status(400).json({ message: "Product not found" });
    }
  } catch (err) {
    console.log(err);
    return res.status(500);
  }

  productsResult = productsResult.map((product) => product.toJSON());

  let lineItems = productsResult.map((product, i) => {
    return {
      price_data: {
        currency: "usd",
        product_data: {
          name: product.name,
        },
        unit_amount: product.price * 100,
      },
      quantity: order[i].quantity,
    };
  });

  let checkoutSession;

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

  const { orders, order_products } = db.models;

  let result;

  try {
    result = await orders.create({});
  } catch (err) {
    console.log(err);
    return res.status(500);
  }

  const orderId = result.id;

  try {
    result = await order_products.bulkCreate(
      order.map((el) => {
        return {
          product_id: el.id,
          order_id: orderId,
          quantity: el.quantity,
        };
      })
    );
  } catch (err) {
    console.log(err);
    return res.status(500);
  }
}
