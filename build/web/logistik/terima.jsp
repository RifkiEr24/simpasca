<%-- /logistik/terima.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Penerimaan Stok Logistik - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style> body { background-color: #f4f7f6; } </style>
</head>
<body class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white p-3"><h4 class="mb-0">Formulir Penerimaan Stok (Donasi)</h4></div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/logistik" method="post">
                            <input type="hidden" name="action" value="terima_stok">
                            <div class="mb-3">
                                <label for="logistik_id" class="form-label">Pilih Item Logistik</label>
                                <select name="logistik_id" id="logistik_id" class="form-select" required>
                                     <option value="">-- Pilih Item --</option>
                                     <c:forEach var="log" items="${semuaLogistik}">
                                        <option value="${log.id}">${log.nama} (Stok Saat Ini: ${log.qty})</option>
                                     </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="jumlah" class="form-label">Jumlah Diterima</label>
                                <input type="number" name="jumlah" id="jumlah" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="keterangan" class="form-label">Keterangan</label>
                                <textarea name="keterangan" id="keterangan" class="form-control" rows="3" required placeholder="cth: Donasi dari warga RT 05"></textarea>
                            </div>
                            <div class="d-flex justify-content-between mt-3">
                                <a href="${pageContext.request.contextPath}/logistik?menu=view" class="btn btn-secondary">Batal</a>
                                <button type="submit" class="btn btn-success">Catat Penerimaan</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>