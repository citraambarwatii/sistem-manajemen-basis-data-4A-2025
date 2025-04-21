CREATE DATABASE Laundry;
USE Laundry;

-- =============
-- TABEL MASTER
-- =============

-- -----------
-- Buat TABEL
-- -----------
-- Tabel Karyawan
CREATE TABLE Karyawan (
    ID_Karyawan CHAR(5) PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Jabatan VARCHAR(50),
    Telepon VARCHAR(15) UNIQUE
) ENGINE=INNODB;

-- Tabel Pelanggan
CREATE TABLE Pelanggan (
    ID_Pelanggan CHAR(5) PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Alamat TEXT,
    Telepon VARCHAR(15) UNIQUE
) ENGINE=INNODB;

-- Tabel Barang
CREATE TABLE Barang (
    ID_Barang CHAR(5) PRIMARY KEY,
    Nama_Barang VARCHAR(50) NOT NULL
) ENGINE=INNODB;

-- Tabel Layanan
CREATE TABLE Layanan (
    ID_Layanan CHAR(5) PRIMARY KEY,
    Nama_Layanan VARCHAR(100) NOT NULL,
    Deskripsi TEXT
) ENGINE=INNODB;


-- ================
-- TABEL TRANSAKSI
-- ================

-- Tabel Transaksi_Layanan_Barang (daftar harga historis)
CREATE TABLE Transaksi_Layanan_Barang (
    ID_TransaksiLB INT AUTO_INCREMENT PRIMARY KEY,
    ID_Layanan CHAR(5),
    ID_Barang CHAR(5),
    Harga_PerKg INT CHECK (Harga_PerKg >= 0),
    FOREIGN KEY (ID_Layanan) REFERENCES Layanan(ID_Layanan),
    FOREIGN KEY (ID_Barang) REFERENCES Barang(ID_Barang)
) ENGINE=INNODB;

-- Tabel Transaksi utama
CREATE TABLE Transaksi (
    ID_Transaksi CHAR(5) PRIMARY KEY,
    ID_Admin CHAR(5),
    ID_Pelanggan CHAR(5),
    Tgl_Masuk DATE,
    Tgl_Selesai DATE,
    Tgl_Bayar DATE NULL,
    Metode VARCHAR(20) NULL,
    STATUS ENUM('Lunas', 'Belum Bayar') DEFAULT 'Belum Bayar',
    Total_Harga INT DEFAULT 0,
    FOREIGN KEY (ID_Admin) REFERENCES Karyawan(ID_Karyawan),
    FOREIGN KEY (ID_Pelanggan) REFERENCES Pelanggan(ID_Pelanggan)
) ENGINE=INNODB;

-- Tabel Detail Transaksi
CREATE TABLE Detail_Transaksi (
    ID_Detail INT AUTO_INCREMENT PRIMARY KEY,
    ID_Transaksi CHAR(5),
    ID_Layanan CHAR(5),
    ID_Barang CHAR(5),
    Berat DECIMAL(5,2),
    Harga_PerKg INT,
    Total INT GENERATED ALWAYS AS (Berat * Harga_PerKg) STORED,
    FOREIGN KEY (ID_Transaksi) REFERENCES Transaksi(ID_Transaksi),
    FOREIGN KEY (ID_Layanan) REFERENCES Layanan(ID_Layanan),
    FOREIGN KEY (ID_Barang) REFERENCES Barang(ID_Barang)
) ENGINE=INNODB;


-- --------------
-- Masukkan TABEL
-- --------------
-- Data Karyawan
INSERT INTO Karyawan (ID_Karyawan, Nama, Jabatan, Telepon) 
VALUES 
('KA001', 'Citra Ambarwati', 'Kasir', '089680879699'),
('KA002', 'Lanny Aprilia', 'Petugas Laundry', '085748436782');

