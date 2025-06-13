<%-- /kas/add.jsp (Final) --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Tambah Transaksi Kas - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style> 
        body { background-color: #f4f7f6; } 
        #detailPembelian { display: none; } /* Sembunyikan form detail secara default */
    </style>
</head>
<body class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white p-3"><h4 class="mb-0">Formulir Transaksi Baru</h4></div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/kas" method="post">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="mb-3">
                                <label class="form-label">Tipe Transaksi</label>
                                <div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="tipe" id="masuk" value="Masuk" checked onchange="toggleDetailPembelian()">
                                        <label class="form-check-label" for="masuk">Masuk (Donasi)</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="tipe" id="keluar" value="Keluar" onchange="toggleDetailPembelian()">
                                        <label class="form-check-label" for="keluar">Keluar (Pembelian)</label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3"><label for="tanggal" class="form-label">Tanggal Transaksi</label><input type="date" name="tanggal" id="tanggal" class="form-control" required></div>
                            <div class="mb-3"><label for="nominal" class="form-label">Nominal (Rp)</label><input type="number" name="nominal" id="nominal" class="form-control" required></div>
                            <div class="mb-3"><label for="keterangan" class="form-label">Keterangan Transaksi</label><textarea name="keterangan" id="keterangan" class="form-control" rows="3" required></textarea></div>
                            
                            <div id="detailPembelian" class="p-3 border rounded bg-light mb-3">
                                <h5>Detail Pembelian Logistik (Opsional)</h5>
                                <div class="mb-3">
                                    <label for="logistik_id" class="form-label">Barang yang Dibeli</label>
                                    <select name="logistik_id" id="logistik_id" class="form-select">
                                        <option value="">-- Tidak Ada --</option>
                                        <c:forEach var="log" items="${semuaLogistik}">
                                            <option value="${log.id}">${log.nama}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="jumlah_logistik" class="form-label">Jumlah Diterima</label>
                                    <input type="number" name="jumlah_logistik" id="jumlah_logistik" class="form-control">
                                </div>
                            </div>

                            <div class="d-flex justify-content-between mt-3">
                                <a href="${pageContext.request.contextPath}/kas?menu=view" class="btn btn-secondary">Batal</a>
                                <button type="submit" class="btn btn-primary">Simpan Transaksi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // JavaScript untuk menampilkan/menyembunyikan detail pembelian
        function toggleDetailPembelian() {
            var detailForm = document.getElementById('detailPembelian');
            if (document.getElementById('keluar').checked) {
                detailForm.style.display = 'block';
            } else {
                detailForm.style.display = 'none';
            }
        }
    </script>
</body>
</html>