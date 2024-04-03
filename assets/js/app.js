import "./order.js" // Your custom JavaScript for the order page
// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css"
// app.js
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"

// Fetch products from the API and display them
function fetchProducts() {
    fetch('/api/products')
        .then(response => response.json())
        .then(data => {
            displayProducts(data.data);
        })
        .catch(error => console.error('Error fetching products:', error));
}


function fetchBrands() {
    fetch('/api/brands')
        .then(response => response.json())
        .then(data => {
            const brandSelect = document.getElementById('brand-select');
            data.data.forEach(brand => {
                const option = document.createElement('option');
                option.value = brand.id;
                option.text = brand.name;
                brandSelect.add(option);
            });
        })
        .catch(error => console.error('Error fetching brands:', error));
}



function displayProducts(products) {
    const productList = document.getElementById('product-list');
    productList.innerHTML = '';

    products.forEach(product => {
        const productItem = document.createElement('div');
        productItem.classList.add('product-item');
        productItem.innerHTML = `
            <p></p>Product ID: ${product.id}</p>
            <p>Product Code: ${product.product_code}</p>
            <p>Product Name: ${product.product_name}</p>
            <p>Selling Price: ${product.selling_price}</p>
            <p>Brand Name: ${product.brand_name}</p>
            <button class="edit-btn">Edit</button>
            <button class="delete-btn" data-product-id="${product.id}">Delete</button>
        `;

        productItem.querySelector('.edit-btn').addEventListener('click', () => {
            showModal('Edit Product', product);
        });

        productItem.querySelector('.delete-btn').addEventListener('click', (event) => {
            const productId = event.target.dataset.productId;
            handleDelete(productId);
        });

        productList.appendChild(productItem);
    });
}

// Show modal with form
function showModal(title, product = null) {
    const modal = document.getElementById('modal');
    const modalTitle = document.getElementById('modal-title');
    const productIdInput = document.getElementById('product-id');
    const productCodeInput = document.getElementById('product-code');
    const productNameInput = document.getElementById('product-name');
    const sellingPriceInput = document.getElementById('selling-price');
    const brandSelect = document.getElementById('brand-select');

    modalTitle.textContent = title;
    modal.style.display = 'block';

    if (product) {
        productIdInput.value = product.id;
        productCodeInput.value = product.product_code;
        productNameInput.value = product.product_name;
        sellingPriceInput.value = product.selling_price;

        // Set the selected brand option
        const selectedBrandOption = Array.from(brandSelect.options).find(
            option => option.value === product.brand_id.toString()
        );
        if (selectedBrandOption) {
            selectedBrandOption.selected = true;
        }
    } else {
        productIdInput.value = '';
        productCodeInput.value = '';
        productNameInput.value = '';
        sellingPriceInput.value = '';
        brandSelect.selectedIndex = 0; // Reset the brand select to the first option
    }
}


// Close modal
function closeModal() {
    const modal = document.getElementById('modal');
    modal.style.display = 'none';
}

function handleFormSubmit(event) {
    event.preventDefault();

    const productIdInput = document.getElementById('product-id');
    const productCodeInput = document.getElementById('product-code');
    const productNameInput = document.getElementById('product-name');
    const sellingPriceInput = document.getElementById('selling-price');
    const brandSelect = document.getElementById('brand-select');

    // Check if input elements exist
    if (!productCodeInput || !productNameInput || !sellingPriceInput || !brandSelect) {
        console.error('Input elements not found');
        return;
    }

    const selectedBrandId = brandSelect.options[brandSelect.selectedIndex].value; // Get the selected brand ID

    // Check for null values
    if (
        !productCodeInput.value ||
        !productNameInput.value ||
        !sellingPriceInput.value ||
        !selectedBrandId
    ) {
        alert('Please fill in all required fields.');
        return;
    }

    const productData = {
        product_code: productCodeInput.value,
        product_name: productNameInput.value,
        selling_price: parseFloat(sellingPriceInput.value),
        brand_id: parseInt(selectedBrandId)
    };

    if (productIdInput.value) {
        // Update existing product

        console.log(productData);
        console.log(productIdInput.value);
        fetch(`/api/products/${productIdInput.value}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ product: productData })
        })
            .then(response => {
                console.log(response);
                if (response.ok) {
                    fetchProducts();
                    closeModal();
                } else {
                    console.error('Error updating product:', response.status);
                }
            })
            .catch(error => console.error('Error updating product:', error));
    } else {
        console.log(JSON.stringify({ product: productData }));
        fetch('/api/products', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ product: productData })
        })
            .then(response => {
                console.log(response);
                if (response.ok) {
                    fetchProducts();
                    closeModal();
                } else {
                    console.error('Error creating product:', response.status);
                }
            })
            .catch(error => console.error('Error creating product:', error));
    }
}

function handleDelete(productId) {
    // add a confirmation dialog
    const confirmDelete = confirm('Are you sure you want to delete this product?');
    if (!confirmDelete) {
        return;
    }
    else {
        fetch(`/api/products/${productId}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => {
            if (response.ok) {
                fetchProducts(); // Fetch updated product list after deletion
            } else {
                console.error('Error deleting product:', response.status);
            }
        })
        .catch(error => console.error('Error deleting product:', error));
    }
}


function handleSearch() {
    const searchInput = document.getElementById('search-input').value.trim().toLowerCase();
    const searchTerms = searchInput.split(' '); // Split the search input into an array of terms
    const products = document.getElementById('product-list').children;

    for (let product of products) {
        const productCode = product.querySelector('p:nth-child(2)').textContent.toLowerCase();
        const productName = product.querySelector('p:nth-child(3)').textContent.toLowerCase();
        const brandName = product.querySelector('p:nth-child(6)').textContent.toLowerCase();

        const shouldDisplay = searchTerms.every(term => {
            return productCode.includes(term) || productName.includes(term) || brandName.includes(term);
        });

        product.style.display = shouldDisplay ? 'block' : 'none';
    }
}

// Search on change of input

// Add event listeners
document.addEventListener('DOMContentLoaded',async () => {
    fetchProducts();
    fetchBrands();

    const addProductBtn = document.getElementById('add-product-btn');
    addProductBtn.addEventListener('click', () => {
        showModal('Add Product');
    });

    const closeBtn = document.querySelector('.close');
    closeBtn.addEventListener('click', closeModal);

    const searchInput = document.getElementById('search-input');
    const searchBtn = document.getElementById('search-btn');
    searchBtn.addEventListener('click', handleSearch);
    searchInput.addEventListener('input', handleSearch);

    const modalSubmitBtn = document.getElementById('modal-submit');
    modalSubmitBtn.addEventListener('click', handleFormSubmit);
});