-- Data Pelanggan
INSERT INTO Pelanggan (ID_Pelanggan, Nama, Alamat, Telepon) 
VALUES 
('PL001', 'Rifky Awaludin', 'Jl. Merdeka No.10, Madiun', '0878866930005'),
('PL002', 'Mei Friska', 'Jl. Sudirman No.15, Tuban', '0881036957618'),
('PL003', 'Qurrotul Aini', 'Jl. Ahmad Yani No.20, Sampang', '089515681334'),
('PL004', 'Kholifah Febrianti', 'Jl. Cendana No.5, Tuban', '095807251379'),
('PL005', 'Diah Ayu', 'Jl. Diponegoro No.21, Nganjuk', '085854111594'),
('PL006', 'Sesilia Febi', 'Jl. Raya No.12, Lamongan', '085647198276'),
('PL007', 'Ananda Eka', 'Jl. Pahlawan No.8, Sumenep', '088906547392'),
('PL008', 'Amanatul', 'Jl. Raya Bangkalan No.25, Bangkalan', '089234578421'),
('PL009', 'Hanisah Nurrahma', 'Jl. Kenangan No.7, Mojokerto', '087855112233'),
('PL010', 'Shintya Cindy', 'Jl. Merdeka No.18, Madiun', '085742998274');

-- Data Barang
INSERT INTO Barang (ID_Barang, Nama_Barang) 
VALUES 
('BR001', 'Kemeja'),
('BR002', 'Celana'),
('BR003', 'Sprei'),
('BR004', 'Gorden'),
('BR005', 'Boneka');

-- Data Layanan
INSERT INTO Layanan (ID_Layanan, Nama_Layanan, Deskripsi) 
VALUES 
('LY001', 'Cuci Kering', 'Hanya dicuci dan dikeringkan, tanpa disetrika'),
('LY002', 'Cuci Setrika', 'Dicuci, dikeringkan, dan disetrika'),
('LY003', 'Express 1 Jam', 'Layanan cepat'),
('LY004', 'Dry Clean', 'Pembersihan khusus tanpa air');

-- Data Harga Layanan-Barang
INSERT INTO Transaksi_Layanan_Barang (ID_Layanan, ID_Barang, Harga_PerKg)
VALUES 
('LY001', 'BR001', 5000),
('LY002', 'BR001', 8000),
('LY003', 'BR001', 12000),
('LY004', 'BR001', 25000),
('LY001', 'BR002', 6000),
('LY002', 'BR002', 8500),
('LY003', 'BR002', 13000),
('LY004', 'BR002', 26000),
('LY001', 'BR003', 6000),
('LY002', 'BR003', 9000),
('LY003', 'BR003', 14000),
('LY001', 'BR004', 7000),
('LY002', 'BR004', 9500),
('LY003', 'BR004', 15000),
('LY004', 'BR004', 28000),
('LY001', 'BR005', 7500),
('LY004', 'BR005', 30000);

-- Data Transaksi
INSERT INTO Transaksi (ID_Transaksi, ID_Admin, ID_Pelanggan, Tgl_Masuk, Tgl_Selesai, Tgl_Bayar, Metode, STATUS, Total_Harga)
VALUES 
('TR001', 'KA001', 'PL001', '2025-04-10', '2025-04-12', '2025-04-12', 'Tunai', 'Lunas', 19000),
('TR002', 'KA002', 'PL002', '2025-04-11', '2025-04-13', NULL, NULL, 'Belum Bayar', 27000),
('TR003', 'KA001', 'PL003', '2025-04-13', '2025-04-14', NULL, NULL, 'Belum Bayar', 20000),
('TR004', 'KA002', 'PL004', '2025-04-14', '2025-04-16', NULL, NULL, 'Belum Bayar', 14250),
('TR005', 'KA001', 'PL005', '2025-04-15', '2025-04-16', '2025-04-15', 'Tunai', 'Lunas', 21000);

-- Data Detail Transaksi
INSERT INTO Detail_Transaksi (ID_Transaksi, ID_Layanan, ID_Barang, Berat, Harga_PerKg)
VALUES 
('TR001', 'LY001', 'BR001', 2.0, 5000),  -- 10.000
('TR001', 'LY002', 'BR002', 1.5, 6000),  -- 9.000 → Total 19.000
('TR002', 'LY003', 'BR003', 3.0, 9000),  -- 27.000
('TR003', 'LY001', 'BR001', 1.0, 5000),  -- 5.000
('TR003', 'LY004', 'BR005', 2.0, 7500),  -- 15.000 → Total 20.000
('TR004', 'LY002', 'BR004', 1.5, 9500),  -- 14.250
('TR005', 'LY003', 'BR002', 2.0, 6000),  -- 12.000
('TR005', 'LY003', 'BR003', 1.5, 6000);  -- 9.000 → Total 21.000


