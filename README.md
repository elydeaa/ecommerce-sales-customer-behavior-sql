# E-Commerce Sales & Customer Behavior Analysis (SQL Project)

![SQL](https://img.shields.io/badge/Language-SQL-blue)
![Database](https://img.shields.io/badge/Engine-SQLite-003B57)
![Focus](https://img.shields.io/badge/Focus-Product%20%26%20Customer%20Analytics-green)
![Collaboration](https://img.shields.io/badge/Type-Collaborative%20Project-orange)

## 📌 Project Overview & Objectives
This project analyzes e-commerce transactional data using relational SQL queries to uncover actionable insights into **product revenue performance** and **customer purchasing behavior**. By combining normalized database design with conditional aggregation, the analysis aims to:
1. **Optimize Revenue:** Identify top-performing products and core revenue-generating categories.
2. **Track Customer Loyalty & Friction:** Segment buyers based on order frequency, completion rates, and order cancellations to pinpoint operational bottlenecks.

---

## 👥 Project Team & Roles
This project was executed collaboratively across two analytical tracks:

* **Deris Muhammad Al Faras — Customer Behavior Analyst**
  * Evaluated buyer purchasing patterns and order frequency across customer profiles.
  * Segmented customers based on loyalty and order completion rates.
  * Identified operational bottlenecks and potential revenue leakage by tracking order cancellation metrics.
* **Ely Dea Theresia Br Manik — Product & Revenue Analyst**
  * Designed the relational database schema (`produk` and `penjualan` tables) with Primary and Foreign Key constraints.
  * Structured the master product catalog and transactional dataset.
  * Analyzed product-level sales performance and calculated total revenue contributions from completed orders.

---

## 🗄️ Relational Database Schema
The database is implemented in **SQLite** and consists of two interrelated tables:

### 1. `produk` (Product Master Table)
Stores item master records with unique identifiers, categories, and unit prices (in IDR).
| Column | Data Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id_produk` | `INTEGER` | `PRIMARY KEY` | Unique identifier for each product |
| `nama_produk` | `TEXT` | — | Name of the product (e.g., *Laptop Asus*, *Sepatu Running*) |
| `kategori` | `TEXT` | — | Product category (`Fashion` or `Elektronik`) |
| `harga` | `INTEGER` | — | Unit price in Indonesian Rupiah (IDR) |

### 2. `penjualan` (Sales Transactions Table)
Records customer order logs linked to the product catalog via `id_produk`.
| Column | Data Type | Constraint | Description |
| :--- | :--- | :--- | :--- |
| `id_transaksi` | `INTEGER` | `PRIMARY KEY` | Unique identifier for each order |
| `id_produk` | `INTEGER` | `FOREIGN KEY` | References `produk(id_produk)` |
| `nama_pelanggan` | `TEXT` | — | Name of the customer |
| `jumlah_beli` | `INTEGER` | — | Quantity of units ordered |
| `status_bayar` | `TEXT` | — | Payment status (`Lunas` = Paid/Completed, `Dibatalkan` = Cancelled) |

---

## 🔍 SQL Queries & Key Business Insights

### 1. Product & Revenue Performance Analysis
Calculates total realized revenue per product by joining transaction logs with master pricing and filtering exclusively for completed payments (`status_bayar = 'Lunas'`).

```sql
SELECT
    p.nama_produk,
    p.kategori,
    SUM(p.harga * j.jumlah_beli) AS total_pendapatan
FROM penjualan j
JOIN produk p ON j.id_produk = p.id_produk
WHERE j.status_bayar = 'Lunas'
GROUP BY p.nama_produk, p.kategori
ORDER BY total_pendapatan DESC;
```

* **Core Profit Engine:** **Laptop Asus** (`Elektronik`) is the overwhelming revenue driver, generating nearly **IDR 16,000,000** in total sales.
* **Mid-Tier Performers:** **Sepatu Running** and **Smartwatch** provide moderate, steady revenue contributions.
* **Low-Ticket Items:** Accessories such as **Mouse Wireless** generate the lowest total revenue, confirming a right-skewed revenue distribution anchored by high-ticket electronics.

---

### 2. Customer Behavior & Order Cancellation Analysis
Evaluates individual buyer engagement by counting total orders placed and using `CASE WHEN` conditional aggregation to separate successful purchases from cancellations.

```sql
SELECT
    nama_pelanggan,
    COUNT(id_transaksi) AS total_kali_order,
    SUM(CASE WHEN status_bayar = 'Lunas' THEN 1 ELSE 0 END) AS order_sukses,
    SUM(CASE WHEN status_bayar = 'Dibatalkan' THEN 1 ELSE 0 END) AS order_batal
FROM penjualan
GROUP BY nama_pelanggan
ORDER BY total_kali_order DESC;
```

* **Most Active Buyer:** **Andi** leads platform engagement with **6 total orders** (5 completed, 1 cancelled).
* **High-Loyalty Customers:** **Siti** (5/5 completed), **Dewi** (4/4 completed), and **Feri** (3/3 completed) achieved a **100% order completion rate** with zero cancellations.
* **Cancellation Friction:** Customers such as **Andi**, **Budi** (4/5), **Rian** (3/4), and **Mega** (2/3) each experienced 1 cancelled order, highlighting opportunities to investigate checkout drop-offs or stock availability issues.

---

## 💡 Strategic Recommendations
1. **Inventory & Marketing Prioritization:** Allocate prioritized inventory buffer and promotional campaigns toward high-margin `Elektronik` items (especially *Laptop Asus* and *Smartwatch*) while bundling low-ticket accessories (*Mouse Wireless*) to lift average order value.
2. **Loyalty Retention Program:** Reward 100%-completion buyers (*Siti*, *Dewi*, *Feri*) with exclusive vouchers to maintain repeat purchase velocity.
3. **Cancellation Mitigation:** Audit checkout and payment confirmation steps for cancelled transactions (`status_bayar = 'Dibatalkan'`) to recover lost revenue.

---

## 🤝 Authors & Contact
* **Deris Muhammad Al Faras** — [LinkedIn](https://www.linkedin.com/derisalfaras) 
* **Ely Dea Theresia Br Manik** — [LinkedIn](https://www.linkedin.com/elydeatheresia) 
