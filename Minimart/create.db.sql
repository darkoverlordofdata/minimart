--USE minimart;
-- C:\Users\Bruce\AppData\Local\Microsoft\VisualStudio\SSDT

-- /*******************************************************
-- *
-- * Table: Orders
-- *
-- *******************************************************/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[orders]') AND type in (N'U'))
    DROP TABLE [dbo].orders
GO

CREATE TABLE orders (
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	order_guid VARCHAR(36) DEFAULT '' NOT NULL,
	order_ip VARCHAR(39) NOT NULL,
	order_date DATETIME NOT NULL,
	order_status INT DEFAULT 0 NOT NULL,
	customer_name VARCHAR(255) DEFAULT '' NOT NULL,
	customer_email VARCHAR(255) DEFAULT '' NOT NULL,
	phone_number VARCHAR(10) DEFAULT '' NOT NULL,
	ship_to_name VARCHAR(255) DEFAULT '' NOT NULL,
	ship_to_address1 VARCHAR(255) DEFAULT '' NOT NULL,
	ship_to_address2 VARCHAR(255) DEFAULT '' NOT NULL,
	ship_to_city VARCHAR(255) DEFAULT '' NOT NULL,
	ship_to_country VARCHAR(255) DEFAULT '' NOT NULL,
	ship_to_state VARCHAR(2) DEFAULT '' NOT NULL,
	ship_to_zip VARCHAR(5) DEFAULT '' NOT NULL
);

GO

-- /*******************************************************
-- *
-- * Table: Items
-- *
-- *******************************************************/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[items]') AND type in (N'U'))
    DROP TABLE [dbo].items
GO

CREATE TABLE items (
	id BIGINT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	price DECIMAL(12,2) NOT NULL,
	quantity INT NOT NULL
);

GO

-- /*******************************************************
-- *
-- * Table: Brands
-- *
-- *******************************************************/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[brands]') AND type in (N'U'))
    DROP TABLE [dbo].brands
GO

CREATE TABLE brands (
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	name VARCHAR(255) DEFAULT '' NOT NULL
);

GO

-- /*******************************************************
-- *
-- * Table: Products
-- *
-- *******************************************************/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[products]') AND type in (N'U'))
    DROP TABLE [dbo].products
GO

CREATE TABLE products (
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	fid VARCHAR(36) NOT NULL,
	brand_id INT NOT NULL,
	name VARCHAR(255) NOT NULL,
	size VARCHAR(255) NOT NULL,
	upc VARCHAR(12) NOT NULL,
	ean13 VARCHAR(13) NOT NULL,
	category VARCHAR(255) NOT NULL,
	price DECIMAL(12,2) NOT NULL,
	ingredients VARCHAR(1024) NOT NULL,
	servingsize VARCHAR(255) NOT NULL,
	servings VARCHAR(255) NOT NULL,
	image VARCHAR(255) NOT NULL
);

GO

