# Paw Mart

Paw Mart is a browser-based pet store built with HTML, CSS, JavaScript, and Supabase.

The site has a home page and a product catalog for pet toys and accessories. The catalog reads product names, images, prices, and stock counts from a Supabase database. Users can browse all products, filter by category, or search by product name.

## Features

- Product catalog backed by Supabase
- Category filters for toys and accessories
- Case-insensitive product search
- Responsive product card grid
- Product prices in Thai baht and current stock counts
- Database schema for customers, products, orders, order items, deliveries, and payments

## How to run the project locally

### 1. Clone the repository

```bash
git clone https://github.com/tintunaung124/Paw-Mart.git
cd Paw-Mart
```

### 2. Create the Supabase database

1. Create a project at [Supabase](https://supabase.com/).
2. Open the project's **SQL Editor**.
3. Copy the contents of `pawmart.sql` into the editor.
4. Run the script to create the tables, sample data, indexes, and product read policy.

### 3. Configure the Supabase client

Open `supabase.js` and replace the project URL and publishable key with the values from **Project Settings > API**:

```javascript
const supabaseUrl = 'YOUR_SUPABASE_URL';
const supabaseKey = 'YOUR_SUPABASE_PUBLISHABLE_KEY';
```

The browser uses this publishable key to read products. Do not place a Supabase service-role key in this file.

### 4. Start a local web server

The project uses JavaScript modules, so serve the folder through a local web server instead of opening `index.html` directly.

If you have the VS Code Live Server extension, right-click `index.html` and select **Open with Live Server**.

You can also use Python:

```bash
python -m http.server 8000
```

Then open [http://localhost:8000](http://localhost:8000) in your browser.

## How to use the store

1. Open the home page.
2. Select **Products > All** to view the complete catalog.
3. Select **Toy** or **Accessory** to filter products by category.
4. Enter a product name in the search box and press `Enter` to search.

The **Add to Cart** button is a visual placeholder. The project does not yet store a cart or submit orders.

## Project structure

```text
Paw-Mart/
|-- index.html          # Home page
|-- products.html       # Product catalog page
|-- products.js         # Supabase queries and product rendering
|-- supabase.js         # Supabase client configuration
|-- pawmart.sql         # Database schema, sample data, and read policy
|-- mainstyling.css     # Shared navigation and home-page styles
|-- products.css        # Product catalog styles
`-- img/                # Logo, home-page art, and product images
```
