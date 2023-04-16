let modal;
let closeModalButton;
let addProductButton;
let productForm;
let errorMessage;
let productsTable;

let editProductModal;
let editProfuctForm;
let editProductNameInput;
let editProductDescriptionInput;
let editProductPriceInput;
let editProductCloseModalButton;
let editProductSaveButton;
let editProductDeleteButton;

const state = {
  selectedProduct: null,
};

function openCreateProductModal() {
  modal.classList.add("active");
  modal.querySelector("input").focus();
}

function openEditProductModal(data) {
  editProductModal.classList.add("active");
  editProductModal.querySelector("input").focus();

  editProductNameInput.value = data.name;
  editProductDescriptionInput.value = data.description;
  editProductPriceInput.value = data.price;

  state.selectedProduct = data;
}

function closeEditProductModal() {
  editProductModal.classList.remove("active");
  editProfuctForm.reset();
}

function closeCreateProductModal() {
  modal.classList.remove("active");
  productForm.reset();
}

async function selectProduct(event) {
  const target = event.target.closest("tr");
  const id = target.dataset.id;

  const result = await fetch(`/api/v1/product/${id}`);
  const data = await result.json();

  openEditProductModal(data);
}

function insertProductToTable(data) {
  const row = productsTable.insertRow(1);

  row.innerHTML = `
    <td>${data.id}</td>
    <td>${data.name}</td>
    <td>${data.description}</td>
    <td>${data.price}</td>
  `;
}

async function createProduct(event) {
  event.preventDefault();

  if (!productForm.checkValidity()) return false;

  const name = productForm.name.value;
  const description = productForm.description.value;
  const price = productForm.price.value;

  const data = {
    name,
    description,
    price,
  };

  const result = await fetch("/api/v1/product", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });

  if (result.ok) {
    closeCreateProductModal();

    const data = await result.json();

    insertProductToTable(data);
  } else {
    errorMessage.textContent = "Failed to create product";
    return;
  }
}

async function deleteProduct() {
  const { id } = state.selectedProduct;

  const result = await fetch(`/api/v1/product/${id}`, {
    method: "DELETE",
  });

  if (result.ok) {
    closeEditProductModal();
  } else {
    errorMessage.textContent = "Failed to delete product";
    return;
  }
}

function init() {
  modal = document.getElementById("modal");
  closeModalButton = document.getElementById("close-modal-button");
  addProductButton = document.getElementById("add-product");
  productForm = document.getElementById("product-form");
  errorMessage = document.getElementById("error-message");
  productsTable = document.getElementById("products");

  editProductModal = document.getElementById("edit-product-modal");
  editProfuctForm = document.getElementById("edit-product-form");
  editProductNameInput = document.getElementById("edit-input-name");
  editProductDescriptionInput = document.getElementById(
    "edit-input-description"
  );
  editProductPriceInput = document.getElementById("edit-input-price");
  editProductCloseModalButton = document.getElementById(
    "close-edit-modal-button"
  );
  editProductSaveButton = document.getElementById("save-product-button");
  editProductDeleteButton = document.getElementById("delete-product-button");

  if (
    !modal ||
    !closeModalButton ||
    !addProductButton ||
    !productForm ||
    !errorMessage ||
    !productsTable ||
    !editProductModal ||
    !editProfuctForm ||
    !editProductNameInput ||
    !editProductDescriptionInput ||
    !editProductPriceInput ||
    !editProductCloseModalButton ||
    !editProductSaveButton ||
    !editProductDeleteButton
  ) {
    throw new Error("Missing elements");
  }

  closeModalButton.addEventListener("click", closeCreateProductModal);
  addProductButton.addEventListener("click", openCreateProductModal);
  productForm.addEventListener("submit", createProduct);
  productsTable.addEventListener("click", selectProduct);

  editProductCloseModalButton.addEventListener("click", closeEditProductModal);
  editProductDeleteButton.addEventListener("click", deleteProduct);
}

document.addEventListener("DOMContentLoaded", init);
