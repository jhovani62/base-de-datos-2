CREATE TABLE store.promotion(
    id SERIAL PRIMARY KEY,
    id_item INTEGER NULL,
    name_promotion TEXT NOT NULL,
    description TEXT NULL,
    amount INTEGER NULL,
    start_date TIMESTAMP NULL,
    end_date TIMESTAMP NULL,
    discount_percentage DECIMAL(5,2) NULL CHECK (discount_percentage >= 0 AND discount_percentage <= 100),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_store_item FOREIGN KEY (id_item) REFERENCES store.item(id)
);

INSERT INTO store.promotion (id_item, name_promotion, amount, discount_percentage, start_date, end_date) VALUES
-- Primeras 10 promociones (ejemplo variado)
(1, 'Descuento en laptops', 5, 10.00, '2023-11-01', '2023-11-30'),  -- 10% de descuento en laptops al comprar 5
(2 ,'Descuento en smartphones', 2, 15.00, '2023-11-05', '2023-11-15'),  -- 15% en smartphones (compra de 2)
(3 ,'Descuento en tablets', 3, 20.00, '2023-11-10', '2023-11-20'),  -- 20% en tablets
(5, 'Descuento en teclados', 1, 25.00, '2023-11-15', '2023-11-25'),  -- 25% en teclados (sin cantidad mínima)
(7, 'Descuento en discos SSD', 10, 30.00, '2023-11-20', '2023-11-30'), -- 30% en discos SSD al comprar 10
(10, 'Descuento en webcams', 2, 15.00, '2023-12-01', '2023-12-15'), -- 15% en webcams
(12, 'Descuento en impresoras', 5, 10.00, '2023-12-05', '2023-12-20'), -- 10% en impresoras
(15, 'Descuento en altavoces inteligentes', 3, 20.00, '2023-12-10', '2023-12-25'), -- 20% en altavoces inteligentes
(18,'Descuento en audífonos', 1, 10.00, '2023-12-15', '2023-12-31'), -- 10% en audífonos
(20, 'Descuento en monitores gaming', 2, 15.00, '2024-01-01', '2024-01-15'), -- 15% en monitores gaming

-- Continuación hasta 60 promociones
(22, 'Descuento en cámaras de seguridad', 4, 12.00, '2024-01-05', '2024-01-20'),
(24 ,'Descuento en auriculares inalámbricos', 3, 18.00, '2024-01-10', '2024-01-25'),
(26 ,'Descuento en impresoras láser', 2, 22.00, '2024-01-15', '2024-01-31'),
(28 ,'Descuento en escritorios ergonómicos', 5, 8.00, '2024-02-01', '2024-02-15'),
(30 ,'Descuento en micrófonos USB', 1, 30.00, '2024-02-05', '2024-02-20'),
(32 ,'Descuento en cargadores portátiles', 2, 15.00, '2024-02-10', '2024-02-25'),
(34 ,'Descuento en cables HDMI', 3, 20.00, '2024-02-15', '2024-02-29'),
(36 ,'Descuento en soportes para celulares', 4, 10.00, '2024-03-01', '2024-03-15'),
(38 ,'Descuento en relojes inteligentes', 2, 25.00, '2024-03-05', '2024-03-20'),
(40 ,'Descuento en mochilas para laptops', 1, 15.00, '2024-03-10', '2024-03-25'),
(42 ,'Descuento en cámaras fotográficas', 5, 10.00, '2024-03-15', '2024-03-31'),
(44 ,'Descuento en proyectores portátiles', 3, 20.00, '2024-04-01', '2024-04-15'),
(46 ,'Descuento en soportes de TV', 2, 15.00, '2024-04-05', '2024-04-20'),
(48 ,'Descuento en consolas de videojuegos', 4, 12.00, '2024-04-10', '2024-04-25'),
(50 ,'Descuento en audífonos gaming', 1, 35.00, '2024-04-15', '2024-04-30'),
(52 ,'Descuento en cámaras de acción', 2, 18.00, '2024-05-01', '2024-05-15'),
(54 ,'Descuento en estaciones de carga', 3, 22.00, '2024-05-05', '2024-05-20'),
(56 ,'Descuento en discos duros externos', 5, 8.00, '2024-05-10', '2024-05-25'),
(58 ,'Descuento en pantallas 4K', 1, 40.00, '2024-05-15', '2024-05-31');


CREATE TABLE store.special_offers(
    id SERIAL,
    name_special_offers VARCHAR(100) NOT NULL,
    description TEXT NULL,
	CONSTRAINT pk_espcial_offers PRIMARY KEY (id)
);