-- /*******************************************************
-- *
-- * Proc: MM_GetProducts
-- *
-- *******************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID('MM_GetProducts'))
BEGIN
    DROP PROCEDURE MM_GetProducts
END

GO

CREATE PROCEDURE MM_GetProducts
	@brandId INT
	AS 
BEGIN
	SET NOCOUNT ON;
	IF @brandId = 0
	BEGIN
		SELECT products.id, brands.name AS 'brand', products.name, products.size, products.upc, products.price, products.ingredients, products.servings, products.servingsize, products.image FROM products JOIN brands ON products.brand_id = brands.id
	END
	ELSE
	BEGIN
		SELECT products.id, brands.name AS 'brand', products.name, products.size, products.upc, products.price, products.ingredients, products.servings, products.servingsize, products.image FROM products JOIN brands ON products.brand_id = brands.id WHERE brand_id=@brandId
	END
END

GO
-- /*******************************************************
-- *
-- * Proc: MM_GetCart
-- *
-- *******************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID('MM_GetCart'))
BEGIN
    DROP PROCEDURE MM_GetCart
END

GO

CREATE PROCEDURE MM_GetCart
	@orderId INT
	AS 
BEGIN
	SET NOCOUNT ON;
	SELECT items.id, items.order_id, items.product_id, brands.name AS 'brand', products.name, products.size, products.upc, products.price, products.servings, products.servingsize, products.ingredients, products.image, items.quantity FROM items JOIN orders ON orders.id = items.order_id JOIN products ON items.product_id = products.id JOIN brands on products.brand_id = brands.id WHERE order_id=@orderId AND orders.order_status = 0
END

GO

-- /*******************************************************
-- *
-- * Proc: MM_GetOrder
-- *
-- *******************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID('MM_GetOrder'))
BEGIN
    DROP PROCEDURE MM_GetOrder
END

GO

CREATE PROCEDURE MM_GetOrder
	@id INT
	AS 
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM orders WHERE id = @id
END

GO
-- /*******************************************************
-- *
-- * Proc: MM_GetBrand
-- *
-- *******************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID('MM_GetBrand'))
BEGIN
    DROP PROCEDURE MM_GetBrand
END

GO

CREATE PROCEDURE MM_GetBrand
	@id INT
	AS 
BEGIN
	SET NOCOUNT ON;
	IF @id = 0
	BEGIN
		SELECT id, name from brands;
	END
	ELSE
	BEGIN
		SELECT id, name from brands WHERE id=@id
	END

END

GO

-- /*******************************************************
-- *
-- * Proc: MM_NewCart
-- *
-- *******************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID('MM_NewCart'))
BEGIN
    DROP PROCEDURE MM_NewCart
END

GO


CREATE PROCEDURE MM_NewCart
	@orderIp VARCHAR(39)
	AS 
BEGIN
	SET NOCOUNT ON;
	INSERT INTO orders (order_date, order_ip) VALUES (GetDate(), @orderIp);
	SELECT SCOPE_IDENTITY();
END

GO


-- /*******************************************************
-- *
-- * Proc: MM_UpdateCart
-- *
-- *******************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID('MM_UpdateCart'))
BEGIN
    DROP PROCEDURE MM_UpdateCart
END

GO


CREATE PROCEDURE MM_UpdateCart
	@orderId INT,
	@productId INT,
	@price DECIMAL(12,2),
	@quantity INT
	AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE @q INT = 0;
	SELECT @q = quantity FROM items WHERE order_id = @orderId AND product_id = @productId;
	DELETE FROM items WHERE order_id = @orderId AND product_id = @productId;
	IF @quantity + @q > 0
	BEGIN
		INSERT INTO items (order_id, product_id, price, quantity) VALUES (@orderId, @productId, @price, @quantity + @q);
	END
END

GO



-- /*******************************************************
-- *
-- * Proc: MM_DelCart
-- *
-- *******************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID('MM_DelCart'))
BEGIN
    DROP PROCEDURE MM_DelCart
END

GO

CREATE PROCEDURE MM_DelCart
	@orderId INT
	AS 
BEGIN
	SET NOCOUNT ON;
	DELETE FROM items WHERE order_id = @orderId 
	DELETE FROM orders WHERE id = @orderId 
END

GO

-- /*******************************************************
-- *
-- * Proc: MM_ShipTo
-- *
-- *******************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID('MM_ShipTo'))
BEGIN
    DROP PROCEDURE MM_ShipTo
END

GO

CREATE PROCEDURE MM_ShipTo
	@order_id INT,
	@confirmation VARCHAR(36),
	@customer_name VARCHAR(255),
	@customer_email VARCHAR(255),
	@phone_number VARCHAR(10),
	@ship_to_name VARCHAR(255),
	@ship_to_address1 VARCHAR(255),
	@ship_to_address2 VARCHAR(255),
	@ship_to_city VARCHAR(255),
	@ship_to_country VARCHAR(255),
	@ship_to_state VARCHAR(2),
	@ship_to_zip VARCHAR(5)
	AS 
BEGIN
	SET NOCOUNT ON;
	UPDATE orders
		SET order_status = 1,
			order_date = GETDATE(),	
			order_guid = @confirmation,
			customer_name = @customer_name,
			customer_email = @customer_email,
			phone_number = @phone_number,
			ship_to_name = @ship_to_name,
			ship_to_address1 = @ship_to_address1,
			ship_to_address2 = @ship_to_address2,
			ship_to_city = @ship_to_city,
			ship_to_country = @ship_to_country,
			ship_to_state = @ship_to_state,
			ship_to_zip = @ship_to_zip
		WHERE id = @order_id;

END

GO

-- /*******************************************************
-- *
-- * Proc: MM_Submit
-- *
-- *******************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID('MM_Submit'))
BEGIN
    DROP PROCEDURE MM_Submit
END

GO

CREATE PROCEDURE MM_Submit
	@order_id INT
	AS 
BEGIN
	SET NOCOUNT ON;
	UPDATE orders
		SET order_status = 1
		WHERE id = @order_id;

END

GO
-- /*******************************************************
-- *
-- * Data: Products
-- *
-- *******************************************************/
INSERT INTO brands (name)
VALUES (
'Alvita'
),(
'Traditional Medicinals'
),(
'Yogi Tea'
);

