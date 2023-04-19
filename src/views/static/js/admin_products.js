let modal;
let closeModalButton;
let addProductButton;
let productForm;
let errorMessage;
let productsTable;
let selectCategoryForCreateProduct;

let editProductModal;
let editProfuctForm;
let editProductNameInput;
let editProductDescriptionInput;
let editProductPriceInput;
let editProductCloseModalButton;
let editProductSaveButton;
let editProductDeleteButton;
let selectCategoryForEditProduct;
let editProductImagesBlock;
let editProductImagesInput;

let productImagesInput;

const state = {
  selectedProduct: null,
  images: [],
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

  Array.from(selectCategoryForEditProduct.options).forEach((option) => {
    if (option.value == data.category.id) {
      option.selected = true;
    }
  });

  if (data.images) {
    editProductImagesBlock.innerHTML = "";

    data.images.forEach((image) => {
      const img = document.createElement("img");
      img.src = image;
      img.classList.add("product-image");

      editProductImagesBlock.appendChild(img);
    });
  }

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
    <td>${data.price}</td>
    <td>${data.description}</td>
    <td>${data.parentCategoryName}</td>
  `;
}

async function createProduct(event) {
  event.preventDefault();

  if (!productForm.checkValidity()) return false;

  const data = {
    name: productForm.name.value,
    price: productForm.price.value,
    description: productForm.description.value,
    parent_category_id: selectCategoryForCreateProduct.value,
    images: state.images,
  };

  const result = await fetch("/api/v1/product", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });

  if (result.ok) {
    const d = await result.json();

    insertProductToTable({
      ...d,
      parentCategoryName:
        selectCategoryForCreateProduct.children[
          selectCategoryForCreateProduct.selectedIndex
        ].textContent,
    });

    closeCreateProductModal();
  } else {
    errorMessage.textContent = "Failed to create product";
    return;
  }
}

async function deleteProduct() {
  const isConfirm = await confirm(
    "Are you sure you want to delete this product?"
  );

  if (!isConfirm) return;

  const { id } = state.selectedProduct;

  const result = await fetch(`/api/v1/product/${id}`, {
    method: "DELETE",
  });

  if (result.ok) {
    document.getElementById(`product-${id}`).remove();
    closeEditProductModal();
  } else {
    errorMessage.textContent = "Failed to delete product";
    return;
  }
}

async function updateProduct(event) {
  event.preventDefault();

  if (!editProfuctForm.checkValidity()) return false;

  const { id } = state.selectedProduct;

  const name = editProfuctForm.name.value;
  const description = editProfuctForm.description.value;
  const price = editProfuctForm.price.value;
  const parent_category_id = +selectCategoryForEditProduct.value;
  const images = state.images;

  const data = {
    name,
    description,
    price,
    parent_category_id,
    images,
  };

  const result = await fetch(`/api/v1/product/${id}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });

  if (result.ok) {
    document.getElementById(`product-${id}`).innerHTML = `
      <td>${id}</td>
      <td>${name}</td>
      <td>${price}</td>
      <td>${description}</td>
      <td>${
        selectCategoryForEditProduct.children[
          selectCategoryForEditProduct.selectedIndex
        ].textContent
      }</td>
    `;

    closeEditProductModal();
  } else {
    errorMessage.textContent = "Failed to update product";
    return;
  }
}

async function uploadImages(event) {
  const { files } = event.target;

  if (files.length > 0) {
    const formData = new FormData();

    Array.from(files).forEach((file) => {
      formData.append("images", file);
    });

    const result = await fetch("/api/v1/upload/images", {
      method: "POST",
      body: formData,
    });

    const data = await result.json();

    if (result.ok) {
      state.images = data;
    } else {
      return;
    }
  }
}

function init() {
  modal = document.getElementById("modal");
  closeModalButton = document.getElementById("close-modal-button");
  addProductButton = document.getElementById("add-product");
  productForm = document.getElementById("product-form");
  errorMessage = document.getElementById("error-message");
  productsTable = document.getElementById("products");
  selectCategoryForCreateProduct = document.getElementById(
    "select-category-for-create"
  );

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
  selectCategoryForEditProduct = document.getElementById(
    "select-category-for-edit"
  );
  editProductImagesBlock = document.getElementById("edit-product-modal-images");
  editProductImagesInput = document.getElementById("product-images-edit");

  productImagesInput = document.getElementById("product-images");

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
    !editProductDeleteButton ||
    !productImagesInput ||
    !editProductImagesBlock ||
    !editProductImagesInput
  ) {
    throw new Error("Missing elements");
  }

  closeModalButton.addEventListener("click", closeCreateProductModal);
  addProductButton.addEventListener("click", openCreateProductModal);
  productForm.addEventListener("submit", createProduct);
  productsTable.addEventListener("click", selectProduct);

  editProductCloseModalButton.addEventListener("click", closeEditProductModal);
  editProductDeleteButton.addEventListener("click", deleteProduct);
  editProfuctForm.addEventListener("submit", updateProduct);

  productImagesInput.addEventListener("change", uploadImages);
  editProductImagesInput.addEventListener("change", uploadImages);
}

document.addEventListener("DOMContentLoaded", init);
