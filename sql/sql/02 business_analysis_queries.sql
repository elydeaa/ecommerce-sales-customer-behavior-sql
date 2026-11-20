/* ============================================================================
   Project : E-Commerce Sales & Customer Behavior Analysis
   File    : 02_business_analysis_queries.sql
   Authors : Deris Muhammad Al Faras & Ely Dea Theresia Br Manik
   ============================================================================ */

-- 1. Product & Revenue Performance Analysis
-- Calculates total revenue per product from completed transactions ('Lunas'),
-- ranked from highest to lowest revenue contributor.
SELECT
    p.nama_produk,
    p.kategori,
    SUM(j.jumlah_beli) AS total_unit_terjual,
    SUM(p.harga * j.jumlah_beli) AS total_pendapatan
FROM penjualan j
JOIN produk p ON j.id_produk = p.id_produk
WHERE j.status_bayar = 'Lunas'
GROUP BY p.nama_produk, p.kategori
ORDER BY total_pendapatan DESC;


-- 2. Category-Level Revenue Summary
-- Aggregates total revenue and completed order volume by product category.
SELECT
    p.kategori,
    COUNT(j.id_transaksi) AS total_transaksi_sukses,
    SUM(j.jumlah_beli) AS total_unit_terjual,
    SUM(p.harga * j.jumlah_beli) AS total_pendapatan
FROM penjualan j
JOIN produk p ON j.id_produk = p.id_produk
WHERE j.status_bayar = 'Lunas'
GROUP BY p.kategori
ORDER BY total_pendapatan DESC;


-- 3. Customer Behavior & Order Cancellation Analysis
-- Tracks total order frequency, successful payments, and cancellations per buyer.
SELECT
    nama_pelanggan,
    COUNT(id_transaksi) AS total_kali_order,
    SUM(CASE WHEN status_bayar = 'Lunas' THEN 1 ELSE 0 END) AS order_sukses,
    SUM(CASE WHEN status_bayar = 'Dibatalkan' THEN 1 ELSE 0 END) AS order_batal,
    ROUND(
        100.0 * SUM(CASE WHEN status_bayar = 'Lunas' THEN 1 ELSE 0 END) / COUNT(id_transaksi),
        1
    ) AS completion_rate_pct
FROM penjualan
GROUP BY nama_pelanggan
ORDER BY total_kali_order DESC, order_sukses DESC;
