const orderForm = document.getElementById("order-form");

orderForm.addEventListener("submit", async (e) => {
  e.preventDefault();

  const order = Array.from(
    document.getElementsByClassName("product_quantity")
  ).map((el) => ({ quantity: +el.value, id: +el.id.match(/\d+/)[0] }));

  const response = await fetch("/api/v1/order", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ order }),
  });

  const result = await response.json();

  location.href = result.url;
});

const uploadForm = document.getElementById("upload-form");

uploadForm.addEventListener("submit", async (e) => {
  e.preventDefault();

  const formData = new FormData(uploadForm);

  const response = await fetch("/api/v1/product/35/upload_photo", {
    method: "PUT",
    body: formData,
  });

  const result = await response.json();

  console.log(result);
});