-- --------------
-- Nampilin TABEL
-- --------------
SELECT * FROM Karyawan;
SELECT * FROM Pelanggan;
SELECT * FROM Barang;
SELECT * FROM Layanan;
SELECT * FROM Transaksi_Layanan_Barang;
SELECT * FROM Transaksi;
SELECT * FROM Detail_Transaksi;

-- ---------------
-- Hapus DATABASE
-- ---------------
DROP DATABASE Laundry;

-- Tugas VIEW 1
CREATE VIEW View_Transaksi_Dan_Pelanggan AS
SELECT 
    T.ID_Transaksi,
    T.Tgl_Masuk,
    T.Tgl_Selesai,
    T.Status,
    P.Nama AS Nama_Pelanggan,
    P.Alamat,
    P.Telepon
FROM Transaksi T
JOIN Pelanggan P ON T.ID_Pelanggan = P.ID_Pelanggan;
SELECT * FROM View_Transaksi_Dan_Pelanggan;
DROP VIEW View_Transaksi_Dan_Pelanggan;

-- Tugas VIEW 2
CREATE VIEW View_Detail_Transaksi_Lengkap AS
SELECT 
    DT.ID_Detail,
    T.ID_Transaksi,
    P.Nama AS Nama_Pelanggan,
    B.Nama_Barang,
    L.Nama_Layanan,
    DT.Berat,
    DT.Harga_PerKg,
    DT.Total
FROM Detail_Transaksi DT
JOIN Transaksi T ON DT.ID_Transaksi = T.ID_Transaksi
JOIN Pelanggan P ON T.ID_Pelanggan = P.ID_Pelanggan
JOIN Barang B ON DT.ID_Barang = B.ID_Barang
JOIN Layanan L ON DT.ID_Layanan = L.ID_Layanan;
SELECT * FROM View_Detail_Transaksi_Lengkap;

-- Tugas VIEW 3
CREATE VIEW View_Transaksi_Belum_Bayar AS
SELECT 
    T.ID_Transaksi,
    P.Nama AS Nama_Pelanggan,
    T.Tgl_Masuk,
    T.Tgl_Selesai,
    T.Status,
    T.Total_Harga
FROM Transaksi T
JOIN Pelanggan P ON T.ID_Pelanggan = P.ID_Pelanggan
WHERE T.Status = 'Belum Bayar';
SELECT * FROM View_Transaksi_Belum_Bayar;
DROP VIEW View_Transaksi_Belum_Bayar;

-- Tugas VIEW 4
CREATE VIEW View_Agregat_Transaksi_Per_Layanan AS
SELECT 
    L.Nama_Layanan,
    COUNT(DT.ID_Detail) AS Jumlah_Transaksi,
    SUM(DT.Total) AS Total_Pendapatan,
    AVG(DT.Total) AS Rata_Rata_Pendapatan,
    MIN(DT.Total) AS Transaksi_Terkecil,
    MAX(DT.Total) AS Transaksi_Tertinggi
FROM Detail_Transaksi DT
JOIN Layanan L ON DT.ID_Layanan = L.ID_Layanan
GROUP BY L.Nama_Layanan;
SELECT * FROM View_Agregat_Transaksi_Per_Layanan;

-- Tugas VIEW 5
CREATE VIEW View_Ranking_Pelanggan_Berdasarkan_Pengeluaran AS
SELECT 
    P.ID_Pelanggan,
    P.Nama AS Nama_Pelanggan,
    COUNT(T.ID_Transaksi) AS Jumlah_Transaksi,
    SUM(T.Total_Harga) AS Total_Pengeluaran
FROM Transaksi T
JOIN Pelanggan P ON T.ID_Pelanggan = P.ID_Pelanggan
WHERE T.Status = 'Lunas'
GROUP BY P.ID_Pelanggan, P.Nama
ORDER BY Total_Pengeluaran DESC;
SELECT * FROM View_Ranking_Pelanggan_Berdasarkan_Pengeluaran;