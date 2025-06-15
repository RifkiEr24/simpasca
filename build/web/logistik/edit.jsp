<%-- /logistik/edit.jsp (Final) --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Edit Logistik - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style> body { background-color: #f4f7f6; } </style>
</head>
<body class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white p-3"><h4 class="mb-0">Formulir Edit Logistik</h4></div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/logistik" method="post">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="${logistik.id}">

                            <div class="mb-3">
                                <label class="form-label">Nama Logistik</label>
                                <input type="text" name="nama" class="form-control" value="${logistik.nama}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Kategori</label>
                                <input type="text" name="kategori" class="form-control" value="${logistik.kategori}" required>
                            </div>
                             <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Kuantitas (Stok)</label>
                                    <%-- Input untuk Kuantitas --%>
                                    <input type="number" name="qty" class="form-control" value="${logistik.qty}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Satuan</label>
                                    <input type="text" name="satuan" class="form-control" value="${logistik.satuan}" required>
                                </div>
                            </div>
                            
                            <div class="p-3 border rounded bg-light mb-3">
                                <h6 class="form-label">Rasio Kebutuhan</h6>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Rasio per Korban</label>
                                        <%-- Input untuk Rasio --%>
                                        <input type="number" step="0.01" name="rasio_per_korban" class="form-control" value="${logistik.rasioPerKorban}">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Unit Rasio</label>
                                        <input type="text" name="unit_rasio" class="form-control" value="${logistik.unitRasio}" placeholder="cth: pcs/orang">
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between mt-3">
                                <a href="${pageContext.request.contextPath}/logistik?menu=view" class="btn btn-secondary">Batal</a>
                                <button type="submit" class="btn btn-warning">Update Logistik</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>