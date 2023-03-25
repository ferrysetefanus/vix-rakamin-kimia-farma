CREATE TABLE table_aggregate AS (
	SELECT *,
			jumlah_barang * harga AS total_harga
	FROM table_base
)