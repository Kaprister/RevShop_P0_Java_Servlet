function updateQuantity(productId, action, maxQuantity) {
    const quantityElement = document.getElementById(`quantity-${productId}`);
    let currentQuantity = parseInt(quantityElement.value);

    if (action === 'increase') {
        if (currentQuantity < maxQuantity) {
            quantityElement.value = currentQuantity + 1;
        } else {
            alert('Cannot add more than ' + maxQuantity + ' items. Out of stock!');
        }
    } else if (action === 'decrease') {
        if (currentQuantity > 1) {
            quantityElement.value = currentQuantity - 1;
        }
    }
    // Update the displayed quantity
    document.getElementById(`current-quantity-${productId}`).textContent = quantityElement.value;
}

window.onload = function() {
    // Attach event listeners to the buttons
    const decreaseButtons = document.querySelectorAll('.decrease-btn');
    const increaseButtons = document.querySelectorAll('.increase-btn');

    decreaseButtons.forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-product-id');
            const maxQuantity = this.getAttribute('data-max-quantity');
            updateQuantity(productId, 'decrease', maxQuantity);
        });
    });

    increaseButtons.forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-product-id');
            const maxQuantity = this.getAttribute('data-max-quantity');
            updateQuantity(productId, 'increase', maxQuantity);
        });
    });
};
