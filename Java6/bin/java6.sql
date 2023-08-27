use master
go
drop database if exists J6Book
go
CREATE DATABASE J6Book
GO
USE J6Book
GO

/****** Object:  Table [dbo].[Accounts]    Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Accounts](
	[Id][nvarchar](50) not null primary key,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Fullname] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Photo] [nvarchar](50) NOT NULL,
	[Gender] [bit],
	[Address] [nvarchar](255),
	[Phone] [varchar](10),
	[Date] [date]
)	
GO

/****** Object:  Table [dbo].[Accounts_roles]    Script Date: 23/7/2023 ******/
CREATE TABLE [dbo].[Accounts_roles](
	[Id][int] IDENTITY not null primary key,
	[Account_id][nvarchar](50) not null,
	[Roles_id][int]
);

/****** Object:  Table [dbo].[Roles]     Script Date: 23/7/2023 ******/
CREATE TABLE [dbo].[Roles](
	[Id][int] IDENTITY not null primary key,
	[Name][nvarchar](50) not null
);


/****** Object:  Table [dbo].[Books]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Books](
	[Id] [nvarchar](50) not null primary key,
	[Name] [nvarchar](255) not null,
	[Image] [nvarchar](max) not null,
	[Price] [float] not null,
	[Author] [nvarchar](255) not null,
	[PageCount][int] not null,
	[Description][nvarchar](max) not null,
	[Publication_date][date],
	[Publisher][nvarchar] (50) not null,
	[Stock_quantity] [int] not null,
	[Available] [bit] not null,
	[genres_id][nvarchar](50) not null
)
GO
/****** Object:  Table [dbo].[States]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[States](
	[Id][int] not null primary key,
	[Name][nvarchar](50) not null
)
/****** Object:  Table [dbo].[Order]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Orders](
	[Id][int] IDENTITY not null primary key,
	[Account_id] [nvarchar](50),
	[Date][Date] not null,
	[Discount_id][int] not null,
	[Shipper_id][int] not null,
	[State_id][int] not null
)
GO
/****** Object:  Table [dbo].[Order_detatils]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Orders_details](
	[Id][nvarchar](50) not null primary key,
	[Order_id][int] not null,
	[Book_id][nvarchar](50) not null,
	[Price][float]
)
GO
/****** Object:  Table [dbo].[Discounts]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Discounts](
	[Id][int] IDENTITY not null primary key,
	[Name][nvarchar](50) not null,
	[Value][float]
)
GO
/****** Object:  Table [dbo].[Account_Discounts]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Accounts_discounts](
	[Account_id][nvarchar](50) not null,
	[Discount_id][int] not null
)
GO

/****** Object:  Table [dbo].[Books_Discounts]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Books_discounts](
	[Book_id][nvarchar](50) not null primary key,
	[Discount_id][int] not null
)
GO
/****** Object:  Table [dbo].[Books_Genres]     Script Date: 18/7/2023 ******/
--CREATE TABLE [dbo].[Books_genres](
--	[Book_id][nvarchar](50) not null primary key,
--	[Genres_id][nvarchar](50) not null
--)
--GO
/****** Object:  Table [dbo].[Genres]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Genres](
	[Id][nvarchar](50) not null primary key,
	[Genres][nvarchar](50) not null
)
GO
/****** Object:  Table [dbo].[Reviews]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Reviews](
	[Id][int] IDENTITY not null primary key,
	[Book_id][nvarchar](50) not null,
	[Account_id][nvarchar](50) not null,
	[review][nvarchar](max),
	[Date][Date] not null,
	[rating][int] null
)
GO

/****** Object:  Table [dbo].[Author]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Authors](
	[Id] [int] IDENTITY not null primary key,
	[Name][nvarchar](50) not null,
	[CompanyName][nvarchar](50) not null
)
GO

/****** Object:  Table [dbo].[Publisher]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Publishers](
	[Id][nvarchar](50) not null primary key,
	[Name][nvarchar](50) not null
)
GO

/****** Object:  Table [dbo].[Shippers]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Shippers](
	[Id][int] IDENTITY not null primary key,
	[Name][nvarchar](50) not null,
	[birthday][date] not null,
	[Phone][varchar](10) not null
)
GO

/****** Object:  Table [dbo].[Books_rank]     Script Date: 18/7/2023 ******/
CREATE TABLE [dbo].[Books_rank](
	[Books_id][nvarchar](50) not null,
	[Name][nvarchar](50) not null,
	[Rate][nvarchar],
	[Sold][int],
	[Genres][nvarchar](50)
)
GO

CREATE TABLE [dbo].[wishlist](
	[wlid] [int] IDENTITY not null primary key,
	[Books_id] [nvarchar](50) not null,
	[Account_id][nvarchar](50) not null,
	[Quantity] int not null
)
GO



/***********************************/

Alter table Accounts_roles
ADD CONSTRAINT FK_Accounts_Accounts_roles FOREIGN KEY(Account_id) REFERENCES Accounts(Id);
ALTER TABLE Accounts_roles
ADD CONSTRAINT FK_Roles_Accounts_roles FOREIGN KEY(Roles_id) REFERENCES Roles(Id);

Alter table Accounts_discounts
ADD CONSTRAINT FK_Accounts_Accounts_discounts FOREIGN KEY(Account_id) REFERENCES Accounts(Id);
ALTER TABLE Accounts_discounts
ADD CONSTRAINT FK_Discounts_Accounts_discounts FOREIGN KEY(Discount_id) REFERENCES Discounts(Id);


ALTER TABLE Orders
ADD CONSTRAINT FK_States_Orders FOREIGN KEY(State_id) REFERENCES States(Id);

ALTER TABLE Orders_details
ADD CONSTRAINT FK_Orders_Orders_details FOREIGN KEY(Order_id) REFERENCES Orders(Id);
ALTER TABLE Orders_details
ADD CONSTRAINT FK_Books_Orders_details FOREIGN KEY(Book_id) REFERENCES Books(Id);

Alter table Reviews
ADD CONSTRAINT FK_Accounts_Reviews FOREIGN KEY(Account_id) REFERENCES Accounts (Id);
ALTER TABLE Reviews
ADD CONSTRAINT FK_Books_Reviews FOREIGN KEY(Book_id) REFERENCES Books(Id);

Alter table Orders 
ADD CONSTRAINT FK_Accounts_Orders FOREIGN KEY(Account_id) REFERENCES Accounts(Id);
ALTER TABLE Orders
ADD CONSTRAINT FK_Discounts_Orders FOREIGN KEY(Discount_id) REFERENCES Discounts(Id);
ALTER TABLE Orders
ADD CONSTRAINT FK_Shippers_Orders FOREIGN KEY(Shipper_id) REFERENCES Shippers(Id);


ALTER TABLE Books_discounts
ADD CONSTRAINT FK_Books_Books_discounts FOREIGN KEY(Book_id) REFERENCES Books(Id);
ALTER TABLE Books_Discounts
ADD CONSTRAINT FK_Discounts_Books_Discount FOREIGN KEY(Discount_id) REFERENCES Discounts(Id);

ALTER TABLE Books
ADD CONSTRAINT FK_Genres_Books FOREIGN KEY(genres_id) REFERENCES Genres(id);

	
Alter table wishlist
ADD CONSTRAINT FK_Accounts_wishlist FOREIGN KEY(Account_id) REFERENCES Accounts (Id);
ALTER TABLE wishlist
ADD CONSTRAINT FK_Books_wishlist FOREIGN KEY(Books_id) REFERENCES Books(Id);

/************************ INSETY TABLE ACCOUNTS *********************************************/
INSERT [dbo].[Accounts](Id, Username, Password, Fullname, Email, Photo, Gender,Address,Phone,Date)  values 
	('AC0001','phongvto','123123',N'Võ Thanh Phong','vothanhphong2000bt@gmail.com','phong.png',1,N'Tân Chánh Hiệp, Hồ Chí Minh','0969023190','2004-09-09'),
	('AC0002','huyento','RRRRAW',N'Nguyễn Tiến Anh','anhntps10770@fpt.edu.vn','anh.png',1,N'Đường Giải Phóng, Phường Tân Lợi, Thành phố Buôn Ma Thuật, Đắk LắK','0909331232','2003-08-28'),
	('AC0003','chaulnn','KBTHDO',N'Lê Nguyễn Ngọc Châu','chaulnnps10835@fpt.edu.vn','chau.png',0,N'Xuân Phong, Xã Hợp Phong, Huyện Cao Phong, Hòa Bình','0904071234','2003-10-28'),
	('AC0004','cuonglc','UDEKRE',N'Lý Chí Cường','cuonglcps10817@fpt.edu.vn','cuong.png',1,N'Văn Nhuệ, Ân Thi - Hưng Yên','0908765437','2003-09-18'),
	('AC0005','datnv','KRMGZY',N'Nguyễn Vũ Đạt','datnvps10930@fpt.edu.vn','dat.png',1,N'Phường 24, Quận Bình Thạnh, TP.HCM','0355204677','2003-01-01'),
	('AC0006','ducnp','ALGPRW',N'Nguyễn Phúc Đức','ducnpps10800@fpt.edu.vn','duc.png',1,N'Xã Đức Hòa Đông, Huyện Đức Hòa,Long An','0932012782','2003-01-01'),
	('AC0007','duytk','NBQYWX',N'Trần Khánh Duy','duytkps10303@fpt.edu.vn','duy.png',1,N'885 Trường Chinh, P.Tây Thạnh, Q.Tân Phú','0923674674','2003-02-12'),
	('AC0008','huynt','HWKZUJ',N'Nguyễn Thanh Huy','huyntps10808@fpt.edu.vn','huy.png',1,N'Vàm Bi, Xã Trường Long, Huyện Phong Điền, Cần Thơ','0346790933','2003-04-17'),
	('AC0009','khaihc','CVSBQS',N'Hoàng Cao Khải','khaihcps10763@fpt.edu.vn','khai.png',1,N'Phường Phước Ninh, Quận Hải Châu','0374567239','2003-05-06'),
	('AC0010','luudp','QUZEKB',N'Đào Phong Lưu','luudpps10344@fpt.edu.vn','luu.png',1,N'43 đường  Nguyễn Chí Diểu, Phường An Hải Bắc, Quận Sơn Trà, Đà Nẵng','0937846746','2003-12-12');

INSERT [dbo].[Roles](Name) values 
	('Administrator'),
	('User'),
	('Guest')

INSERT [dbo].[Accounts_roles](Account_id,Roles_id) values 
	('AC0001', 1),
	('AC0002', 2),
	('AC0003', 2),
	('AC0004', 2),
	('AC0005', 2),
	('AC0006', 2),
	('AC0007', 2),
	('AC0008', 2),
	('AC0009', 2),
	('AC0010', 2)

