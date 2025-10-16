require 'faker'

Order.delete_all
Product.delete_all
Customer.delete_all

25.times do
  Customer.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email
  )
end

products_data = [
  # Electronics (10 products)
  { name: "Smartphone X1", category: "Electronics", description: "Latest 5G smartphone with 128GB storage", price: 699.99 },
  { name: "Wireless Earbuds", category: "Electronics", description: "Noise-canceling earbuds with 20-hour battery life", price: 149.99 },
  { name: "4K Smart TV", category: "Electronics", description: "55-inch 4K Ultra HD LED television", price: 499.99 },
  { name: "Laptop Pro 15", category: "Electronics", description: "High-performance laptop with 16GB RAM", price: 1299.99 },
  { name: "Smart Watch", category: "Electronics", description: "Fitness tracker with heart rate monitor", price: 199.99 },
  { name: "Bluetooth Speaker", category: "Electronics", description: "Portable speaker with 360-degree sound", price: 89.99 },
  { name: "Gaming Console", category: "Electronics", description: "Next-gen gaming console with 1TB storage", price: 499.99 },
  { name: "Tablet 10", category: "Electronics", description: "10-inch tablet with 64GB storage", price: 299.99 },
  { name: "Wireless Mouse", category: "Electronics", description: "Ergonomic mouse with adjustable DPI", price: 29.99 },
  { name: "Mechanical Keyboard", category: "Electronics", description: "RGB backlit keyboard with tactile switches", price: 99.99 },
  # Clothing (10 products)
  { name: "Men's Cotton T-Shirt", category: "Clothing", description: "Comfortable crew-neck t-shirt in various colors", price: 19.99 },
  { name: "Women's Denim Jeans", category: "Clothing", description: "Slim-fit blue jeans with stretch", price: 49.99 },
  { name: "Wool Sweater", category: "Clothing", description: "Cozy wool sweater for cold weather", price: 59.99 },
  { name: "Running Shoes", category: "Clothing", description: "Lightweight athletic shoes with cushioning", price: 79.99 },
  { name: "Leather Jacket", category: "Clothing", description: "Classic black leather jacket", price: 149.99 },
  { name: "Summer Dress", category: "Clothing", description: "Floral print dress for warm weather", price: 39.99 },
  { name: "Winter Coat", category: "Clothing", description: "Insulated coat with hood", price: 99.99 },
  { name: "Sports Leggings", category: "Clothing", description: "High-waisted leggings for workouts", price: 34.99 },
  { name: "Formal Shirt", category: "Clothing", description: "Crisp white dress shirt for men", price: 44.99 },
  { name: "Knit Scarf", category: "Clothing", description: "Soft scarf for winter accessorizing", price: 24.99 },
  # Books (10 products)
  { name: "Sci-Fi Novel", category: "Books", description: "Epic space adventure novel", price: 14.99 },
  { name: "Mystery Thriller", category: "Books", description: "Suspenseful crime novel", price: 12.99 },
  { name: "Fantasy Saga", category: "Books", description: "First book in a magical trilogy", price: 19.99 },
  { name: "Cookbook", category: "Books", description: "100 recipes for home cooking", price: 24.99 },
  { name: "History Book", category: "Books", description: "Detailed account of World War II", price: 29.99 },
  { name: "Self-Help Guide", category: "Books", description: "Guide to personal growth and mindfulness", price: 15.99 },
  { name: "Children's Storybook", category: "Books", description: "Illustrated tales for young readers", price: 9.99 },
  { name: "Science Textbook", category: "Books", description: "Introduction to quantum physics", price: 39.99 },
  { name: "Poetry Collection", category: "Books", description: "Anthology of modern poetry", price: 11.99 },
  { name: "Biography", category: "Books", description: "Life story of a famous inventor", price: 17.99 },
  # Furniture (10 products)
  { name: "Wooden Dining Table", category: "Furniture", description: "Solid oak table for six", price: 399.99 },
  { name: "Ergonomic Office Chair", category: "Furniture", description: "Adjustable chair with lumbar support", price: 149.99 },
  { name: "Sofa Bed", category: "Furniture", description: "Convertible sofa for small spaces", price: 499.99 },
  { name: "Bookshelf", category: "Furniture", description: "Five-shelf wooden bookcase", price: 129.99 },
  { name: "Coffee Table", category: "Furniture", description: "Glass-top table with metal frame", price: 89.99 },
  { name: "Bed Frame", category: "Furniture", description: "Queen-size wooden bed frame", price: 249.99 },
  { name: "Nightstand", category: "Furniture", description: "Compact nightstand with drawer", price: 59.99 },
  { name: "Dining Chair", category: "Furniture", description: "Set of two cushioned chairs", price: 99.99 },
  { name: "TV Stand", category: "Furniture", description: "Stand with storage for 55-inch TVs", price: 179.99 },
  { name: "Desk", category: "Furniture", description: "Minimalist desk for home office", price: 199.99 },
  # Toys (10 products)
  { name: "Building Blocks Set", category: "Toys", description: "100-piece colorful block set", price: 29.99 },
  { name: "Remote Control Car", category: "Toys", description: "Fast RC car with rechargeable battery", price: 39.99 },
  { name: "Puzzle Game", category: "Toys", description: "500-piece jigsaw puzzle", price: 14.99 },
  { name: "Action Figure", category: "Toys", description: "Superhero figure with accessories", price: 19.99 },
  { name: "Board Game", category: "Toys", description: "Family strategy game for 4 players", price: 24.99 },
  { name: "Stuffed Animal", category: "Toys", description: "Plush teddy bear for kids", price: 12.99 },
  { name: "Toy Train Set", category: "Toys", description: "Wooden train with tracks", price: 49.99 },
  { name: "Art Kit", category: "Toys", description: "Drawing and painting set for kids", price: 19.99 },
  { name: "Dollhouse", category: "Toys", description: "Miniature house with furniture", price: 59.99 },
  { name: "Science Experiment Kit", category: "Toys", description: "STEM kit for young scientists", price: 34.99 }
]
products_data.each do |product|
  Product.create!(
    name: product[:name],
    category: product[:category].downcase,
    description: product[:description],
    price: product[:price]
  )
end

200.times do
  customer = Customer.all.sample
  product = Product.all.sample
  quantity = rand(1..5)

  Order.create!(
    customer: customer,
    product: product,
    quantity: quantity,
    total_price: product.price * quantity
  )
end

puts "Seed finished: #{Customer.count} customers, #{Product.count} products, #{Order.count} orders created."
