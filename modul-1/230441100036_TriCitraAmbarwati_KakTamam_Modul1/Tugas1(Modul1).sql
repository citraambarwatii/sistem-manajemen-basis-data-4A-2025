-- buat database
CREATE DATABASE Akademik;
USE Akademik;

-- buat tabel dan atribut 
-- TABEL MAHASISWA
CREATE TABLE Mahasiswa (
    NIM CHAR(12) PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Jenis_Kelamin ENUM('L', 'P'),
    Alamat TEXT
);

-- TABEL DOSEN
CREATE TABLE Dosen (
    NIP CHAR(18) PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Telepon VARCHAR(15)
);

-- TABEL RUANGAN
CREATE TABLE Ruangan (
    Kode_Ruangan CHAR(10) PRIMARY KEY,
    Nama_Ruangan VARCHAR(50) NOT NULL,
    Kapasitas INT CHECK (Kapasitas > 0)
);

-- TABEL MATAKULIAH
CREATE TABLE MataKuliah (
    Kode_MK CHAR(10) PRIMARY KEY,
    Nama_MK VARCHAR(100) NOT NULL,
    SKS INT CHECK (SKS > 0),
    Semester INT CHECK (Semester BETWEEN 1 AND 8),
    NIP CHAR(18),
    Kode_Ruangan CHAR(10),
    FOREIGN KEY (NIP) REFERENCES Dosen(NIP) ON DELETE SET NULL,
    FOREIGN KEY (Kode_Ruangan) REFERENCES Ruangan(Kode_Ruangan) ON DELETE SET NULL
);

-- TABEL KRS
CREATE TABLE KRS (
    ID_KRS INT AUTO_INCREMENT PRIMARY KEY,
    NIM CHAR(12),
    Kode_MK CHAR(10),
    Semester INT,
    Tahun_Akademik VARCHAR(10),
    FOREIGN KEY (NIM) REFERENCES Mahasiswa(NIM) ON DELETE CASCADE,
    FOREIGN KEY (Kode_MK) REFERENCES MataKuliah(Kode_MK) ON DELETE CASCADE
);

-- isi data mhs
INSERT INTO Mahasiswa (NIM, Nama, Jenis_Kelamin, Alamat) VALUES
('230441100134', 'Muhammad Rifky Awaludin', 'L', 'Madiun'),
('230441100022', 'Lanny Aprilis', 'P', 'Sidoarjo'),
('230441100007', 'Khusnur Faizah', 'P', 'Surabaya'),
('230441100071', 'Ananda Ekawati', 'P', 'Sumenep'),
('230441100088', 'Mei Friska', 'P', 'Tuban'),
('230441100099', 'Qurrotul Aini', 'P', 'Sampang'),
('230441100040', 'Sesilia Febi Diyantika', 'P', 'Lamongan'),
('230441100091', 'Diah Ayu Nurmala', 'P', 'Tuban'),
('230441100180', 'Waldhan Putranda Pratama', 'L', 'Depok'),
('230441100142', 'Dio Ramadhani Pratama Purwono', 'L', 'Pamekasan');

-- isi data dosen
INSERT INTO Dosen (NIP, Nama, Email, Telepon) VALUES
('197509092002121001', 'Dr. Budi Dwi Satoto, S.T., M.Kom.', 'budids@trunojoyo.ac.id', '081332217755'),
('197709212008122002', 'Dr. Yeni Kustiyahningsih, S.Kom., M.Kom.', 'ykustiyahningsih@trunojoyo.ac.id', '082139239387'),
('198003212008011008', 'Mohammad Syarief, S.T., M.Cs.', 'Mohammad.syarief@trunojoyo.ac.id', '087839323211'),
('196901152003121001', 'Muhammad Ali Syakur, S.T., M.T', 'alisyakur@trunojoyo.ac.id', '081216510710'),
('197601202001121001', 'Firli Irhamni, S.T., M.Kom.', 'firli.irhamni@trunojoyo.ac.id', '08123025385'),
('198308282008122002', 'Sri Herawati, S.Kom., M.Kom.', 'sriherawati@trunojoyo.ac.id', '081703045142'),
('198711272014042001', 'Novi Prastiti, S.Kom., M.Kom.', 'prastitinovi@trunojoyo.ac.id', '0812216090242'),
('197906052003122003', 'Eza Rahmanita, S.T., M.T.', 'eza_rahmanita@trunojoyo.ac.id', '085850001918'),
('198507212014042001', 'Imamah, S.Kom., M.Kom', 'i2m@trunojoyo.ac.id', '085232828220'),
('197809262006041001', 'Dr. Wahyudi Setiawan, S.Kom, M.Kom', 'wsetiawan@trunojoyo.ac.id', '085232353693');

-- isi data ruang
INSERT INTO Ruangan (Kode_Ruangan, Nama_Ruangan, Kapasitas) VALUES
('R101', 'Lab BIS', 40),
('R102', 'Lab SI', 45),
('R103', '307', 50),
('R104', '308', 50),
('R105', '407', 50),
('R106', '408', 50);

-- isi data matkul
INSERT INTO MataKuliah (Kode_MK, Nama_MK, SKS, Semester, NIP, Kode_Ruangan) VALUES
('MK001', 'Pemrograman Berbasis Web', 4, 2, '197601202001121001', 'R101'),
('MK002', 'Pengantar Basis Data', 3, 2, '197509092002121001', 'R102'),
('MK003', 'Desain Manajemen Jaringan', 3, 2, '198711272014042001', 'R102'),
('MK004', 'Sistem Manajemen Basis Data', 4, 4, '198003212008011008', 'R103'),
('MK005', 'Implementasi Dan Pengujian Perangkat Lunak', 3, 4, '197709212008122002', 'R104'),
('MK006', 'Perencanaan Sumber Daya Perusahaan', 3, 4, '197906052003122003', 'R105'),
('MK007', 'Pemrograman Bergerak', 4, 4, '198507212014042001', 'R101'),
('MK008', 'Manajemen Proyek TI', 3, 4, '196901152003121001', 'R106'),
('MK009', 'Data Mining', 3, 4, '197809262006041001', 'R103'),
('MK0010', 'Sistem Pendukung Keputusan', 3, 4, '198308282008122002', 'R104');

-- isi data krs
INSERT INTO KRS (NIM, Kode_MK, Semester, Tahun_Akademik) VALUES
('230441100134', 'MK005', 4, '2024/2025'),
('230441100088', 'MK006', 4, '2024/2025'),
('230441100099', 'MK007', 4, '2024/2025'),
('230441100180', 'MK008', 4, '2024/2025'),
('230441100022', 'MK009', 4, '2024/2025');

-- nampilin
SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM Ruangan;
SELECT * FROM MataKuliah;
SELECT * FROM Rekap_KRS;


-- ubah nama tabel
RENAME TABLE KRS TO Rekap_KRS;

-- hps database
DROP DATABASE Akademik;
