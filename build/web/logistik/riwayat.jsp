<%-- /logistik/riwayat.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Riwayat Stok: ${logistik.nama} - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style> 
        body { background-color: #f4f7f6; } 
        .text-masuk { color: #198754; }
        .text-keluar { color: #dc3545; }
    </style>
</head>
<body class="py-5">
    <div class="container">
         <div class="card shadow-sm border-0 rounded-4">
            <div class="card-header bg-white p-3">
                <h4 class="mb-0">Riwayat Stok untuk: ${logistik.nama}</h4>
                <p class="text-muted mb-0">Stok Tersisa Saat Ini: <strong>${logistik.qty} ${logistik.satuan}</strong></p>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="table-light">
                            <tr><th>Tanggal</th><th>Tipe</th><th>Jumlah</th><th>Keterangan</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${riwayatList}">
                                <tr>
                                    <td><fmt:formatDate value="${r.tanggal}" pattern="dd MMM yyyy, HH:mm"/></td>
                                    <td>
                                        <c:if test="${r.tipe == 'Masuk'}"><span class="badge bg-success">Masuk</span></c:if>
                                        <c:if test="${r.tipe == 'Keluar'}"><span class="badge bg-danger">Keluar</span></c:if>
                                    </td>
                                    <td class="${r.tipe == 'Masuk' ? 'text-masuk' : 'text-keluar'} fw-bold">
                                        ${r.tipe == 'Masuk' ? '+' : '-'} ${r.jumlah}
                                    </td>
                                    <td>${r.keterangan}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty riwayatList}">
                                <tr><td colspan="4" class="text-center text-muted">Belum ada riwayat pergerakan untuk item ini.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer bg-white">
                <a href="${pageContext.request.contextPath}/logistik?menu=view" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left-circle"></i> Kembali ke Daftar Logistik
                </a>
            </div>
        </div>
    </div>
</body>
</html>