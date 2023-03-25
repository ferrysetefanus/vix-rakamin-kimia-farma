CREATE TABLE table_base AS (
	WITH data_penjualan AS (
		SELECT CONCAT(id_invoice, '-', id_barang) AS id_penjualan,
			   id_invoice,
			   tanggal,
			   date_part('month', tanggal) AS month,
			   id_customer,
			   id_barang,
			   jumlah_barang
		FROM penjualan
		UNION
		SELECT CONCAT(id_invoice, '-', id_barang) AS id_penjualan,
			   id_invoice,
			   tanggal,
			   date_part('month', tanggal) AS month,
			   id_customer,
			   id_barang,
			   jumlah_barang
		FROM penjualan_ds
	)
	
	SELECT   dp.id_penjualan, dp.id_invoice, dp.id_customer, 
		   dp.id_barang, pds.id_distributor, dp.tanggal, dp.month, 
		   pds.nama as customer, pds.cabang_sales, pds.group, 
		   bds.nama_barang, bds.brand, bds.harga, dp.jumlah_barang
	FROM data_penjualan as dp
	LEFT JOIN pelanggan_ds as pds
		 ON dp.id_customer = pds.id_customer
	LEFT JOIN barang_ds as bds
		 ON dp.id_barang = bds.kode_barang
	ORDER BY dp.id_invoice
)