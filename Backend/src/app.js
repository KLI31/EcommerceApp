const express = require('express');
const cors = require('cors');
require('dotenv').config();
const authRoutes = require('./routes/authRoutes');
const productRoutes = require('./routes/routesProducts');
const wishlistRoutes = require('./routes/whishlistRoutes');
const bodyParser = require('body-parser');
const cartRoutes = require('./routes/cartRoutes');
require('dotenv').config({ path: './.env' });

const app = express();

app.use(cors());
app.use(express.json());

app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ limit: '10mb', extended: true }));

app.use('/api', authRoutes);
app.use('/api/productos', productRoutes);
app.use('/api', wishlistRoutes);
app.use('/api', cartRoutes);

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});