const orderForm = document.getElementById("order-form");

orderForm.addEventListener("submit", async (e) => {
  e.preventDefault();

  const formData = new FormData(orderForm);
  const product_id = formData.get("product_id");

  const response = await fetch("/api/v1/order", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ product_id }),
  });

  const result = await response.json();

  location.href = result.url;
});