CREATE TABLE store.item(
    id SERIAL,
    name_item VARCHAR(100) NOT NULL,
    description TEXT NULL,
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    id_special_offers INTEGER NULL,
	CONSTRAINT pk_item PRIMARY KEY (id),
    CONSTRAINT fk_store_special_offers FOREIGN KEY (id_special_offers) REFERENCES store.special_offers(id)
);
INSERT INTO store.item (name_item, description, stock, id_special_offers) VALUES
('Laptop HP EliteBook 840', 'Laptop empresarial 14" Core i7 16GB RAM', 25, 1),
('Smartphone iPhone 15 Pro', '6.1" Super Retina XDR, 128GB', 40, 2),
('Tablet Samsung Galaxy Tab S9', '11" 256GB, S-Pen incluido', 30, NULL),
('Monitor Dell UltraSharp 27"', '4K UHD, USB-C, ajustable', 20, 3),
('Teclado mecánico Logitech G915', 'Wireless, RGB, switches GL', 50, NULL),
('Mouse inalámbrico Microsoft Surface', 'Diseño ergonómico, Bluetooth', 75, 4),
('Disco SSD Samsung 1TB', 'NVMe M.2, 3500MB/s', 45, 5),
('Impresora HP LaserJet Pro', 'Impresión doble cara automática', 15, NULL),
('Router TP-Link Archer AX6000', 'Wi-Fi 6, 8 antenas', 25, 6),
('Webcam Logitech Brio 4K', 'Resolución UHD, HDR', 35, NULL),
('Tarjeta gráfica NVIDIA RTX 4080', '16GB GDDR6X, DLSS 3', 10, 7),
('Consola PlayStation 5', 'Edición estándar con lector', 18, 8),
('Smart TV LG OLED 55"', '4K, Dolby Vision, WebOS', 12, NULL),
('Audífonos Sony WH-1000XM5', 'Cancelación de ruido premium', 28, 9),
('Altavoz inteligente Amazon Echo', 'Alexa, sonido Dolby', 60, 10),
('Cámara mirrorless Canon EOS R6', '20MP, 4K 60fps', 8, NULL),
('Disco duro externo WD 4TB', 'USB 3.0, resistente a golpes', 40, 11),
('Silla gamer Razer Iskur', 'Soporte lumbar ajustable', 15, 12),
('Micrófono Blue Yeti', 'USB, 4 patrones polares', 22, NULL),
('Monitor gaming ASUS 27"', '240Hz, 1ms, FreeSync', 18, 13),
('Smartwatch Apple Watch Series 9', 'GPS, pantalla Retina', 30, 14),
('Proyector Epson Home Cinema', '4K PRO-UHD, 3000 lúmenes', 10, NULL),
('Kit de limpieza para electrónicos', 'Aire comprimido, brochas', 100, 15),
('Batería externa Anker 20000mAh', 'PD 45W, 3 puertos', 50, 16),
('Tarjeta SD SanDisk 256GB', 'Extreme Pro, 170MB/s', 80, NULL),
('Kit de herramientas para PC', 'Destornilladores antistáticos', 40, 17),
('Escáner portátil Epson DS-30', 'ADF, USB alimentado', 12, NULL),
('Base refrigeradora para laptop', '3 ventiladores, USB', 35, 18),
('Hub USB-C multipuertos', '4K HDMI, Ethernet, 3 USB', 60, 19),
('Lápiz óptico Apple Pencil 2', 'Compatibilidad iPad Pro', 25, NULL),
('Monitor vertical HP 24"', 'Full HD, pivot 90°', 15, 20),
('Teclado inalámbrico Apple Magic', 'Diseño ultra delgado', 45, NULL),
('Mouse pad gaming XL', 'Superficie controlada, RGB', 90, 21),
('Soporte monitor ergonómico', 'Ajuste de altura, VESA', 30, 22),
('Cable HDMI 2.1 ultra HD', '8K, 48Gbps, 2m', 120, NULL),
('Adaptador USB-C a HDMI', '4K 60Hz, plug and play', 75, 23),
('Funda para laptop 15.6"', 'Antichoque, múltiples bolsillos', 50, NULL),
('Estuche rígido para tablet', 'Protección 360°, 10-11"', 40, 24),
('Organizador de cables', 'Kit 15 piezas, velcro', 200, 25),
('Filtro de privacidad para monitor', '15.6", antirreflejo', 25, NULL),
('Lámpara LED para escritorio', 'Ajustable, USB, 3 tonos', 60, 26),
('Báscula digital de cocina', 'Precisión 1g, LCD', 45, NULL),
('Aspiradora robot Xiaomi', 'LIDAR, mapeo inteligente', 12, 27),
('Purificador de aire Dyson', 'HEPA, 360° filtration', 8, 28),
('Cafetera espresso DeLonghi', '15 bares, vaporizador', 15, NULL),
('Licuadora Oster Pro 1200', 'Vidrio templado, 8 velocidades', 25, 29),
('Horno tostador Cuisinart', 'Convección, 30L', 18, 30),
('Juego de sartenes antiadherentes', '6 piezas, grafito', 40, NULL),
('Robot de cocina Multifunción', '12 programas, pantalla táctil', 10, 31),
('Ventilador de torre Honeywell', 'Oscilación, 3 velocidades', 35, 32),
('Humidificador ultrasónico', '4L, luz nocturna', 28, NULL),
('Cargador inalámbrico Belkin', '15W, posición vertical', 65, 33),
('Reloj despertador digital', 'Radio FM, proyección', 50, 34),
('Almohadilla térmica Sunbeam', '3 ajustes, apagado automático', 30, NULL),
('Termómetro digital infrarrojo', 'Sin contacto, pantalla LCD', 45, 35),
('Báscula inteligente Withings', 'App, 8 sensores', 20, 36),
('Cepillo dental eléctrico Oral-B', '3 modos, cabezal incluido', 60, NULL),
('Mochila antirrobo para laptop', 'RFID, compartimento acolchado', 25, 37),
('Organizador de escritorio', '5 compartimentos, madera', 40, 38);
select *from store.ITEM