/************************ INSETY TABLE GENRES *********************************************/
INSERT [dbo].[Genres](Id, Genres)values
	(1,N'Tiểu Thuyết'),
	(2,N'Truyện Ngắn - Tản Văn'),
	(3,N'Light Novel'),
	(4,N'Ngôn tình'),
	(5,N'Nhân Vật - Bài Học Kinh Doanh'),
	(6,N'Quản Trị - Lãnh Đạo'),
	(7,N'Marketing - Bán Hàng'),
	(8,N'Phân Tích Kinh Tế'),
	(9,N'Kỹ Năng Sống'),
	(10,N'Rèn Luyện Nhân Cách'),
	(11,N'Tâm Lý'),
	(12,N'Sách Cho Tuổi Mới Lớn'),
	(13,N'Cẩm Nang Làm Cha Mẹ'),
	(14,N'Phương Pháp Giáo Dục Trẻ Các Nước'),
	(15,N'Phát Triển Trí Tuệ Cho Trẻ'),
	(16,N'Phát Triển Kỹ Năng Cho Trẻ'),
	(17,N'Manga - Comic'),
	(18,N'Kiến Thức Bách Khoa'),
	(19,N'Sách Kỹ Năng Sống Cho Trẻ'),
	(20,N'Vừa Học Vừa Chơi Với Trẻ'),
	(21,N'Câu Chuyện Cuộc Đời'),
	(22,N'Chính Trị'),
	(23,N'Kinh Tế'),
	(24,N'Nghệ Thuật - Giải Trí'),
	(25,N'Sách Giáo Khoa'),
	(26,N'Sách Tham Khảo'),
	(27,N'Luyện Thi THPT Quốc Gia'),
	(28,N'Mẫu Giáo'),
	(29,N'Tiếng Anh'),
	(30,N'Tiếng Nhật'),
	(31,N'Tiếng Hoa'),
	(32,N'Tiếng Hàn');


