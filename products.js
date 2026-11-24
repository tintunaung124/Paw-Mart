import { supabase } from './supabase.js?v=2';

const params = new URLSearchParams(window.location.search);

const category = params.get('category') || '';
const search = params.get('search') || '';

const title = document.getElementById('products-title');
const grid = document.getElementById('products-grid');

if (category) {
    title.textContent = `Category: ${category}`;
} else if (search) {
    title.textContent = `Search: ${search}`;
} else {
    title.textContent = 'All Products';
}

async function loadProducts() {
    let query = supabase.from('product').select('*');

    if (category) {
        query = query.eq('Category', category);
    }

    if (search) {
        query = query.ilike('ProductName', `%${search}%`);
    }

    const { data, error } = await query.order('ProductID');

    grid.replaceChildren();

    if (error) {
        console.error(error);
        grid.textContent = 'Unable to load products.';
        return;
    }

    if (!data || data.length === 0) {
        grid.textContent = 'No products found.';
        return;
    }

    data.forEach(product => {
        const card = document.createElement('div');
        card.className = 'card';

        const image = document.createElement('img');
        image.src = `img/products/${encodeURIComponent(product.Image)}`;
        image.className = 'product-img';
        image.alt = product.ProductName;

        const name = document.createElement('h4');
        name.textContent = product.ProductName;

        const price = document.createElement('div');
        price.className = 'price';
        price.textContent = `฿${Number(product.Price).toFixed(2)}`;

        const stock = document.createElement('div');
        stock.className = 'stock';
        stock.textContent = `Stock: ${product.StockQuantity}`;

        const button = document.createElement('button');
        button.className = 'btn';
        button.textContent = 'Add to Cart';

        card.append(image, name, price, stock, button);
        grid.appendChild(card);
    });
}

loadProducts();