go

INSERT INTO products (fid, brand_id, name, size, upc, ean13, 
category, price, ingredients, servingsize, servings, image) 
VALUES (
'0440e1e9-bb7f-436b-bb85-d9ee48afa4d9',
1,
'Senna Leaf',
'30 tea bags',
'726016005258',
'0726016005258',
'Tea & Coffee',
2.91,
'Senna Leaf',
'1 capsule',
'90',
'ais-283_1.jpg'
),
(
'62cfca6b-fa5b-402e-b30e-5f46a04d13de',
3,
'Detox Tea',
'16 tea bags',
'076950450080',
'0076950450080',
'Tea & Coffee',
4.38,
'Indian Sarsaparilla Root,Organic Cinnamon Bark,Organic Ginger Root,Licorice Root,Burdock Root,Organic Dandelion Root,Organic Cardamom Seed,Organic Clove Bud,Organic Black Pepper,Juniper Berry Extract,Long Pepper Berry,Chinese Amur Cork Tree Bark,Japanese Honeysuckle Flower,Forsythia Fruit,Gardenia Flower,Skullcap Root,Black Cohosh Root,Chinese Goldenthread Root,Rhubarb Root,Wax Gourd,Asian Psyllium Seed',
'1 tea bag',
'16',
'824_YogiTeaDetox_L.jpg'
),
(
'2de8d690-2f3b-4505-a59d-25533fc3afd8',
2,
'Peppermint Herb Tea',
'0.6 oz; 17 g',
'032917000163',
'0032917000163',
'Tea & Coffee',
3.72,
'Peppermint',
'1 cup brewed tea',
'16',
'f-032917000163.jpg'
),
(
'c230b3f5-9739-4cde-bd34-218910196762',
3,
'Green Tea Kombucha',
'16 tea bags',
'076950450219',
'0076950450219',
'Tea & Coffee',
4.22,
'Natural Passion Fruit Flavor,Natural Plum Flavor',
'1 tea bag (makes 8 fl oz)',
'16',
'f-076950450219.jpg'
),
(
'20c53fbd-8fc8-43ea-afd9-e79bee7d0137',
3,
'Bedtime Tea',
'16 tea bags',
'076950450011',
'0076950450011',
'Tea & Coffee',
4.2,
'Natural Orange, Flavor',
'1 tea bag (makes 8 fl oz)',
'16',
'821_YogiTeaBedtime_L.jpg'
),
(
'de120df4-3e2e-4b2c-b7d0-b0fd558aedab',
1,
'Red Clover Tea',
'30 tea bags',
'726016005029',
'0726016005029',
'Tea & Coffee',
3.5,
'Red Clover (Aerial Part)',
'1 bag',
'30',
'f-726016005029.jpg'
),
(
'7704fd7d-f785-4e29-9497-f1118526ea17',
3,
'Peach Detox Tea',
'16 tea bags',
'076950450233',
'0076950450233',
'Tea & Coffee',
4.51,
'Organic Cinnamon Bark,Organic Ginger Root,Organic Cardamom Seed,Organic Licorice Root,Organic Clove Bud,Organic Orange Peel,Bilberry Leaf,Organic Parsley Leaf,Fo-ti Root,Cornsilk Stem,Organic Dandelion Root,Organic Black Pepper,Long Pepper Berry,Other Natural Peach Flavor,Natural Cinnamon Oil,Natural Cardamom Oil,Natural Ginger Oil',
'1 tea bag',
'16',
'828_YogiTeaPeachDetox_L.jpg'
),
(
'd5580d77-3d74-449e-bb08-ec0f83c3fc58',
2,
'Herbal Tea Organic Throat Coat',
'1.13 oz; 32 g',
'032917000132',
'0032917000132',
'Tea & Coffee',
3.73,
'Organic Wild Cherry Bark [Bhp],Organic Bitter Fennel Fruit [Pheur],Organic Cinnamon Bark [Jp],Organic Sweet Orange Peel',
'1 cup',
'16',
'f-032917000132.jpg'
),
(
'4988187d-7f53-4490-93cf-6318f781de54',
3,
'Cold Season Tea',
'1.12 oz',
'076950450097',
'0076950450097',
'Tea & Coffee',
3,
'Organic Ginger Root,Organic Licorice Root,Organic Eucalyptus Leaf,Organic Orange Peel,Organic Valerian Root,Organic Lemongrass,Organic Peppermint Leaf,Organic Basil Leaf,Organic Cardamom Seed,Organic Oregano Leaf,Organic Black Pepper,Organic Clove Bud,Organic Parsley Leaf,Organic Yarrow Flower,Organic Cinnamon Bark,Other Organic Orange Flower',
'1 tea bag',
'16',
'f-076950450097.jpg'
),
(
'65fad80d-f699-4d95-9221-bae1a4bde80b',
3,
'Organic Ginger Tea',
'16 tea bags',
'076950450110',
'0076950450110',
'Tea & Coffee',
3.76,
'Organic Ginger Root,Organic Lemongrass,Organic Licorice Root,Organic Peppermint Leaf,Organic Black Pepper',
'1 tea bag',
'16',
'826_YogiTeaGinger_L.jpg'
),
(
'bd4ed099-85b1-4f2f-9ae3-7968b09f7eed',
2,
'Herbal Tea Organic Smooth Move',
'16 tea bags',
'032917000095',
'0032917000095',
'Tea & Coffee',
4.68,
'Organic Licorice Root [Pheur],Organic Bitter Fennel Fruit [Pheur],Organic Sweet Orange Peel,Organic Cinnamon Bark,Organic Coriander Fruit [Pheur],Organic Ginger Rhizome [Pheur]',
'1 cup',
'16',
'f-032917000095.jpg'
),
(
'02f5e26a-88af-4b4a-93d3-3d494e0a55be',
1,
'Hawthorn Berries Tea Bags',
'24 tea bags',
'726016004497',
'0726016004497',
'Tea & Coffee',
3.75,
'Hawthorn Berries',
'1 bag',
'24',
'ais-300b_1.jpg'
),
(
'9142d42b-b8b1-4a73-9d9f-696bcfa13e64',
3,
'Egyptian Licorice Tea',
'16 tea bags',
'076950415164',
'0076950415164',
'Tea & Coffee',
3.92,
'Organic Licorice Root,Organic Cinnamon Bark,Organic Orange Peel,Organic Ginger Root,Organic Cardamom Seed,Organic Black Pepper,Organic Clove Bud,Other Natural Tangerine Flavor,Natural Cinnamon Oil',
'1 tea bag',
'16',
'831_YogiTeaEgyptian_L.jpg'
),
(
'76a121a1-cce6-45d9-b8ea-c63517806b6a',
3,
'Echinacea Immune Support Tea',
'16 tea bags',
'076950450103',
'0076950450103',
'Tea & Coffee',
4.08,
'Organic Peppermint Leaf,Organic Lemongrass,Organic Licorice Root,Organic Cinnamon Bark,Organic Spearmint Leaf,Organic Fennel Seed,Organic Cardamom Seed,Organic Rose Hip,Organic Ginger Root,Organic Burdock Root,Stevia Leaf,Organic Mullein Leaf,Organic Clove Bud,Astragalus Root Extract,Organic Black Pepper,Other Organic Lemon Flavor,Natural Cinnamon Oil,Natural Cardamom Oil,Natural Ginger Oil',
'1 tea bag (makes 8 fl oz)',
'16',
'f-076950450103.jpg'
),
(
'186cbd80-7660-4873-b737-57305cf340b7',
3,
'Green Tea Super Anti-Oxidant',
'16 tea bags',
'076950450363',
'0076950450363',
'Tea & Coffee',
3.95,
'Organic Lemongrass,Organic Green Tea Leaf,Organic Licorice Root,Jasmine Green Tea Leaf,Organic Alfalfa Leaf,Organic Burdock Root,Organic Dandelion Root,Irish Moss Powder',
'1 tea bag (makes 8 fl oz)',
'16',
'819_YogiTeaGreen_L.jpg'
),
(
'09022229-9774-4a09-beec-f912191be160',
3,
'Lemon Ginger Tea',
'16 tea bags',
'076950450172',
'0076950450172',
'Tea & Coffee',
4.35,
'Organic Ginger Root,Organic Lemongrass,Lemon Peel,Organic Licorice Root,Organic Black Pepper,Organic Peppermint Leaf,Other Natural Lemon Flavor,Natural Licorice Flavor,Citric Acid',
'1 tea bag',
'16',
'3312_2790_large.jpg'
),
(
'23b652a8-a31b-4fe9-9b28-50e6ea2eda1b',
1,
'Tea Bags Fennel Seed Caffeine Free',
'24 tea bags',
'726016004251',
'0726016004251',
'Tea & Coffee',
4.4,
'Fennel Seed',
'1 bag',
'24',
'f-726016004251.jpg'
),
(
'3c8da2ea-7383-4fde-a489-31970a05bc7a',
1,
'Tea Bags',
'24 tea bags',
'726016004701',
'0726016004701',
'Tea & Coffee',
3.36,
'Milk Thistle',
'1 bag',
'24',
'f-726016004701.jpg'
),
(
'96afe338-872f-47ed-83bc-6a458cfe63f9',
3,
'Green Tea Pure Green Decaf',
'16 tea bags',
'076950450417',
'0076950450417',
'Tea & Coffee',
3.72,
'Organic Decaffeinated Green Tea Leaf',
'1 tea bag (makes 8 fl oz)',
'16',
'f-076950450417.jpg'
),
(
'0a6e0629-f4de-4492-afa6-ba1bad151d79',
3,
'Green Tea Energy 16 Tea Bags',
'16 tea bags',
'076950450271',
'0076950450271',
'Tea & Coffee',
3.53,
'Panax Ginseng,Panax Quinquefolium,Eleutherococcus Senticosus,Proprietary Blend Of Herbs: Organic Green Tea Leaf,Organic Lemongrass,Organic Spearmint Leaf,Kombucha',
'1 tea bag (makes 8 fl oz)',
'16',
'f-076950450271.jpg'
);

GO

