/* ============================================================================
   Project : E-Commerce Sales & Customer Behavior Analysis
   File    : 01_schema_and_seed_data.sql
   Authors : Deris Muhammad Al Faras & Ely Dea Theresia Br Manik
   Engine  : SQLite
   ============================================================================ */

-- 1. Create Product Master Table
CREATE TABLE produk (
    id_produk INTEGER PRIMARY KEY,
    nama_produk TEXT NOT NULL,
    kategori TEXT NOT NULL,
    harga INTEGER NOT NULL
);

-- 2. Create Sales Transactions Table
CREATE TABLE penjualan (
    id_transaksi INTEGER PRIMARY KEY,
    id_produk INTEGER NOT NULL,
    nama_pelanggan TEXT NOT NULL,
    jumlah_beli INTEGER NOT NULL,
    status_bayar TEXT NOT NULL,
    FOREIGN KEY (id_produk) REFERENCES produk(id_produk)
);

-- 3. Populate Product Master Data
INSERT INTO produk (id_produk, nama_produk, kategori, harga) VALUES
(1, 'Sepatu Running', 'Fashion', 500000),
(2, 'Kemeja Flanel', 'Fashion', 250000),
(3, 'Laptop Asus', 'Elektronik', 8000000),
(4, 'Mouse Wireless', 'Elektronik', 150000),
(5, 'Smartwatch', 'Elektronik', 1200000),
(6, 'Jaket Bomber', 'Fashion', 350000),
(7, 'T-Shirt Polos', 'Fashion', 85000),
(8, 'Keyboard Mechanical', 'Elektronik', 600000),
(9, 'Headphone Bluetooth', 'Elektronik', 450000),
(10, 'Celana Chino', 'Fashion', 200000);

-- 4. Populate Sample Transactional Records
INSERT INTO penjualan (id_transaksi, id_produk, nama_pelanggan, jumlah_beli, status_bayar) VALUES
(101, 1, 'Andi', 2, 'Lunas'),
(102, 3, 'Budi', 1, 'Lunas'),
(103, 4, 'Andi', 1, 'Dibatalkan'),
(104, 2, 'Siti', 3, 'Lunas'),
(105, 1, 'Budi', 1, 'Lunas'),
(106, 7, 'Dewi', 5, 'Lunas'),
(107, 5, 'Rian', 1, 'Lunas'),
(108, 10, 'Siti', 2, 'Lunas'),
(109, 3, 'Rian', 1, 'Dibatalkan'),
(110, 6, 'Andi', 1, 'Lunas'),
(111, 2, 'Mega', 2, 'Lunas'),
(112, 7, 'Budi', 4, 'Lunas'),
(113, 8, 'Dewi', 1, 'Lunas'),
(114, 9, 'Feri', 2, 'Lunas'),
(115, 4, 'Siti', 2, 'Lunas'),
(116, 1, 'Mega', 1, 'Dibatalkan'),
(117, 6, 'Rian', 2, 'Lunas');