CREATE TABLE store.store(
    id SERIAL,
    id_user INTEGER NOT NULL,
    date_store TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    stock INTEGER NOT NULL CHECK (stock >= 0),
    motion VARCHAR(150) NOT NULL,
    id_item INTEGER NOT NULL,
	CONSTRAINT pk_store PRIMARY KEY (id),
    CONSTRAINT fk_store_item FOREIGN KEY (id_item) REFERENCES store.item(id),
    CONSTRAINT fk_usuari_user FOREIGN KEY (id_user) REFERENCES usuari.user(id)
);

INSERT INTO store.special_offers (name_special_offers, description) VALUES
('Oferta de Verano', 'Descuentos especiales en productos de temporada'),
('Black Friday', 'Promociones exclusivas el último viernes de noviembre'),
('Cyber Monday', 'Ofertas especiales en electrónica y tecnología'),
('Hot Sale', 'Evento de descuentos online durante 3 días'),
('Rebajas de Enero', 'Liquidación de inventario de temporada anterior'),
('Día del Padre', 'Promociones especiales para regalos'),
('Día de la Madre', 'Ofertas en artículos para mamá'),
('Back to School', 'Descuentos en útiles escolares y mochilas'),
('Super Septiembre', 'Mes completo de promociones especiales'),
('Octubre Fest', 'Ofertas en electrónica y electrodomésticos'),
('Navidad Mágica', 'Promociones navideñas por tiempo limitado'),
('Año Nuevo', 'Ofertas para comenzar bien el año'),
('Día del Amor', 'Descuentos especiales para San Valentín'),
('Semana Santa', 'Promociones en artículos de temporada'),
('Día del Niño', 'Ofertas en juguetes y artículos infantiles'),
('Mega Liquidación', 'Gran evento de descuentos en todo el almacén'),
('2x1 Especial', 'Llévate dos productos por el precio de uno'),
('3x2 en Electrónica', 'Promoción exclusiva en dispositivos'),
('Fin de Temporada', 'Liquidación de productos estacionales'),
('Flash Sale', 'Ofertas relámpago por 24 horas'),
('Noche de Descuentos', 'Evento nocturno con precios especiales'),
('Día sin IVA', 'Todos los productos con IVA incluido'),
('Membresía Premium', 'Descuentos exclusivos para miembros'),
('Aniversario Tienda', 'Celebración con ofertas especiales'),
('Día del Cliente', 'Promociones exclusivas para clientes frecuentes'),
('Ofertas Nocturnas', 'Descuentos especiales después de las 8pm'),
('Madrugadoras', 'Ofertas exclusivas de 6am a 10am'),
('Viernes de Descuentos', 'Promociones especiales cada viernes'),
('Lunes Tecnológicos', 'Descuentos en electrónica los lunes'),
('Martes de Moda', 'Ofertas en ropa y accesorios'),
('Miércoles del Hogar', 'Promociones en artículos para el hogar'),
('Jueves de Belleza', 'Descuentos en cosméticos y cuidado personal'),
('Sábado Familiar', 'Ofertas para toda la familia'),
('Domingo de Relax', 'Promociones en productos de bienestar'),
('Ofertas Express', 'Descuentos rápidos por tiempo limitado'),
('Precios Locos', 'Artículos seleccionados a precios increíbles'),
('Super Descuentos', 'Hasta 70% de descuento en varios productos'),
('Gran Remate', 'Liquidación de productos con grandes descuentos'),
('Ofertas VIP', 'Exclusivas para clientes con membresía'),
('Día del Gamer', 'Descuentos en videojuegos y accesorios'),
('Tech Week', 'Semana de ofertas en tecnología'),
('Moda Outlet', 'Ropa y accesorios con hasta 60% de descuento'),
('Hogar Inteligente', 'Promociones en domótica y automatización'),
('Belleza Total', 'Ofertas en productos de cuidado personal'),
('Deportes Extremos', 'Descuentos en equipo deportivo'),
('Fitness Challenge', 'Promociones en artículos de ejercicio'),
('Cocina Gourmet', 'Ofertas en utensilios de cocina'),
('Mundo Infantil', 'Descuentos en juguetes y artículos para bebés'),
('Literatura en Oferta', 'Promociones en libros y eBooks'),
('Mascotas Felices', 'Descuentos en productos para mascotas'),
('Viajes y Maletas', 'Ofertas en equipaje y accesorios de viaje'),
('Tecnología Wearable', 'Promociones en relojes y dispositivos inteligentes'),
('Audio Profesional', 'Descuentos en equipos de sonido'),
('Fotografía Digital', 'Ofertas en cámaras y accesorios'),
('Oficina en Casa', 'Promociones en muebles y artículos de oficina'),
('Jardinería Express', 'Descuentos en herramientas y plantas'),
('Pesca y Camping', 'Ofertas en artículos para actividades al aire libre'),
('Instrumentos Musicales', 'Promociones en equipos musicales'),
('Arte y Manualidades', 'Descuentos en materiales para artistas'),
('Coleccionables', 'Ofertas en artículos para coleccionistas'),
('Lujo Accesible', 'Promociones en artículos premium');

