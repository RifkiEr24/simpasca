<%-- /kas/edit.jsp --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Edit Transaksi Kas - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style> body { background-color: #f4f7f6; } </style>
</head>
<body class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white p-3"><h4 class="mb-0">Formulir Edit Transaksi</h4></div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/kas" method="post">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="${kas.id}">
                            <div class="mb-3">
                                <label class="form-label">Tipe Transaksi</label>
                                <div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="tipe" id="masuk" value="Masuk" ${kas.tipe == 'Masuk' ? 'checked' : ''}>
                                        <label class="form-check-label" for="masuk">Masuk</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="tipe" id="keluar" value="Keluar" ${kas.tipe == 'Keluar' ? 'checked' : ''}>
                                        <label class="form-check-label" for="keluar">Keluar</label>
                                    </div>
                                </div>
                            </div>
                             <div class="mb-3">
                                <label for="tanggal" class="form-label">Tanggal Transaksi</label>
                                <fmt:formatDate value="${kas.tanggal}" pattern="yyyy-MM-dd" var="formattedDate" />
                                <input type="date" name="tanggal" id="tanggal" class="form-control" value="${formattedDate}" required>
                            </div>
                            <div class="mb-3">
                                <label for="nominal" class="form-label">Nominal (Rp)</label>
                                <input type="number" name="nominal" id="nominal" class="form-control" value="${kas.nominal}" required>
                            </div>
                            <div class="mb-3">
                                <label for="keterangan" class="form-label">Keterangan</label>
                                <textarea name="keterangan" id="keterangan" class="form-control" rows="3" required>${kas.keterangan}</textarea>
                            </div>
                            <div class="d-flex justify-content-between mt-3">
                                <a href="${pageContext.request.contextPath}/kas?menu=view" class="btn btn-secondary">Batal</a>
                                <button type="submit" class="btn btn-warning">Update Transaksi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>