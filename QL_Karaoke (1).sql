create database QL_Karaoke
Use QL_Karaoke

CREATE TABLE LoaiKhach (
    MaLoaiKhach CHAR(15) PRIMARY KEY NOT NULL,
    TenLoaiKhach VARCHAR(50)
);

CREATE TABLE Khach (
    MaKhach CHAR(15) PRIMARY KEY NOT NULL, --Nên nhập tay kiểu mã CCCD
    TenKhach VARCHAR(50),
    SDT VARCHAR(15),
    DiaChi VARCHAR(100),
	Email VARCHAR(100),
	TaiKhoan VARCHAR(100), --Hoặc CCCD chỗ này
	MatKhau VARCHAR(100),
    MaLoaiKhach CHAR(15) ,
);

CREATE TABLE KhuyenMai (
    MaKhuyenMai CHAR(15) PRIMARY KEY NOT NULL,
    TenKhuyenMai VARCHAR(50),
    GiamGia DECIMAL(5, 2) DEFAULT 0 CHECK (GiamGia BETWEEN 0 AND 100), -- Phần trăm giảm giá
    NgayBatDau DATE,
    NgayKetThuc DATE,
    MaLoaiKhach CHAR(15) , --Loại khách vip mới ducowj áp dụng khuyến mãi
);

CREATE TABLE PhieuDatPhong (
    MaPhieuDatPhong CHAR(15) PRIMARY KEY NOT NULL,
    NgayDat DATE,
    GioDat TIME,
    MaKhuyenMai CHAR(15) ,
    TinhTrang VARCHAR(20) DEFAULT 'Chua xac nhan',
	MaKhach CHAR(15),
    MaPhong CHAR(15),
);

CREATE TABLE Phong (
    MaPhong CHAR(15) PRIMARY KEY NOT NULL,
    TenPhong VARCHAR(50),
    LoaiPhong VARCHAR(20) NOT NULL, -- Ví dụ: VIP, Thường
    GiaPhong FLOAT NOT NULL,
    TrangThai VARCHAR(20) DEFAULT 'Trống' -- Trạng thái: Trống, Đang sử dụng, Bảo trì
);

CREATE TABLE ThietBi (
    MaThietBi CHAR(15) PRIMARY KEY NOT NULL,
    TenThietBi VARCHAR(50),
    MoTa VARCHAR(100)
);

CREATE TABLE ThietBi_Phong (
    MaPhong CHAR(15) , 
    SoLuong INT,
    PRIMARY KEY (MaPhong, MaThietBi),
	MaThietBi CHAR(15) 
);

CREATE TABLE NhanVien (
    MaNhanVien CHAR(15) PRIMARY KEY NOT NULL,
    TenNhanVien VARCHAR(50),
    ChucVu VARCHAR(30), --Lễ tân, Bảo vệ, Quản lý, ...
    Luong FLOAT,
	SDT VARCHAR(15),
    DiaChi VARCHAR(100),
	Email VARCHAR(100),
	TaiKhoan VARCHAR(100),
	MatKhau VARCHAR(100),
);

CREATE TABLE HoaDon (
    MaHoaDon CHAR(15) PRIMARY KEY NOT NULL,  
    NgayLap DATE,
    TongTien FLOAT,
	MaPhieuDatPhong CHAR(15),
    MaNhanVien CHAR(15)
);

CREATE TABLE ChiTietHoaDon (
	MaCTHD CHAR(15) PRIMARY KEY NOT NULL,
    SoLuong INT,
    ThanhTien FLOAT,
	MaHoaDon CHAR(15) ,
    MaDichVu CHAR(15) 
);

CREATE TABLE DichVu (
    MaDichVu CHAR(15) PRIMARY KEY NOT NULL,
    TenDichVu VARCHAR(50),
    DonGia FLOAT
);


ALTER TABLE Khach
ADD CONSTRAINT FK_Khach_LoaiKhach FOREIGN KEY (MaLoaiKhach) REFERENCES LoaiKhach(MaLoaiKhach);

ALTER TABLE KhuyenMai
ADD CONSTRAINT FK_KhuyenMai_LoaiKhach FOREIGN KEY (MaLoaiKhach) REFERENCES LoaiKhach(MaLoaiKhach);

ALTER TABLE PhieuDatPhong
ADD CONSTRAINT FK_PhieuDatPhong_KhuyenMai FOREIGN KEY (MaKhuyenMai) REFERENCES KhuyenMai(MaKhuyenMai);
ALTER TABLE PhieuDatPhong
ADD CONSTRAINT FK_PhieuDatPhong_Khach FOREIGN KEY (MaKhach) REFERENCES Khach(MaKhach);

ALTER TABLE PhieuDatPhong
ADD CONSTRAINT FK_PhieuDatPhong_Phong FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong);

ALTER TABLE ThietBi_Phong
ADD CONSTRAINT FK_ThietBi_Phong_Phong FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong);

ALTER TABLE ThietBi_Phong
ADD CONSTRAINT FK_ThietBi_Phong_ThietBi FOREIGN KEY (MaThietBi) REFERENCES ThietBi(MaThietBi);

ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDon_PhieuDatPhong FOREIGN KEY (MaPhieuDatPhong) REFERENCES PhieuDatPhong(MaPhieuDatPhong);
ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDon_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien);

ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT FK_ChiTietHoaDon_HoaDon FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon);
ALTER TABLE ChiTietHoaDon
ADD CONSTRAINT FK_ChiTietHoaDon_DichVu FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu);

	