INSERT INTO store.store (id_user, date_store, stock, motion, id_item) VALUES
-- Primeros 20 registros (entradas iniciales de inventario)
(2, '2025-01-02 08:30:00', 100, 'Entrada inicial de inventario', 1),
(3, '2025-01-02 09:15:00', 75, 'Entrada inicial de inventario', 2),
(4, '2025-01-02 10:00:00', 50, 'Entrada inicial de inventario', 3),
(5, '2025-01-02 10:45:00', 120, 'Entrada inicial de inventario', 4),
(2, '2025-01-02 11:30:00', 90, 'Entrada inicial de inventario', 5),
(3, '2025-01-03 08:15:00', 60, 'Entrada inicial de inventario', 6),
(4, '2025-01-03 09:00:00', 200, 'Entrada inicial de inventario', 7),
(5, '2025-01-03 09:45:00', 80, 'Entrada inicial de inventario', 8),
(2, '2025-01-03 10:30:00', 150, 'Entrada inicial de inventario', 9),
(3, '2025-01-04 08:00:00', 40, 'Entrada inicial de inventario', 10),
(4, '2025-01-04 08:45:00', 110, 'Entrada inicial de inventario', 11),
(5, '2025-01-04 09:30:00', 70, 'Entrada inicial de inventario', 12),
(2, '2025-01-04 10:15:00', 95, 'Entrada inicial de inventario', 13),
(3, '2025-01-05 08:30:00', 55, 'Entrada inicial de inventario', 14),
(4, '2025-01-05 09:15:00', 180, 'Entrada inicial de inventario', 15),
(5, '2025-01-05 10:00:00', 65, 'Entrada inicial de inventario', 16),
(2, '2025-01-05 10:45:00', 85, 'Entrada inicial de inventario', 17),
(3, '2025-01-06 08:00:00', 130, 'Entrada inicial de inventario', 18),
(4, '2025-01-06 08:45:00', 45, 'Entrada inicial de inventario', 19),
(5, '2025-01-06 09:30:00', 160, 'Entrada inicial de inventario', 20),

