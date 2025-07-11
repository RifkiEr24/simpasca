<%-- /logistik/add.jsp --%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Tambah Logistik - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style> body { background-color: #f4f7f6; } </style>
</head>
<body class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white p-3"><h4 class="mb-0">Formulir Logistik Baru</h4></div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/logistik" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="mb-3">
                                <label class="form-label">Nama Logistik</label>
                                <input type="text" name="nama" class="form-control" required placeholder="cth: Air Mineral Dus">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Kategori</label>
                                <input type="text" name="kategori" class="form-control" placeholder="cth: Makanan & Minuman, Obat, Pakaian" required>
                            </div>
                           <div class="row">
    <div class="col-md-6 mb-3">
        <label class="form-label">Kuantitas (Stok)</label>
        <input type="number" name="qty" class="form-control" required>
    </div>
    <div class="col-md-6 mb-3">
        <label class="form-label">Satuan</label>
        <input type="text" name="satuan" class="form-control" placeholder="cth: box, kg, pcs" required>
    </div>
</div>

<%-- ===== BAGIAN BARU UNTUK RASIO ===== --%>
<div class="p-3 border rounded bg-light mb-3">
    <h6 class="form-label">Rasio Kebutuhan (Opsional)</h6>
    <div class="row">
        <div class="col-md-6 mb-3">
            <label class="form-label">Rasio per Korban</label>
            <input type="number" step="0.01" name="rasio_per_korban" class="form-control" value="0">
        </div>
        <div class="col-md-6 mb-3">
            <label class="form-label">Unit Rasio</label>
            <input type="text" name="unit_rasio" class="form-control" placeholder="cth: pcs/orang">
        </div>
    </div>
                            <div class="d-flex justify-content-between mt-3">
                                <a href="${pageContext.request.contextPath}/logistik?menu=view" class="btn btn-secondary">Batal</a>
                                <button type="submit" class="btn btn-primary">Simpan Logistik</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>