INSERT [dbo].[Books](Id, Name, Price, Author, PageCount, Description, Publication_date, Publisher, Stock_quantity, Available, Image, genres_id) values
	-- Tiểu thuyết
	('BK00001',N'Cây cam ngọt của tôi',86400,N'José Mauro de Vasconcelos',244,N'Mở đầu bằng những thanh âm trong sáng và kết thúc lắng lại trong những nốt trầm hoài niệm, Cây cam ngọt của tôi khiến ta nhận ra vẻ đẹp thực sự của cuộc sống đến từ những điều giản dị như bông hoa trắng của cái cây sau nhà, và rằng cuộc đời thật khốn khổ nếu thiếu đi lòng yêu thương và niềm trắc ẩn. Cuốn sách kinh điển này bởi thế không ngừng khiến trái tim người đọc khắp thế giới thổn thức, kể từ khi ra mắt lần đầu năm 1968 tại Brazil.',N'2020',N'NXB Hội Nhà Văn',100,1,'book1.jpg',1),	
	('BK00002',N'Chưa Kịp Lớn Đã Trưởng Thành (Tái Bản 2023)',55300,N'Tớ Là Mây',240,N'Chúng ta của hiện tại, đều chưa kịp lớn đã phải trưởng thành.

Lúc còn nhỏ có thể khóc cười tuỳ ý. Trưởng thành rồi mới biết hành động cũng cần nhìn sắc mặt người khác.

Lúc còn nhỏ có thể sống vô tư, vô lo. Trưởng thành rồi mới biết nếu chậm chân hơn người khác, chắc chắn sẽ bị đào thải bất cứ lúc nào.

Lúc còn nhỏ có thể khao khát, mơ mộng. Trưởng thành rồi mới biết thế giới ngoài kia thực sự rất tàn khốc.',N'2023',N'Dân Trí',100,1,'book2.jpg',1),
	('BK00003',N'Nhà Giả Kim (Tái Bản 2020)',55300,N'Paulo Coelho',227,N'Tất cả những trải nghiệm trong chuyến phiêu du theo đuổi vận mệnh của mình đã giúp Santiago thấu hiểu được ý nghĩa sâu xa nhất của hạnh phúc, hòa hợp với vũ trụ và con người. ',N'2020',N'NXB Hội Nhà Văn',100,1,'book3.jpg',1),
	('BK00004',N'Ngôi Nhà Kỳ Quái',103500,N'Uketsu',284,N'Thoạt nhìn, có lẽ trông nó cũng như bao ngôi nhà bình thường khác. Tuy nhiên, nếu để ý và săm soi tới từng ngóc ngách, bạn sẽ nhận thấy cảm giác khó chịu kỳ quái hiện diện ở khắp nơi trong nhà. Những sự kỳ quái đó cứ chồng chéo lên nhau để rồi cuối cùng dẫn đến một “sự thật”...',N'2022',N'Phụ Nữ Việt Nam',100,1,'book4.jpg',1),
	-- Truyện ngắn
	('BK00005',N'Nằm Nghe Gió Thổi Sau Hè',130500,N'Hải Dương',164,N'Nằm nghe gió thổi sau hè xoay quanh câu chuyện tuổi thơ của nhân vật Mận với những kỷ niệm về trái sim tím căng mọng, bông dủ dẻ vàng ươm, chùm lá sương sâm xanh mướt, hay những ngày rong ruổi trên cánh đồng với con diều giấy…',N'2023',N'Văn Học',100,1,'book5.jpg',2),
	('BK00006',N'Đời Có Mấy Tý, Sao Phải Nghĩ (Tái Bản 2023)',71100,N'NVCS Entertainment',272,N'Nhà Văn Cục Súc được biết tới là một blogger sở hữu những bài post nghìn like cùng nhiều câu nói hot trend có phần cục súc, hài hước và thú vị được đăng tải trên fanpage cùng tên với hơn 1 triệu lượt theo dõi.',N'2023',N'Hà Nội',100,1,'book6.jpg',2),
	('BK00007',N'Tuổi 40 Yêu Dấu (Tái Bản 2023)',99000,N'Ann Lee',208,N'Ann Lee đã tự hứa với bản thân, với những phụ nữ-bạn bè mình, rằng sẽ ghi lại những tươi trẻ nồng nhiệt hay lắng đọng ngọt ngào của phụ nữ thường chỉ nhớ ra mình đáng yêu và đáng được yêu khi đã còn rất ít thời gian hay sức lực',N'2023',N'Trẻ',100,1,'book7.jpg',2),
	('BK00008',N'The Journey Into Summer - Chưa Kịp Lớn Đã Phải Trưởng Thành - Quyển 2 - Phiên Bản Mùa Hè',71100,N'Amy Trương',224,N'Amy Trương - Một cô gái thích tận hưởng những điều bình dị trong cuộc sống thường nhật, thích viết lách, mộng mơ và dịu dàng. Cô ấy thích kể những câu chuyện, những nỗi niềm của những “người lớn tập sự" qua từng trang sách.',N'2023',N'Dân Trí',100,1,'book8.jpg',2),
	-- Light Novel
	('BK00009',N'Re:Zero - Bắt Đầu Lại Ở Thế Giới Khác - Tập 15 - Tặng Kèm Bookmark PVC In Màu',102000,N'Tappei Nagatsuki, Shinichirou Otsuka',418,N'Tập 15 là tập kết thúc arc Thánh vực. Kết thúc này được lột tả bằng hai điểm đặc trưng: một là rất nhiều cảnh hành động, hai là hội thoại rất buồn cười.',N'2023',N'Hồng Đức',100,1,'book9.jpg',3),
	('BK00010',N'Nhân Vật Hạ Cấp Tomozaki - Tập 5 - Bản Giới Hạn - Tặng Thẻ Normal + Thẻ Rare + Sổ Xé',111000,N'Yuki Yaku, Fly',416,N'Sau một vụ việc xảy ra ở lớp, không ngờ giữa tôi và nhóc Tama lại hình thành mối quan hệ thầy trò. Nét mặt, tác phong, cách nói chuyện. Với tư cách sư phụ, tôi truyền thụ cho nhóc Tama những bí quyết và nỗ lực mình đã tích luỹ để trở thành riajuu. Mặt khác, với tính cách vốn có của mình, Hinami đang âm thầm hành động...',N'2022',N'Kim Đồng',100,1,'book10.jpg',3),
	('BK00011',N'Chàng Trai Chuyển Kiếp Và Cô Gái Thiên Tài - Tập 1 - Tặng Kèm 1 Bookmark + 2 Postcard',121500,N'Nora Kohigashi, Kina Kazuharu',261,N'Anya là một thiếu nữ thiên tài với tương lai đầy hứa hẹn. Cô luôn đạt thành tích xuất sắc nhất và là học sinh được ngưỡng mộ ở trường. Vậy nhưng Anya có một đối thủ không thể đánh bại, đó là người bạn thuở nhỏ của cô, Sieg. Vào một ngày mùa đông năm bảy tuổi, khi gặp gỡ lần đầu ở trường luyện thi, Anya đã phớt lờ Sieg, nhưng thái độ của cô thay đổi hoàn toàn sau khi bị cậu vượt mặt trong một bài kiểm tra. Kể từ đó, Anya đã không ngừng thách thức cậu bạn của mình.',N'2023',N'Phụ Nữ Việt Nam',100,1,'book11.jpg',3),
	('BK00012',N'Ma Pháp Thiếu Nữ - Tập 4 - Bản Đặc Biệt - Tặng Kèm Bookmark + Postcard + Móc Khóa',159000,N'Endou Asari, Marui-no',372,N'Trong ‘Dự án đào tạo ma pháp thiếu nữ’ và ‘Dự án đào tạo Ma pháp thiếu nữ Restart’, các ma pháp thiếu nữ đã phải tham gia một trò chơi khắc nghiệt. Để đáp lại niềm yêu mến của độc giả, một tập truyện ngắn đã được xuất bản với sự xuất hiện của toàn bộ 33 ma pháp thiếu nữ.',N'2023',N'Phụ Nữ Việt Nam',100,1,'book12.jpg',3),
	-- Ngôn tình
	('BK00013',N'Khó Dỗ Dành - Tập 2 - Tặng Kèm Bookmark Bồi Cứng',184500,N'Trúc Dĩ',496,N'Ôn Dĩ Phàm và Tang Diên từng là bạn học, hai người tình cờ gặp lại nhau trong một quán bar, sau đó lại tình cờ trở thành bạn thuê trọ chung.',N'2023',N'Văn Học',100,1,'book13.jpg',4),
	('BK00014',N'Khó Dỗ Dành - Tập 1 - Tặng Kèm Bookmark Bồi Cứng',164000,N'Trúc Dĩ',480,N'Ôn Dĩ Phàm và Tang Diên từng là bạn học, hai người tình cờ gặp lại nhau trong một quán bar, sau đó lại tình cờ trở thành bạn thuê trọ chung.',N'2023',N'Văn Học',100,1,'book14.jpg',4),
	('BK00015',N'Vụng Trộm Yêu Anh (Bộ 2 Tập)',211650,N'Trúc Dĩ',888,N'Yêu thầm một người là cảm giác thế nào nhỉ?',N'2021',N'NXB Hà Nội',100,1,'book15.jpg',4),
	('BK00016',N'Hậu Cung Như Ý Truyện - Tập 1 - Tặng Kèm Bookmark Bồi Cứng + Card Nhân Vật',171750,N'Lưu Liễm Tử',472,N'Sau khi vua Ung Chính băng hà, Tứ a ca Hoằng Lịch kế vị, lấy hiệu là Càn Long. Thanh Anh ý thức được vị thế của mình nên quyết định làm theo lời cô mẫu dặn trước khi qua đời để đứng vững trong hậu cung, thành ý của Thanh Anh được Thái hậu chấp thuận và nàng được bà ban tên mới là Như Ý.',N'2022',N'Văn Học',100,1,'book16.jpg',4),
	-- Nhân vật - bài học kinh doanh
	('BK00017',N'Nghĩ Giàu & Làm Giàu (Tái Bản 2020)',77000,N'Napoleon Hill',400,N'Think and Grow Rich - Nghĩ giàu và làm giàu là một trong những cuốn sách bán chạy nhất mọi thời đại. Đã hơn 60 triệu bản được phát hành với gần trăm ngôn ngữ trên toàn thế giới và được công nhận là cuốn sách tạo ra nhiều triệu phú, một cuốn sách truyền cảm hứng thành công nhiều hơn bất cứ cuốn sách kinh doanh nào trong lịch sử.',N'2020',N'NXB Tổng Hợp TPHCM',100,1,'book17.jpg',5),
	('BK00018',N'Từ Tốt Đến Vĩ Đại - Jim Collins (Tái Bản 2021)',91000,N'Jim Collins',484,N'Jim Collins cùng nhóm nghiên cứu đã miệt mài nghiên cứu những công ty có bước nhảy vọt và bền vững để rút ra những kết luận sát sườn, những yếu tố cần kíp để đưa công ty từ tốt đến vĩ đại. Đó là những yếu tố khả năng lãnh đạo, con người, văn hóa, kỷ luật, công nghệ… ',N'2021',N'NXB Trẻ',100,1,'book18.jpg',5),
	('BK00019',N'Những Kẻ Xuất Chúng (Tái Bản 2021)',127200,N'Malcolm Gladwel',416,N'Với giọng văn lôi cuốn và cách kể chuyện hết sức có duyên, Malcom Gladwell cũng viện dẫn rất nhiều giai thoại thú vị như tại sao phần lớn các cậu bé giỏi môn khúc côn cầu lại sinh vào tháng một, tại sao con cái của những người Do Thái nhập cư lại trở thành những luật sư quyền lực nhất New York, tại sao truyền thống văn hóa của nền nông nghiệp lúa nước lại có thể giúp trẻ em châu Á giỏi toán... ',N'2021',N'NXB Thế Giới',100,1,'book19.jpg',5),
	('BK00020',N'Không Bao Giờ Là Thất Bại! Tất Cả Là Thử Thách (Tái Bản 2023)',166400,N'Chung Ju Yung',528,N'Thất bại xảy ra là để con người nhận ra sức mạnh nội tại của bản thân, bởi không ai sống mà chỉ trải qua những thành công trong suốt cuộc đời. Tuy vậy, ta vẫn luôn băn khoăn tự hỏi bản thân rằng bao nhiêu lần thất bại mới đủ để thành công?',N'2023',N'Dân Trí',100,1,'book20.jpg',5),
	-- Quản trị - lãnh đạo
	('BK00021',N'Bí Mật Tư Duy Triệu Phú (Tái Bản 2021)',86400,N'T Harv Eker',287,N'Trong cuốn sách này T. Harv Eker sẽ tiết lộ những bí mật tại sao một số người lại đạt được những thành công vượt bậc, được số phận ban cho cuộc sống sung túc, giàu có, trong khi một số người khác phải chật vật, vất vả mới có một cuộc sống qua ngày. Bạn sẽ hiểu được nguồn gốc sự thật và những yếu tố quyết định thành công, thất bại để rồi áp dụng, thay đổi cách suy nghĩ, lên kế hoạch rồi tìm ra cách làm việc, đầu tư, sử dụng nguồn tài chính của bạn theo hướng hiệu quả nhất.',N'2021',N'NXB Tổng Hợp TPHCM',100,1,'book21.jpg',6),
	('BK00022',N'Nhà Lãnh Đạo Không Chức Danh (Tái Bản 2022)',84000,N'Robin Sharma',272,N'Suốt hơn 15 năm, Robin Sharma đã thầm lặng chia sẻ với những công ty trong danh sách Fortune 500 và nhiều người siêu giàu khác một công thức thành công đã giúp ông trở thành một trong những nhà cố vấn lãnh đạo được theo đuổi nhiều nhất thế giới. Đây là lần đầu tiên Sharma công bố công thức độc quyền này với bạn, để bạn có thể đạt được những gì tốt nhất, đồng thời giúp tổ chức của bạn có thể có những bước đột phá đến một cấp độ thành công mới trong thời đại thiên biến vạn hóa như hiện nay.',N'2022',N'Trẻ',100,1,'book22.jpg',6),
	('BK00023',N'Vị Tu Sĩ Bán Chiếc Ferrari (Tái Bản Từ Cuốn Tìm Về Sức Mạnh Vô Biên) - Tái Bản 2020',78400,N'Robin Sharma',264,N'Vị Tu Sĩ Bán Chiếc Ferarri không phải là một cuốn sách xa lạ, cuốn sách này là một trong những ấn phẩm kinh điển của thế giới về đề tài truyền cảm hứng, theo đuổi lý tưởng sống, và hướng về một cuộc sống hạnh phúc. Đây cũng là cuốn sách đầu tiên mà tác giả, nhà diễn thuyết nổi tiếng thế giới Robin Sharma chấp bút.',N'2020',N'NXB Tổng Hợp TPHCM',100,1,'book23.jpg',6),
	('BK00024',N'Một Đời Quản Trị (Tái Bản 2019)',160000,N'Phan Văn Trường',495,N'Có rất nhiều doanh nhân vĩ đại, những người sáng lập, xây dựng, điều hành những công ty hàng đầu thế giới với doanh thu cả trăm tỷ đô-la Mỹ, những công ty sáng tạo công nghệ và sản phẩm làm thay đổi thế giới, nhưng họ không viết sách dù rằng có nhiều sách viết về họ.',N'2022',N'Trẻ',100,1,'book24.jpg',6),
	-- Marketing - bán hàng
	('BK00025',N'Người Bán Hàng Vĩ Đại Nhất Thế Giới',103600,N'Og Mandino',296,N'"Người Bán Hàng Vĩ Đại Nhất Thế Giới" kể về câu chuyện của Hafid, một cậu bé chăn lạc đà nghèo, ở Jerusalem thời cổ đại.  Xuất thân là một cậu nhóc trông lạc đà cho đoàn buôn của Pathros, nhưng với quyết tâm đổi đời, muốn cải thiện vị trí của mình trong cuộc sống, Hafid luôn nuôi ước mơ được trở thành người bán hàng. Cậu tin chỉ như thế mình mới có cơ hội trở nên giàu có và thành công.',N'2020',N'NXB Tổng Hợp TPHCM',100,1,'book25.jpg',7),
	('BK00026',N'90 - 20 - 30 - 90 Bài Học Vỡ Lòng Về Ý Tưởng Và Câu Chữ (Tái Bản 2021) (Bản Đen Trắng)',165750,N'Huỳnh Vĩnh Sơn',398,N'NGÀNH QUẢNG CÁO QUÁ MAY MẮN. Lúc nào cũng lung linh trong mắt các bạn trẻ yêu sáng tạo. Ai cũng muốn ra trường sẽ hiến bộ não đầy ắp ý tưởng cho một công ty quảng cáo chất chơi nào đó.',N'2021',N'NXB Lao Động',100,1,'book26.jpg',7),
	('BK00027',N'Video Ngắn: Từ Chiến Lược Đến Thực Thi',191200,N'Vũ Diệu Thúy',246,N'Thời đại video ngắn lên ngôi mang theo nhiều cơ hội, cũng là thách thức phải chuyển dịch. Theo kịp xu hướng và thành công vượt trội hoặc trở nên lỗi thời và tụt hậu sa sút, lựa chọn là ở bạn.',N'2023',N'Thanh Niên',100,1,'book27.jpg',7),
	('BK00028',N'Con Đường Trở Thành Freelancer Writer - Tôi Đã Kiếm 800.000.000 Một Năm Từ Viết Lách Như Thế Nào? (Tái Bản)',165000,N'Linh Phan',300,N'CON ĐƯỜNG TRỞ THÀNH FREELANCER WRITER – TÔI ĐÃ KIẾM 800.000.000 MỘT NĂM TỪ VIỆC VIẾT LÁCH NHƯ THẾ NÀO?

TẠI SAO VIẾT HAY NHƯNG VẪN KHÔNG THỂ SỐNG VỚI NGHỀ FREELANCE WRITER?

Làm thế nào để có thể bắt đầu trở thành Freelance Writer?

Làm thế nào để tìm được khách hàng?

Làm thế nào có thể đảm bảo một nguồn thu nhập ổn định?

Tính nhuận bút/thù lao như thế nào cho phù hợp?

Làm thế nào để biến công việc này trở thành nghề nghiệp có thể nuôi sống bản thân hay gia đình thay vì những công việc văn phòng cố định?',N'2021',N'NXB Lao Động',100,1,'book28.jpg',7),
	-- phân tích kinh tế
	('BK00029',N'Chiến Tranh Tiền Tệ - Phần 1 - Ai Thực Sự Là Người Giàu Nhất Thế Giới? (Tái bản 2022)',115500,N'Song Hong Bing',532,N'Một khi đọc “Chiến tranh tiền tệ - Ai thật sự là người giàu nhất thế giới” bạn sẽ phải giật mình nhận ra một điều kinh khủng rằng, đằng sau những tờ giấy bạc chúng ta chi tiêu hàng ngày là cả một thế lực ngầm đáng sợ - một thế lực bí ẩn với quyền lực siêu nhiên có thể điều khiển cả thế giới rộng lớn này.',N'2022',N'NXB Lao Động',100,1,'book29.jpg',8),
	('BK00030',N'Doanh Nghiệp Của Thế Kỷ 21 (Tái Bản 2019)',85000,N'Robert T Kiyosaki, John Fleming, Kim Kiyosaki',260,N'Một quyển sách khác của tác giả bộ sách nổi tiếng Dạy con làm giàu. Trong cuốn sách này, Robert T. Kiyosaki sẽ chỉ ra cho bạn đọc thấy lý do tại sao mình cần phải gây dựng doanh nghiệp riêng của mình và chính xác đó là doanh nghiệp gì. Nhưng đây không phải là việc thay đổi loại hình doanh nghiệp mình đang triển khai mà đó là việc thay đổi chính bản thân. Tác giả còn cho bạn đọc biết cách thức tìm kiếm những gì mình cần để phát triển doanh nghiệp hoàn hảo, nhưng để doanh nghiệp của mình phát triển thì mình cũng sẽ phải phát triển theo.',N'2020',N'NXB Trẻ',100,1,'book30.jpg',8),
	('BK00031',N'Chiến Tranh Tiền Tệ - Phần V (Phần Cuối)',136500,N'Song Hong Bing',684,N'Chiến tranh tiền tệ tập 5 – “Tương lai của tiền tệ thế giới – Bình yêu trước giông bão” là phần cuối cùng trong series đình đám “Chiến tranh tiền tệ” được rất nhiều độc giả yêu thích và đánh giá cao.',N'2022',N'Lao Động',100,1,'book31.jpg',8),
	('BK00032',N'Chiến Tranh Tiền Tệ - Phần 2 - Sự Thống Trị Của Quyền Lực Tài Chính (Tái Bản 2022)',119000,N'Song Hong Bing',632,N'Chiến Tranh Tiền Tệ - Phần 2 - Sự Thống Trị Của Quyền Lực Tài Chính (Tái Bản 2022)',N'2022',N'NXB Lao Động',100,1,'book32.jpg',8),
	-- 
	-- kỹ năng sống
	('BK00033',N'Thay Đổi Cuộc Sống Với Nhân Số Học',173600,N'Lê Đỗ Quỳnh Hương',416,N'Cuốn sách Thay đổi cuộc sống với Nhân số học là tác phẩm được chị Lê Đỗ Quỳnh Hương phát triển từ tác phẩm gốc “The Complete Book of Numerology” của tiến sỹ David A. Phillips, khiến bộ môn Nhân số học khởi nguồn từ nhà toán học Pythagoras trở nên gần gũi, dễ hiểu hơn với độc giả Việt Nam.',N'2020',N'NXB Tổng Hợp TPHCM',100,1,'book33.jpg',9),
	('BK00034',N'Không Phải Sói Nhưng Cũng Đừng Là Cừu',89600,N'Lê Bảo Ngọc',296,N'Không Phải Sói Nhưng Cũng Đừng Là Cừu

SÓI VÀ CỪU - BẠN KHÔNG TỐT NHƯ BẠN NGHĨ ĐÂU!

Làn ranh của việc ngây thơ hay xấu xa đôi khi mỏng manh hơn bạn nghĩ.

Bạn làm một việc mà mình cho là đúng, kết quả lại bị mọi người khiển trách.

Bạn ủng hộ một quan điểm của ai đó, và số đông khác lại ủng hộ một quan điểm trái chiều.',N'2022',N'NXB Thế Giới',100,1,'book34.jpg',9),
	('BK00035',N'Hành Tinh Của Một Kẻ Nghĩ Nhiều',60200 ,N'Amateur Psychology Nguyễn Đoàn Minh Thư',184,N'Hành tinh của một kẻ nghĩ nhiều là hành trình khám phá thế giới nội tâm của một người trẻ. Đó là một hành tinh đầy hỗn loạn của những suy nghĩ trăn trở, những dằn vặt, những cuộc chiến nội tâm, những cảm xúc vừa phức tạp cũng vừa rất đỗi con người. Một thế giới quen thuộc với tất cả chúng ta.',N'2023',N'Thế Giới',100,1,'book35.jpg',9),
	('BK00036',N'Hiểu Về Trái Tim (Tái Bản 2023)',126400,N'Minh Niệm',479,N'“Hiểu về trái tim” là một cuốn sách đặc biệt được viết bởi thiền sư Minh Niệm. Với phong thái và lối hành văn gần gũi với những sinh hoạt của người Việt, thầy Minh Niệm đã thật sự thổi hồn Việt vào cuốn sách nhỏ này.',N'2023',N'Tổng Hợp TPHCM',100,1,'book36.jpg',9),
	-- rèn luyện nhân cách
	('BK00037',N'Đắc Nhân Tâm (Tái Bản 2021)',60200,N'Dale Carnegie',320,N'Đắc nhân tâm của Dale Carnegie là quyển sách của mọi thời đại và một hiện tượng đáng kinh ngạc trong ngành xuất bản Hoa Kỳ. Trong suốt nhiều thập kỷ tiếp theo và cho đến tận bây giờ, tác phẩm này vẫn chiếm vị trí số một trong danh mục sách bán chạy nhất và trở thành một sự kiện có một không hai trong lịch sử ngành xuất bản thế giới và được đánh giá là một quyển sách có tầm ảnh hưởng nhất mọi thời đại.',N'2021',N'NXB Tổng Hợp TPHCM',100,1,'book37.jpg',10),
	('BK00038',N'Sống Có Giá Trị - Nơi Bạn Dừng Chân',52700,N'Nhiều Tác Giả',188,N'Nhằm giúp các bậc cha mẹ hiểu và giúp con cái phát triển tốt hơn, những người làm giáo dục có thể nâng cao khả năng nắm bắt tâm lý và truyền đạt kiến thức tới học trò một cách hiệu quả hơn, bộ sách Sống Có Giá Trị sẽ cung cấp cung cấp cho bạn đọc những kiến thức độc đáo và hữu dụng nhất qua 14 bài học được thực hiện trong 28 ngày. Đó là các bài học về ý chí, kỹ năng được phân tích theo góc nhìn khoa học, đó là những phút lắng lòng để hiểu hơn giá trị thiêng liêng của gia đình hay đơn giản là những dòng hồi ký của một người từng trải qua lá thư viết vội. Bộ sách với những thủ pháp và cách thức trình bày khác nhau để mỗi người đọc đều có thể cảm nhận được giá trị nhân văn trong từng nội dung bài học.',N'2018',N'NXB Tổng Hợp TPHCM',100,1,'book38.jpg',10),
	('BK00039',N'Tủ Sách Rèn Nhân Sách Sống Cho Trẻ - Tinh Thần Tương Thân Tương Ái (Tái Bản 2022)',11.050,N'Vương Nhất Mai, Dương Tư Phàm',16,N'Bộ truyện Tủ sách rèn nhân cách sống cho trẻ xoay quanh cuộc sống của các bạn động vật đáng yêu được nhân hóa. Khi cha mẹ cùng con cái đọc những câu chuyện này, có thể bồi dưỡng EQ, nhân cách, phẩm chất đạo đức, thái độ sống lạc quan… để trẻ tự tin bước vào cuộc sống tương lai một cách đầy nghị lực và vui vẻ. Những đứa trẻ như vậy, chắc chắc chúng sẽ tìm thấy hạnh phúc và có được hạnh phúc đích thực.',N'2022',N'NXB Trẻ',100,1,'book39.jpg',10),
	('BK00040',N'Thuật Hùng Biện',51000,N'Dale Carnegie',248,N'Sự thành công trong kinh doanh, trong các mối quan hệ xã hội, hay ngay cả tronglĩnh vực riêng tức của một người phụ thuộc rất nhiều vào khả năng giao tiếp của người đó, khả năng thể hiện, diễn đạt cho mọi người biết bạn là ai, bạn muốn gì, và bạn tin vào điều gì. ',N'2017',N'NXB Dân Trí',100,1,'book40.jpg',10),
	-- |Tâm lý
	('BK00041',N'Vẻ Đẹp Của Sự Cô Đơn - Tặng Kèm Bookmark',96000,N'Giác Minh Luật',244,N'Mọi lời nói, việc làm đều được chi phối bởi định luật nhân quả, nó là một quy luật rất tự nhiên. Trong tình yêu cũng vậy, nếu chúng ta chỉ vì tham vọng bản thân mà nói, mà làm cho thỏa mãn những ảo mộng ở hiện tại, thì kết quả nhận lại chỉ là sự ca tụng, niềm hoan lạc và cả sự hạnh phúc tạm thời. Và rồi ngay cả khi bạn ngỡ rằng mình đang sống một đời bình yên với những thứ hiện có, sự cô đơn vẫn xâm chiếm và khiến trái tim bạn khổ đau.',N'2023',N'Phụ Nữ Việt Nam',100,1,'book41.jpg',11),
	('BK00042',N'Đứa Trẻ Hiểu Chuyện Thường Không Có Kẹo Ăn',103600,N'Nguyên Anh',368,N'“Đứa trẻ hiểu chuyện thường không có kẹo ăn” – Cuốn sách dành cho những thời thơ ấu đầy vết thương.

Trên đời này có một điều rất kỳ diệu, đó là bậc phụ huynh nào cũng mong muốn con mình trở nên hoàn hảo theo một hình mẫu giống hệt nhau.

Lanh lẹ, khôn khéo, dễ thương, luôn nhìn cha mẹ với gương mặt tươi cười trong sáng.',N'2023',N'Văn Học',100,1,'book42.jpg',11),
	('BK00043',N'Tâm Lý Học Tội Phạm - Phác Họa Chân Dung Kẻ Phạm Tội',101500,N'Diệp Hồng Vũ',280,N'Đằng sau máu và nước mắt là các câu chuyện rợn tóc gáy về tội ác, góc khuất xã hội và những màn đấu trí đầy gay cấn giữa điều tra viên và kẻ phạm tội. Trong số đó có những con quỷ ăn thịt người; những cô gái xinh đẹp nhưng xảo quyệt; và cả cách trả thù đầy man rợ của các nhà khoa học,… Một số đã sa vào lưới pháp luật ngay khi chúng vừa ra tay, nhưng cũng có những kẻ cứ vậy ngủ yên hơn hai mươi năm. ',N'2021',N'NXB Thanh Niên',100,1,'book43.jpg',11),
	('BK00044',N'Định Luật Murphy - Mọi Bí Mật Tâm Lý Thao Túng Cuộc Đời Bạn',83300,N'Từ Thính Phong',280,N'Định Luật Murphy – Mọi Bí Mật Tâm Lý Thao Túng Cuộc Đời Bạn

Nếu một điều tồi tệ có thể xảy ra, nó sẽ xảy ra!

Khi một món đồ quan trọng bị rơi, nó có xu hướng lăn tới dưới ngăn tủ nặng nhất.

Khi hai tay bạn cầm đầy đồ đạc, mũi bạn bắt đầu ngứa. ',N'2022',N'Thế Giới',100,1,'book44.jpg',11),
	-- sách cho tuổi mới lớn
	('BK00045',N'Giới Hạn Của Bạn Chỉ Là Xuất Phát Điểm Của Tôi (Tái Bản)',75650,N'Mèo Maverick',280,N'Giới Hạn Của Bạn Chỉ Là Xuất Phát Điểm Của Tôi (Tái Bản)

Giới hạn là gì?

Giới hạn liệu có phải ranh giới an toàn của mỗi người?',N'2022',N'NXB Thế Giới',100,1,'book45.jpg',12),
	('BK00046',N'Cẩm Nang Con Trai Tuổi Dậy Thì - Quyển 1 - Sổ Tay Kiến Thức Sinh Lí (Tái Bản 2019)',239904 ,N'Thương Lãng',198,N'Xin hãy mở cuốn sách này ra, vì đây là cuốn cẩm nang sinh ra để giúp em và những cậu bé như em hiểu quá trình trưởng thành của mình, giúp em biết yêu quý giữ gìn cơ thể mình, giúp em giải quyết những rắc rối, thoát khỏi những phiền muộn của tuổi dậy thì.',N'2019',N'NXB Kim Đồng',100,1,'book46.jpg',12),
	('BK00047',N'Cẩm Nang Bé Gái Tuổi Dậy Thì - Quyển 1: 160 Câu Hỏi-Đáp Về Sinh Lí Bạn Gái Tuổi Dậy Thì (Tái Bản 2019)',122400,N'Nhiều Tác Giả',196,N'Tất tần tật những thắc mắc về tâm sinh lí các bé gái tuổi dậy thì (9-18 tuổi) đều được giải đáp trong 2 cuốn sách này. Những câu hỏi của các bé gái, đang bỡ ngỡ trước ngưỡng tuổi dậy thì, được chuyên gia trả lời vừa khoa học mà dễ hiểu, dễ nhớ.',N'2021',N'NXB Kim Đồng',100,1,'book47.jpg',12),
	('BK00048',N'Kỷ Luật Tích Cực Trong Lớp Học (Tái Bản 2021)',69700 ,N'Ian Fleming',252,N'Kỷ luật tích cực trong lớp học

Với cuốn sách này, bạn sẽ học được cách:

. Tạo một môi trường lớp học thúc đẩy tinh thần học thuật

. Sử dụng hiệu quả sự khích lệ thay vì phần thưởng và lời khen ngợi',N'2021',N'NXB Phụ Nữ Việt Nam',100,1,'book48.jpg',12),

	-- Cẩm nang làm cha mẹ
	('BK00049',N'Nuôi Dạy Bé Trai Từ 0 - 6 Tuổi (Tái Bản 2021)',58650,N'Erika Takeuchi',216,N'Ngay từ khi sinh ra, giữa bé trai và bé gái đã có những đặc trưng khác nhau cả về não bộ cũng như hệ thần kinh vận động. Do vậy cách giáo dục cũng sẽ khác nhau. Nếu nắm được điểm mấu chốt trong cách nuôi dạy cho từng bé thì bố mẹ có thể phát triển năng lực của trẻ một cách toàn diện.',N'2021',N'NXB Lao Động',100,1,'book49.jpg',13),
	('BK00050',N'Đọc Vị Mọi Vấn Đề Của Trẻ - Tái Bản 2021',159200,N'Tracy Hogg, Melinda Blau',509,N'Vấn đề không là gì khác ngoài một rắc rối cần phải giải quyết hoặc một tình huống đòi hỏi giải pháp sáng tạo. Hãy đặt ra đúng câu hỏi và bạn sẽ tìm ra câu trả lời chính xác.',N'2021',N'NXB Kim Đồng',100,1,'book50.jpg',13),
	('BK00051',N'Cha Mẹ Đọc - Con Thành Tài',294400,N'Nguyễn Phùng Phong',231,N'Cẩm nang "gối đầu giường" giúp cha mẹ giảm tải áp lực nặng nề trong việc dạy con, biết cách kích hoạt những thiên tài tiềm ẩn trong mỗi đứa trẻ Tác giả: Thầy NGUYỄN PHÙNG PHONG - Kỷ Lục Gia Siêu Trí Nhớ Thế Giới - Huân chương giáo dục Người đồng hành Thiên nga trắng của Hoàng gia Ba Lan.',N'2021',N'Đại Học Sư Phạm TPHCM',100,1,'book51.jpg',13),
	('BK00052',N'Cách Khen Cách Mắng Cách Phạt Con (Tái Bản 2021)',58650  ,N'Masami Sasaki, Wakamatsu Aki',180,N'Muốn con ngủ sớm thì nó lại chẳng chịu đi ngủ, muốn nó dừng bú mà nó cũng không chịu, lớn lên một chút thì nói cũng không nghe, vì nhút nhát mà bị thiệt thòi…Có rất nhiều vấn như vậy khiến chúng ta nhức đầu trong quá trình nuôi dạy con. Bất cứ người phụ nữ nào đã từng nuôi con đều hiểu rằng trên thế gian này rất nhiều việc không như mình muốn. Trong quyển sách này, tôi muốn giới thiệu một số quan điểm cơ bản và phương pháp nuôi dạy con dựa trên “cách khen”, “cách mắng”, “cách dạy dỗ” trẻ.',N'2021',N'NXB Lao Động',100,1,'book52.jpg',13),

	-- pp giáo dục trẻ ở các nước
	('BK00053',N'Nuôi Dạy Bé Gái Từ 0 Đến 6 Tuổi (Tái Bản 2020)',63750,N'Erika Takeuchi',236,N'Tác giả của cuốn sách Nuôi dạy bé gái từ 0 – 6 tuổi là người đã có 20 năm nghiên cứu về sự trưởng thành của trẻ em, quan sát 12.000 trẻ ở nhiều độ tuổi khác nhau, từ em bé sơ sinh cho đến sinh viên đại học. Từ kinh nghiệm thực tiễn và nghiên cứu tác giả đã đúc kết được những điều quan trọng đối với sự phát triển của trẻ rằng:',N'2020',N'NXB Lao Động',100,1,'book53.jpg',14),
	('BK00054',N'Kinh Nghiệm Từ Nước Nhật - 43 Kĩ Năng Kiểm Soát Tức Giận (Dành Cho Trẻ Em)',55800,N'Shino Maki, Nakanawa Fumiko',120,N'Cuốn  sách  này  sẽ  trình  bày thật dễ hiểu với các hình vẽ minh  hoạ  về  phương  pháp nuôi dạy làm cho trẻ có được 5 thói quen sinh hoạt cơ bản như  ăn,  ngủ,  bài  tiết,  thay quần áo, giữ gìn vệ sinh.',N'2019',N'NXB Kim Đồng',100,1,'book54.jpg',14),
	('BK00055',N'Kỷ Luật Tích Cực - Không Phải Là Sự Trừng Phạt Mà Là Sự Tôn Trọng Trẻ (Tái Bản)',119000,N'Jane Nelsen',406,N'Kỷ Luật Tích Cực quy tụ vốn tri thức của nhiều tác giả đi trước, tạo ra một diễn đàn ấm cúng dành cho cha mẹ và giáo viên – những người kỳ vọng vào các nguyên tắc vĩnh cửu mang tính thực tiễn chứ không phải lý thuyết suông. Tiến sĩ Jane Nelsen đưa ra một bộ hướng dẫn mang tính thực tiễn cao dành cho các bậc cha mẹ và giáo viên mong muốn giúp con em mình xây dựng tinh thần tự giác, ý thức trách nhiệm, năng lực và thái độ tích cực.Cuốn sách đã được áp dụng như một tài liệu trong chương trình đào tạo được quốc tế công nhận – Chương trình Phát triển Năng lực Con người được tổ chức trên toàn Bắc Mỹ, Trung Mỹ và Châu Phi. Các nguyên tắc được nêu trong cuốn sách có giá trị thực tiễn và cung cấp một nền tảng vững chắc để làm giàu cho kinh nghiệm của mỗi gia đình.',N'2022',N'Phụ Nữ Việt Nam',100,1,'book55.jpg',14),
	('BK00056',N'Học Montessori Để Dạy Trẻ Theo Phương Pháp Montessori - 100 Hoạt Động Montessori: Con Không Cần Ipad Để Lớn Khôn',58500,N'Ève Herrmann, Trần Thị Huế',220,N'Cuốn 100 hoạt động Montessori: Con không cần iPad để lớn khôn gồm các hướng dẫn giúp trẻ làm quen với những hoạt động quen thuộc của cuộc sống thường nhật. Trẻ khoảng một tuổi rưỡi đã có khả năng thực hiện các hoạt động như tự rửa tay, mặc quần áo, dọn bàn ăn,.. nếu cha mẹ hướng dẫn trẻ đúng cách và tin tưởng vào khả năng tự lập của trẻ.',N'2016',N'NXB Phụ Nữ',100,1,'book56.jpg',14),

	-- phát triển trí tuệ cho trẻ
	('BK00057',N'Bí Quyết Giúp Con Tăng Khả Năng Tập Trung',84150,N'Hạnh Nguyên',264,N'Rất nhiều bậc cha mẹ cho rằng phân tán, thiếu tập trung là loại bệnh của con em họ và nó làm họ vô cùng đau đầu, không tìm ra cách giải quyết thấu đáo. Cho dù trách mắng, bắt chịu phạt nhưng chúng vẫn chứng nào tật nấy. Phải chăng bắt trẻ em tập trung là không thể? Hay theo độ tuổi lớn dần khả năng tập trung của chúng sẽ tốt hơn?',N'2019',N'NXB Văn Học',100,1,'book57.jpg',15),
	('BK00058',N'Giúp Trẻ Quản Lý Tài Chính Thông Minh - “Muốn” Và “Cần” - Cách Tiêu Tiền Hợp Lý (Tái Bản 2020)',21250,N'Lisa Bullard, Christine M Schneider',24,N'Cực kỳ thú vị và thiết thực, đáp ứng mối quan tâm của các bậc cha mẹ, đón đầu xu thế giáo dục hiện đại, bộ sách rất phù hợp với trẻ từ 6 – 12 tuổi. Từng bài học “vỡ lòng” thân quen trong bộ sách này sẽ giúp trẻ có cái nhìn sâu sắc hơn về giá trị của đồng tiền và lao động, biết cách quản lý tiền hiệu quả và tổ chức cuộc sống hợp lý. Qua những nhân vật sinh động trong các tình huống đời thường quen thuộc, trẻ sẽ được làm quen với những kiến thức căn bản nhất về tiền như: Chi phí, thu nhập, tiết kiệm, mua sắm, theo dõi thu chi, cân nhắc đưa ra lựa chọn giữa nhu cầu và mong muốn,…',N'2019',N'NXB Giáo Dục Việt Nam',100,1,'book58.jpg',15),
	('BK00059',N'IQ - Tìm Chỗ Sai - Luyện Khả Năng Quan Sát Và Năng Lực Phân Biệt, Phán Đoán Sự Vật Của Trẻ - Tặng Kèm Hình Dán Thông Minh, Vui Nhộn',28050,N'Nguyễn Thị Vi Khanh',23,N'Với những hình ảnh vui nhộn, sáng tạo và rực rỡ, Phát Triển IQ Cho Trẻ Từ 0-4 Tuổi - Bé Thử Nghĩ Xem được thiết kế và xuất bản với mong muốn mang lại cho các bé có một cái nhìn khác về vạn vật xung quanh. Giúp bé tìm tòi, học hỏi, khám phá và phát triển IQ. Con bạn sẽ trở thành thần đồng cừ khôi khi còn bé, đây là điều mà cha mẹ nào cũng mong muốn. Và hãy để cuốn sách này giúp con bạn phát triển trí thông minh tiềm ẩn nhé!',N'2022',N'Văn Học',100,1,'book59.jpg',15),
	('BK00060',N'Kinh Nghiệm Từ Nước Nhật - Kĩ Năng Xã Hội Của Trẻ Em - 42 Bí Quyết Giúp Trẻ Tự Tin Và Dũng Cảm Trong Quan Hệ Bạn Bè',55800,N'Aikawa Atsushi, Igari Emiko',111,N'Nếu được dạy các kĩ năng xã hội, những đứa trẻ sẽ học được cách truyền đạt, cách lắng nghe và thấu hiểu ý nghĩ của người khác. Kết quả là, tình trạng trẻ bị tẩy chay, bị bắt nạt trong lớp sẽ giảm đi và giả sử trẻ bị bắt nạt thì sẽ biết tìm sự giúp đỡ từ các trẻ khác hoặc từ người lớn để nhanh chóng ra khỏi tình trạng bị cô lập. Khi có kĩ năng xã hội, các hành động hợp tác, trao đổi qua lại với bạn bè sẽ tăng lên và lớp học sẽ trở thành nơi “dễ chịu”, tác động tích cực đến thành tích học tập của trẻ. Các kĩ năng xã hội cho trẻ từ bậc tiểu học hay trung học cơ sở, sẽ là nền móng vững chắc trong các hoạt động giao tiếp xã hội theo trẻ đến tận lúc trưởng thành, giúp con người có được sự tự tin và độc lập, sức khoẻ tinh thần vững vàng. Cuốn sách này là những kĩ năng xã hội cần thiết và hết sức cụ thể dành cho trẻ em, giúp trẻ có được sự tự tin và độc lập trong quan hệ bạn bè và các mối quan hệ xã hội.',N'2020',N'Kim Đồng',100,1,'book60.jpg',15),

	-- phat triển kỹ năng cho trẻ
	('BK00061',N'Chào Con! Ba Mẹ Đã Sẵn Sàng (Tái Bản 2020)',71250,N'BS Trần Thị Huyên Thảo',224,N'"Chào con! Ba mẹ đã sẵn sàng!" - Cuốn sách không chỉ được viết trên nền tảng khoa học của một bác sĩ mà còn chứa chan tình yêu của một người mẹ.

Chắc chắn bạn cũng sẽ cảm nhận được những điểm hay và thực tế trong quyển sách này, từ nền tảng khoa học vững chắc cho đến kiến thức chăm sóc trẻ mới nhất, và nhất là phù hợp với hoàn cảnh của Việt Nam.',N'2020',N'NXB Trẻ',100,1,'book61.jpg',16),
	('BK00062',N'Để Con Được Ốm (Tái Bản 2022)',102000,N'Nguyễn Trí Đoàn, Uyên Bùi',316,N'“Để con được ốm cần có sự kiên nhẫn giải thích hay thuyết phục của bác sĩ cùng sự thông hiểu và hợp tác từ phía gia đình bé. Đôi khi, sự hợp tác và hiểu biết của phụ huynh còn quan trọng hơn nỗ lực (hay thời gian) của bác sĩ giải thích nữa. Quyết định không dùng kháng sinh hay ‘quay đầu lại’ hay không là tuỳ thuộc ở phụ huynh của các bé, tuỳ thuộc vào sự hiểu biết, kiên nhẫn và quan trọng nhất là sự hợp tác chặt chẽ với bác sĩ của con mình. Đã có nhiều trường hợp ‘quay đầu lại’ thành công, nhiều trường hợp không cần thuốc đắng vẫn dã tật thành công trong suốt 12 năm chúng tôi cùng nhau thực hành y khoa theo đúng chuẩn quốc tế: thực hành dựa trên chứng cứ y khoa tốt nhất cho bệnh nhi, dành thời gian để giải thích, tư vấn và theo dõi sát sao diễn tiến bệnh của bệnh nhi. Việc lo lắng là không thể tránh khỏi, tuy nhiên, sự lo lắng không giúp ích được gì cho bệnh của trẻ, chỉ có kiến thức chăm sóc bệnh đúng mới giúp ích cho trẻ. Và hẳn là các bé sẽ hạnh phúc biết bao khi được tôn trọng ‘quyền được bệnh’.  ',N'2022',N'Thế Giới',100,1,'book62.jpg',16),
	('BK00063',N'Sổ Tay Ăn Dặm Của Mẹ (Tái Bản 2020)',84150,N'BS Lê Thị Hải',267,N'Chính vì thế tôi viết cuốn sách Sổ tay ăn dặm của mẹ này với hi vọng có thể giải đáp được phần lớn thắc mắc của các bà mẹ khi cho con ăn dặm. Sách được trình bày dưới dạng hỏi đáp ngắn gọn, cô đọng để mẹ nắm được những kiến thức cơ bản về dinh dưỡng cho bé trong độ tuổi ăn dặm, giải đáp thắc mắc về thói quen ăn uống và tiêu hóa của bé, hay là cách chăm sóc bữa ăn cho bé khi bé bị bệnh, cách chế biến và bảo quản thực phẩm khoa học.”',N'',N'NXB Thế Giới',100,1,'book63.jpg',16),
	('BK00064',N'Bác Sĩ Riêng Của Bé Yêu - Bước Đệm Vững Chắc Vào Đời (Tái Bản 2020)',78200,N'Trần Thị Huyên Thảo',200,N'Bước đệm vững chắc vào đời là cuốn tiếp theo Chào con! Ba mẹ đã sẵn sàng trong bộ BÁC SĨ RIÊNG CỦA BÉ YÊU. Trong cuốn sách này Bác sĩ – thạc sĩ nhi khoa Trần thị Huyên Thảo gửi tới các bậc phụ huynh những lời khuyên thực tế và khoa học dành cho việc chăm sóc trẻ.',N'2020',N'NXB Trẻ',100,1,'book64.jpg',16),


	-- sách thiếu nhi
	-- Manga comic
	('BK00065',N'BlueLock - Tập 10 - Tặng Kèm Card PVC + Standee Nhân Vật',29750,N'Muneyuki Kaneshiro, Yusuke Nomura',200,N'',N'2023',N'Kim Đồng',100,1,'book65.jpg',17),
	('BK00066',N'BlueLock - Tập 11 - Tặng Kèm Card PVC',33250,N'Nguyễn Trí Đoàn, Uyên Bùi',192,N'',N'2023',N'Kim Đồng',100,1,'book66.jpg',17),
	('BK00067',N'Alice In Borderland - Tập 13 - Tặng Kèm Card Giấy',33250,N'Haro Aso',176,N'',N'2023',N'Trẻ',100,1,'book67.jpg',17),
	('BK00068',N'Banana Fish - Tập 2 - Tặng Kèm Postcard Giấy',42750,N'Akimi Yoshida',200,N'',N'2023',N'NXB Trẻ',100,1,'book68.jpg',17),

	-- kiến thức bách khoa
	('BK00069',N'100 Kỹ Năng Sinh Tồn',74250 ,N'Clint Emerson',272,N'',N'2020',N'NXB Thanh Niên',100,1,'book69.jpg',18),
	('BK00070',N'Mẹ Hỏi Bé Trả Lời 3-4 Tuổi (Tái Bản 2019)',25500,N'Yosbook, Xiao Li',88,N'',N'2019',N'NXB Kim Đồng',100,1,'book70.jpg',18),
	('BK00071',N'Danh Nhân Thế Giới: Napoleon (Tái Bản 2022)',25500,N'Neung In Publishing Company',160,N'',N'2022',N'Kim Đồng',100,1,'book71.jpg',18),
	('BK00072',N'Bách Khoa Tri Thức Về Khám Phá Thế Giới Cho Trẻ Em - Thiên Văn Học',33750,N'Rachel Firth',52,N'',N'2018',N'NXB Thế Giới',100,1,'book72.jpg',18),

	-- sách tranh kỹ năng sống cho trẻ
	('BK00073',N'Gieo Mầm Tính Cách - Tự Tin (Tái Bản 2019)',27200,N'Hà Yên',84,N'',N'2019',N'NXB Trẻ',100,1,'book73.jpg',19),
	('BK00074',N'Bé Khoẻ Mỗi Ngày: Nếu Không Ăn Rau Thì Sao?',25500,N'Hoàng Hoành, Kẹo Bông, Lan Phương',36,N'',N'2019',N'NXB Kim Đồng',100,1,'book74.jpg',19),
	('BK00075',N'Giáo Dục Đầu Đời Cho Trẻ - Những Bài Học Tự Bảo Vệ Bản Thân - Không Được Chạm Vào Vùng Riêng Tư Của Tớ',31500,N'Hồ Tâm',48,N'',N'2023',N'Thanh Niên',100,1,'book75.jpg',19),
	('BK00076',N'Wow! Những Bí Mật Kỳ Diệu Dành Cho Học Sinh - Kỹ Năng Sinh Tồn Nơi Hoang Dã',41250,N'Tôn Nguyên Vĩ',156,N'',N'2019',N'NXB Thanh Niên',100,1,'book76.jpg',19),

	-- vừa học vừa chới với trẻ
	('BK00077',N'Big Book - Cuốn Sách Khổng Lồ Về Các Ngôi Sao Và Các Hành Tinh (Tái Bản)',126000 ,N'Minna Lacey',32,N'',N'2018',N'NXB Thanh Niên',100,1,'book77.jpg',20),
	('BK00078',N'200 Miếng Bóc Dán Thông Minh - Bé Học Toán',41250 ,N'Ngọc Linh',30,N'',N'2018',N'	NXB Thanh Niên',100,1,'book78.jpg',20),
	('BK00079',N'Rèn Luyện Tư Duy, Nâng Cao IQ: Tìm Điểm Khác Nhau',38250,N'Hồ Viện Viện',32,N'',N'2022',N'Kim Đồng',100,1,'book79.jpg',20),
	('BK00080',N'Big Book - Cuốn Sách Khổng Lồ Về Các Loài Động Vật Biển (Tái Bản)',126000,N'Minna Lacey',32,N'',N'2018',N'NXB Thanh Niên',100,1,'book80.jpg',20),
	-- Câu chuyện cuộc đời
	('BK00081',N'Từ Kiến Trúc Sư Thành Bác Sĩ Tại Hoa Kỳ - Dám Chọn Lựa, Dám Thành Công',126650,N'BS Huỳnh Wynh Trần',312,N'',N'2021',N'NXB Thế Giới',100,1,'book81.jpg',21),
	('BK00082',N'Khi Hơi Thở Hóa Thinh Không (Tái Bản 2020)',92650,N'Paul Kalanithi',236,N'',N'2020',N'	NXB Lao Động',100,1,'book82.jpg',21),
	('BK00083',N'Tôi Nói Gì Khi Nói Về Chạy Bộ (Tái Bản 2021)',64600,N'Haruki Murakami',235,N'',N'2021',N'NXB Hội Nhà Văn',100,1,'book83.jpg',21),
	('BK00084',N'Nikola Tesla Tự Truyện (Tái Bản 2023)',121500,N'Nikola Tesla',354,N'',N'2023',N'Văn Học',100,1,'book84.jpg',21),
	-- Chính trị
	('BK00085',N'Lý Quang Diệu - Người Cha Lập Quốc',27900,N'Yoshio Nabeta',246,N'',N'2017',N'NXB Thông Tấn',100,1,'book85.jpg',22),
	('BK00086',N'Putin - Logic Của Quyền Lực - Putin: Innenansichten Der Macht',142800,N'Hubert Seipel',384,N'',N'2020',N'NXB Tổng Hợp TPHCM',100,1,'book86.jpg',22),
	('BK00087',N'Tự Truyện Benjamin Franklin (Tái Bản 2018)',92650,N'Benjamin Franklin',238,N'',N'2018',N'NXB Lao Động',100,1,'book87.jpg',22),
	('BK00088',N'Nền Tảng Chung',129200,N'Justin Trudeau',320,N'',N'2017',N'NXB Trẻ',100,1,'book88.jpg',22),
	-- Kinh tế
	('BK00089',N'Elon Musk - Đặt Cả Thế Giới Lên Bốn Bánh Xe Điện',169150,N'Hamish McKenzie',480,N'',N'2020',N'NXB Tài Chính',100,1,'book89.jpg',23),
	('BK00090',N'Sự Giàu Và Nghèo Của Các Dân Tộc (Tái Bản)',390150,N'David S Landes',888,N'',N'2022',N'Tri Thức',100,1,'book90.jpg',23),
	('BK00091',N'Sói Già Phố Wall (Phần 2) - Tái Bản 2021',125300,N'Jordan Belfort',632,N'',N'2021',N'NXB Lao Động',100,1,'book91.jpg',23),
	('BK00092',N'Bill Gates: Tham Vọng Lớn Lao Và Quá Trình Hình Thành Đế Chế Microsoft (Tái Bản 2017)',194650,N'James Wallace, Jim Erickson',416,N'',N'2017',N'NXB Thế Giới',100,1,'book92.jpg',23),
	-- Nghệ thuật giải trí
	('BK00093',N'BTS & A.R.M.Y Thời Khắc Tươi Đẹp Nhất Chúng Ta Có Nhau (Tái Bản)',83300,N'Lee Jeeheng',220,N'',N'2021',N'NXB Hà Nội',100,1,'book93.jpg',24),
	('BK00094',N'Trịnh Công Sơn - Thư Tình Gửi Một Người',165750,N'Trịnh Công Sơn',356,N'',N'2022',N'NXB Trẻ',100,1,'book94.jpg',24),
	('BK00095',N'Áo Xưa Dù Nhàu…',168300,N'Đỗ Hồng Ngọc',322,N'',N'2023',N'Đà Nẵng',100,1,'book95.jpg',24),
	('BK00096',N'Michelangelo - Sáu Kiệt Tác Cuộc Đời',254150,N'Miles J Unger',576,N'',N'2020',N'NXB Dân Trí',100,1,'book96.jpg',24),
	-- Giáo khoa
	('BK00097',N'Tin Học 6 (Cánh Diều) (2023)',18000,N'Nhiều Tác Giả',108,N'',N'2023',N'Đại Học Sư Phạm',100,1,'book97.jpg',25),
	('BK00098',N'Hoá Học 10 (Chân Trời Sáng Tạo) (2023)',21000,N'Nhiều Tác Giả',120,N'',N'2023',N'Giáo Dục Việt Nam',100,1,'book98.jpg',25),
	('BK00099',N'Toán 10/1 (Chân Trời Sáng Tạo) (2023)',21000,N'Nhiều Tác Giả',136,N'',N'2023',N'Giáo Dục Việt Nam',100,1,'book99.jpg',25),
	('BK00100',N'Tiếng Anh 11 Friends Global - Student Book (2023)',10300,N'Nhiều Tác Giả',144,N'',N'2023',N'Giáo Dục Việt Nam',100,1,'book100.jpg',25),
	-- sách Tham Khảo
	('BK00101',N'Tổng Ôn Ngữ Pháp Tiếng Anh (Tái Bản 2023)',180000,N'Trang Anh',608,N'',N'2023',N'NXB Hồng Đức',100,1,'book101.jpg',26),
	('BK00102',N'Atlat Địa lí Việt Nam (Theo Chương Trình Giáo Dục Phổ Thông 2018) (2023)',27900,N'Nhiều Tác Giả',178,N'',N'2023',N'Hà Nội',100,1,'book102.jpg',26),
	('BK00103',N'Tài Liệu Dạy Và Học Vật Lý 9 - Tập 1 (2023)',53100,N'Phạm Ngọc Tiến',163,N'',N'2023',N'Giáo Dục Việt Nam',100,1,'book103.jpg',26),
	('BK00104',N'Bảng Tóm Tắt Toán Tiểu Học',5950,N'Chính Bình',1,N'',N'2021',N'NXB Đồng Nai',100,1,'book104.jpg',26),
	-- Luyện thi THPT quốc gia
	('BK00105',N'Tổng Ôn Ngữ Pháp Tiếng Anh (Tái Bản 2023)',180000,N'Trang Anh',608,N'',N'2023',N'NXB Hồng Đức',100,1,'book105.jpg',27),
	('BK00106',N'60 Đề Minh Họa 2023 Môn Tiếng Anh (Tái Bản)',160000,N'Trang Anh',480,N'',N'2023',N'Thanh Niên',100,1,'book106.jpg',27),
	('BK00107',N'Tờ Công Thức Toán 12 - Tất Cả Trong Một: Đại Số + Hình Học',21250,N'Nhiều Tác Giả',10,N'',N'2022',N'Đại Học Quốc Gia Hà Nội',100,1,'book107.jpg',27),
	('BK00108',N'500 Bài Luyện Đọc Hiểu - Đọc Điền Tiếng Anh',170000,N'Trang Anh',638,N'',N'2020',N'NXB Hồng Đức',100,1,'book108.jpg',27),
	-- Mẫu giáo
	('BK00109',N'Bé Chuẩn Bị Vào Lớp 1 - Vở Tập Viết Chữ Cái Viết Thường',10200,N'Chính An, Nhóm Giáo Viên ĐH Sư Phạm',31,N'',N'2021',N'NXB Thanh Hóa',100,1,'book109.jpg',28),
	('BK00110',N'Bé Chuẩn Bị Vào Lớp 1 - Vở Tập Viết Chữ Số',10200,N'Chính An, Nhóm Giáo Viên ĐH Sư Phạm',31,N'',N'2021',N'NXB Thanh Hóa',100,1,'book110.jpg',28),
	('BK00111',N'Bé Chuẩn Bị Vào Lớp 1 - Vở Tập Viết Nét Cơ Bản',10200,N'Chính An, Nhóm Giáo Viên ĐH Sư Phạm',31,N'',N'2021',N'NXB Thanh Hóa',100,1,'book111.jpg',28),
	('BK00112',N'Bé Chuẩn Bị Vào Lớp 1 - Vở Tập Viết Chữ Cái Viết Hoa',10200,N'Chính An, Nhóm Giáo Viên ĐH Sư Phạm',31,N'',N'2021',N'NXB Thanh Hóa',100,1,'book112.jpg',28),
	-- Tiếng anh
	('BK00113',N'Giải Thích Ngữ Pháp Tiếng Anh (Tái Bản 2022)',154000,N'Mai Lan Hương, Hà Thanh Uyên',560,N'',N'2021',N'Đà Nẵng',100,1,'book113.jpg',29),
	('BK00114',N'Destination B1 - Grammar And Vocabulary with Answer Key',135200,N'Malcome Mann, Steve Taylore-Knowles',248,N'',N'2023',N'Hồng Đức',100,1,'book114.jpg',29),
	('BK00115',N'Destination B2 - Grammar And Vocabulary with Answer Key',135200,N'Malcome Mann, Steve Taylore-Knowles',246,N'',N'2023',N'Hồng Đức',100,1,'book115.jpg',29),
	('BK00116',N'Tự Học 2000 Từ Vựng Tiếng Anh Theo Chủ Đề (Tái Bản)',52000,N'The Windy',260,N'',N'2019',N'NXB Đại Học Quốc Gia Hà Nội',100,1,'book116.jpg',29),
	-- Tiếng nhật
	('BK00117',N'Tiếng Nhật Cho Mọi Người - Sơ Cấp 1 - Bản Dịch Và Giải Thích Ngữ Pháp - Tiếng Việt (Bản Mới)',63750,N'Minna no Nihongo',184,N'',N'2018',N'NXB Trẻ',100,1,'book117.jpg',30),
	('BK00118',N'Tiếng Nhật Cho Mọi Người - Sơ Cấp 2 - Bản Dịch Và Giải Thích Ngữ Pháp - Tiếng Việt (Bản Mới)',59500,N'Minna no Nihongo',158,N'',N'2018',N'NXB Trẻ',100,1,'book118.jpg',30),
	('BK00119',N'Tiếng Nhật Cho Mọi Người - Sơ Cấp 1 - Bản Tiếng Nhật (Bản Mới)',123250,N'Minna no Nihongo',308,N'',N'2018',N'NXB Trẻ',100,1,'book119.jpg',30),
	('BK00120',N'Tiếng Nhật Cho Mọi Người Sơ Cấp 1 - 25 Bài Luyện Nghe',63750,N'Makino Akiko, Tanaka Yone, Kitagawa Itsuko',132,N'',N'2020',N'NXB Trẻ',100,1,'book120.jpg',30),
	-- Tiếng hoa
	('BK00121',N'Giáo Trình Chuẩn HSK 1 (Tái Bản 2022)',156420,N'Khương lệ Bình',141,N'',N'2022',N'NXB Tổng Hợp TPHCM',100,1,'book121.jpg',31),
	('BK00122',N'Giáo Trình Chuẩn HSK 1 - Sách Bài Tập (2021)',116920,N'Khương Lệ Bình, Vương Phương, Vương Phong, Lưu Lệ Bình',134,N'',N'2021',N'NXB Tổng Hợp TPHCM',100,1,'book122.jpg',31),
	('BK00123',N'Giáo Trình Chuẩn HSK 2 (Tái Bản)',156420,N'Khương Lệ Bình, Vương Phong, Lưu Lệ Bình, Vương Phương',143,N'',N'2020',N'NXB Tổng Hợp TPHCM',100,1,'book123.jpg',31),
	('BK00124',N'Giáo Trình Chuẩn HSK 3',213120,N'Khương Lệ Bình',160,N'',N'2022',N'NXB Tổng Hợp TPHCM',100,1,'book124.jpg',31),
	-- Tiếng hàn
	('BK00125',N'Tiếng Hàn Tổng Hợp Dành Cho Người Việt Nam - Sơ Cấp 1 (Tái Bản 2023)',132000,N'Nhiều Tác Giả',378,N'',N'2023',N'Đại học Quốc Gia Hà Nội',100,1,'book125.jpg',32),
	('BK00126',N'Giáo Trình Luyện Dịch Trung Cao Cấp Tiếng Hàn Quốc',75000,N'Trường Hàn Ngữ Việt Hàn Kanata',213,N'',N'2019',N'NXB Tổng Hợp TPHCM',100,1,'book126.jpg',32),
	('BK00127',N'Tiếng Hàn Tổng Hợp Dành Cho Người Việt Nam - Sơ Cấp 1 - Sách Bài Tập (Tái Bản 2023)',80100,N'Nhiều Tác Giả',250,N'',N'2023',N'Đại học Quốc Gia Hà Nội',100,1,'book127.jpg',32),
	('BK00128',N'Bài Tập Ngữ Pháp Tiếng Hàn (Trình Độ Căn Bản)',52700,N'MA Nguyễn Hoàng Thảo Ly',297,N'',N'2016',N'NXB Hồng Đức',100,1,'book128.jpg',32);

INSERT [dbo].[Shippers] (Name,birthday, Phone)values
	(N'Nguyễn Bá Hoàng','11-13-2002','0982309499'),
	(N'Đinh Gia Huy','1999-05-25','0936550866'),
	(N'Trần Nguyễn Thành Danh','1997-01-13','0943803689'),
	(N'Trương Công Huy Hoàng','2001-07-01','0983245823'),
	(N'Khúc Đinh Toàn','2003-05-05','0943553399'),
	(N'Nguyễn An Thịnh','1996-04-12','0903200891'),
	(N'Từ Công Thành','1997-12-13','0936555039'),
	(N'Phạm Gia Hưng','1999-11-02','0904085795'),
	(N'Trần Tuấn Hoàng','1998-11-03','0936261222'),
	(N'Mai Trung Nguyên','2001-12-19','0775270899'),
	(N'Trương Nhật Huy','1987-05-09','0869518296'),
	(N'Trần Minh Tuấn','1988-10-30','0982295695'),
	(N'Nguyễn Viết Quang','1979-01-01','0962055155'),
	(N'Hoàng Tuấn Dũng','1995-05-25','0914562599'),
	(N'Chu Anh Đức','1988-01-13','0386474473'),
	(N'Nguyễn Công Sơn','2002-03-12','0818862668'),
	(N'Nguyễn Nhất Huy','1983-08-19','0869518295'),
	(N'Cao Huy Thịnh','1999-02-12','0943818180'),
	(N'Phạm Tuấn Minh','1999-01-26','0912452137'),
	(N'Phạm Việt Hưng','1989-01-01','0912239766');




/************************************************************************************
**************************************************************************************
**************************************************************************************
***************************************************************************************/


INSERT [dbo].[Discounts] (Name, Value)values
	(N'Giảm: 5%',0.95),
	(N'Giảm: 10%',0.9),
	(N'Giảm: 15%',0.85),
	(N'Giảm: 20%',0.8),
	(N'Giảm: 25%',0.75),
	(N'Giảm: 30%',0.7),
	(N'Giảm: 35%',0.65),
	(N'Giảm: 40%',0.6),
	(N'Giảm: 45%',0.55),
	(N'Giảm: 50%',0.5);

INSERT [dbo].[States] (Id, Name)values 
	(1,N'Chờ xác nhận'),
	(2,N'Đang giao'),
	(3,N'Đã giao'),
	(4,N'Chờ lấy hàng');

INSERT [dbo].[Orders] (Account_id,Date,Discount_id,Shipper_id,State_id)values
('AC0001','2019-01-23',1,1,3),
('AC0002','2020-02-02',2,2,3),
('AC0003','2023-07-01',3,3,3),
('AC0004','2023-05-18',4,4,2),
('AC0005','2023-06-10',5,5,3),
('AC0006','2022-05-12',6,6,3),
('AC0007','2023-07-18',7,7,1),
('AC0008','2022-08-19',8,8,3),
('AC0009','2023-07-20',9,9,1),
('AC0010','2023-07-10',10,10,1),
('AC0010','2022-04-23',2,11,3),
('AC0009','2021-04-02',3,11,3),
('AC0008','2023-03-23',4,12,3),
('AC0007','2022-03-14',5,14,3),
('AC0006','2023-07-14',6,15,1),
('AC0005','2022-05-12',7,16,3),
('AC0004','2023-07-15',8,17,1),
('AC0003','2023-07-19',9,18,4),
('AC0002','2023-02-20',10,19,3),
('AC0001','2023-07-17',3,20,1),
('AC0008','2022-01-23',4,11,2),
('AC0007','2023-07-10',5,1,1),
('AC0006','2019-04-10',6,2,3),
('AC0005','2023-07-19',6,3,4),
('AC0004','2021-06-14',8,3,3),
('AC0003','2023-07-20',9,2,1),
('AC0002','2022-10-23',1,1,3),
('AC0001','2023-06-18',1,9,3);
	/****** Object:  Table [dbo].[Reviews]     Script Date: 18/7/2023 ******/




INSERT [dbo].[Orders_details](Id,Book_id,Order_id, Price)values
	('odt1','BK00001',3,'86400'),
	('odt2','BK00016',7,'171750'),
	('odt3','BK00021',10,'86400'),
	('odt4','BK00013',3,'184500'),
	('odt5','BK00032',4,'119000');

INSERT [dbo].[Accounts_discounts](Account_id, Discount_id)values
	('AC0001',2),
	('AC0002',1),
	('AC0003',2),
	('AC0003',3),
	('AC0004',4),
	('AC0005',5),
	('AC0006',6),
	('AC0007',7),
	('AC0006',8),
	('AC0001',9);

INSERT [dbo].[Books_discounts](Book_id, Discount_id) values 
	('BK00001',1),
	('BK00003',2),
	('BK00004',1),
	('BK00006',3),
	('BK00007',2),
	('BK00011',2),
	('BK00012',5),
	('BK00013',4),
	('BK00015',1),
	('BK00017',6),
	('BK00018',7),
	('BK00020',8),
	('BK00021',1),
	('BK00022',1),
	('BK00023',2),
	('BK00024',3),
	('BK00025',3),
	('BK00026',3),
	('BK00027',5),
	('BK00028',3),
	('BK00029',4),
	('BK00030',1);

INSERT [dbo].[Reviews] (Book_id, Account_id, review, Date, rating)values
	('BK00001','AC0003',N'Trẻ con vốn dĩ cần được sống vô tư trong sự bảo bọc và bao dung, thay vì gượng ép chúng phải hiểu chuyện và hành xử như một người lớn. Zezé là một đứa trẻ sáng dạ, cậu bé luôn hỏi tất cả những thứ gì cậu muốn biết, cậu có một niềm đam mê đặc biệt với từ ngữ. Khi nghe được một từ nào lạ Zezé đều mong muốn hiểu được ý nghĩa của nó và sử dụng chúng. Cậu cũng là một đứa trẻ có trách nhiệm, ít nhất là trong lời nói. Khi đối diện với cậu em Luis cậu luôn cẩn trọng từng câu, bởi vì cậu không muốn dạy em mình bất kì từ nào không chính xác Vốn là một đứa trẻ hiếu động, những trò tinh nghịch của Zezé luôn khiến cho người khác phiền lòng. Và ắc hẳn cũng vì lý do đó mà cậu bị cho là trong máu có quỷ. Kể cả khi cậu bộc lộ được thiên phú là biết đọc dù không được ai dạy, ấy vậy mà mọi người lại đều cho rằng quỷ sứ đã dạy cậu trong giấc ngủ Có lẽ ít ai nhận thấy ẩn sâu bên trong đứa trẻ tinh nghịch đó là một trái tim vô cùng ấm áp và khát khao có được tình yêu thương. Có hay chăng sự nghịch ngợm của Zezé chỉ là muốn tạo được sự chú ý đối với gia đình. Cậu mong mỏi ở gia đình một người chịu lắng nghe cậu, quan tâm cậu, giành thời gian hơn cho cậu. Bởi lẽ, khi nhận được sự quan tâm từ người ngoài, cậu liền trở nên ngoan ngoãn và vâng lời hơn. Đứa trẻ tự chơi tự học, cũng có thể tự kiếm tiền bằng cách đi đánh giày để mua tặng cha một bao thuốc lá, không thể nào lại là đứa trẻ hư, nhỉ?','2022-02-05',5),
	('BK00016','AC0004',N'“Người ta nói, tình yêu thuở ban đầu lúc nào cũng là đẹp nhất. Khi những rung động đều rất bỡ ngỡ. Khi cái chạm tay cũng đủ làm ngượng ngùng. Khi cái nhìn vẫn còn e thẹn. Khi những suy nghĩ của người ta chỉ hướng đến người còn lại…”','2021-10-10',4),
	('BK00021','AC0001',N'Tuyệt vời!','2023-06-28',5),
	('BK00013','AC0006',N'Thực tế thì môtip không mới, sống cùng lâu ngày rồi nảy sinh tình cảm, đã từng có cảm giác từ thời thanh xuân nhưng sau này mới có thể đến với nhau. Truyện đan xem giữa hiện thực và quá khứ qua sự hồi tưởng góc nhìn 2 nhân vật. Nhưng mình thích quyển này. Mình vô cùng thích cách nam chính yêu thương nữ chính, thâm tình đến khó tả giấu sau sự tuỳ hứng, cái kiểu luôn biến những cảm xúc có phần nặng nề thành những câu cợt nhả, đem sự tổn thương của mình thành chuyện cười để nữ chính không cảm thấy áy náy, luôn giữ lời hứa, chung thuỷ.','2023-07-23',5),
	('BK00032','AC0007',N'It is amazing. Nó thật sự rất hay và cuốn hút. Cuối cùng điều ấn tượng nhất là dự đoán một tương lai thế giới vào năm 2020, 2024 và 2051. Có những điều đã thành hiện thực và có những điều không hay chưa thành hiện thực. Tiên đoán về đồng tiền chung nhất trên thế giới thì tôi còn hơi mơ màng và cũng không quá tin tưởng. Về một thế giới thống nhất, nó đã sảy ra.','2023-06-15',5);

	insert into wishlist values('BK00001','AC0001', 1)

/************************************************************************************
**************************************************************************************
**************************************************************************************
***************************************************************************************/

select * from Accounts;
select * from Roles;
select * from Accounts_roles;
select * from Accounts_discounts;
select * from Books;
select * from Books_discounts;
select * from Genres;
select * from Discounts;
select * from Genres;
select * from Orders;
select * from Orders_details;
select * from Reviews;
select * from Shippers;
select * from wishlist

SELECT b.Name AS BookName, d.Name AS DiscountName, b.Price, b.Price*d.Value as NewPrice
FROM Books b
JOIN Books_discounts bd ON b.Id = bd.Book_id
JOIN Discounts d ON d.Id = bd.Discount_id
WHERE b.Id = 'BK00001';

SELECT b.image, b.name, b.price, w.quantity
FROM Books b 
JOIN wishlist w ON b.Id = w.Books_id
WHERE w.Account_id = 'AC0001';