-- Registros 21-40 (movimientos de compra y ajustes)
(2, '2025-01-10 11:00:00', 30, 'Compra a proveedor - Factura #1001', 1),
(3, '2025-01-11 14:30:00', 20, 'Compra a proveedor - Factura #1002', 3),
(4, '2025-01-12 10:15:00', 15, 'Compra a proveedor - Factura #1003', 5),
(5, '2025-01-13 16:45:00', 25, 'Compra a proveedor - Factura #1004', 7),
(2, '2025-01-14 09:30:00', 10, 'Ajuste de inventario positivo', 2),
(3, '2025-01-15 13:20:00', 5, 'Ajuste de inventario (merma contabilizada)', 4),
(4, '2025-01-16 11:10:00', 40, 'Compra a proveedor - Factura #1005', 9),
(5, '2025-01-17 15:30:00', 8, 'Productos dañados (salida de inventario)', 11),
(2, '2025-01-18 10:45:00', 12, 'Devolución de cliente', 13),
(3, '2025-01-19 14:15:00', 15, 'Venta al por mayor (salida de inventario)', 15),
(4, '2025-01-20 09:00:00', 18, 'Compra a proveedor - Factura #1006', 17),
(5, '2025-01-21 16:20:00', 3, 'Merma contabilizada (salida de inventario)', 19),
(2, '2025-01-22 11:30:00', 22, 'Compra a proveedor - Factura #1007', 6),
(3, '2025-01-23 14:45:00', 10, 'Venta especial (salida de inventario)', 8),
(4, '2025-01-24 10:00:00', 7, 'Ajuste de inventario positivo', 10),
(5, '2025-01-25 15:15:00', 12, 'Venta promocional (salida de inventario)', 12),
(2, '2025-01-26 09:45:00', 9, 'Devolución de proveedor', 14),
(3, '2025-01-27 13:30:00', 4, 'Venta minorista (salida de inventario)', 16),
(4, '2025-01-28 11:20:00', 16, 'Compra a proveedor - Factura #1008', 18),
(5, '2025-01-29 16:40:00', 7, 'Venta con descuento (salida de inventario)', 20),

-- Registros 41-60 (movimientos de venta y ajustes)
(2, '2025-02-01 10:15:00', 2, 'Venta #1001 (salida de inventario)', 1),
(3, '2025-02-02 14:30:00', 1, 'Venta #1002 (salida de inventario)', 2),
(4, '2025-02-03 09:45:00', 3, 'Venta #1003 (salida de inventario)', 3),
(5, '2025-02-04 16:00:00', 1, 'Venta #1004 (salida de inventario)', 4),
(2, '2025-02-05 11:30:00', 5, 'Venta #1005 (salida de inventario)', 5),
(3, '2025-02-06 14:45:00', 2, 'Venta #1006 (salida de inventario)', 6),
(4, '2025-02-07 10:00:00', 4, 'Venta #1007 (salida de inventario)', 7),
(5, '2025-02-08 15:15:00', 1, 'Venta #1008 (salida de inventario)', 8),
(2, '2025-02-09 09:30:00', 3, 'Venta #1009 (salida de inventario)', 9),
(3, '2025-02-10 13:45:00', 2, 'Venta #1010 (salida de inventario)', 10),
(4, '2025-02-11 11:00:00', 1, 'Venta #1011 (salida de inventario)', 11),
(5, '2025-02-12 16:30:00', 6, 'Venta #1012 (salida de inventario)', 12),
(2, '2025-02-13 10:45:00', 2, 'Venta #1013 (salida de inventario)', 13),
(3, '2025-02-14 14:00:00', 3, 'Venta #1014 (salida de inventario)', 14),
(4, '2025-02-15 09:15:00', 1, 'Venta #1015 (salida de inventario)', 15),
(5, '2025-02-16 15:30:00', 4, 'Venta #1016 (salida de inventario)', 16),
(2, '2025-02-17 11:45:00', 2, 'Venta #1017 (salida de inventario)', 17),
(3, '2025-02-18 14:15:00', 1, 'Venta #1018 (salida de inventario)', 18),
(4, '2025-02-19 10:30:00', 3, 'Venta #1019 (salida de inventario)', 19),
(5, '2025-02-20 16:45:00', 2, 'Venta #1020 (salida de inventario)', 20),
(2, '2025-02-21 09:00:00', 10, 'Reposición de inventario', 1),
(3, '2025-02-22 13:20:00', 5, 'Reposición de inventario', 3),
(4, '2025-02-23 11:10:00', 8, 'Reposición de inventario', 5),
(5, '2025-02-24 15:30:00', 12, 'Reposición de inventario', 7),
(2, '2025-02-25 10:45:00', 15, 'Compra de emergencia', 9),
(3, '2025-02-26 14:15:00', 7, 'Reposición parcial', 11),
(4, '2025-02-27 09:30:00', 20, 'Compra programada', 13),
(5, '2025-02-28 16:20:00', 9, 'Reposición estándar', 15),
(2, '2025-03-01 11:30:00', 6, 'Compra menor', 17),
(3, '2025-03-02 14:45:00', 11, 'Reposición completa', 19);
select * from store.store