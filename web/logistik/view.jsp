<%-- /logistik/view.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Data Logistik - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style> body { background-color: #f4f7f6; } </style>
</head>
<body class="py-5">
    <div class="container">
         <div class="card shadow-sm border-0 rounded-4">
         <div class="card-header bg-white p-3 d-flex justify-content-between align-items-center">
            <h4 class="mb-0"><i class="bi bi-box-seam text-info"></i> Data Logistik Bantuan</h4>
            <div>
                <%-- Tombol Baru --%>
                <a href="${pageContext.request.contextPath}/logistik?menu=terima" class="btn btn-success">
                    <i class="bi bi-plus-square-dotted"></i> Terima Stok (Donasi)
                </a>
                <a href="${pageContext.request.contextPath}/logistik?menu=add" class="btn btn-primary">
                    <i class="bi bi-plus-circle-fill"></i> Tambah Item Baru
                </a>
            </div>
        </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Nama Logistik</th>
                                <th>Kategori</th>
                                <th>Stok</th>
                                <th class="text-center">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="log" items="${logistikList}">
                                <tr>
                                    <td>${log.id}</td>
                                    <td>${log.nama}</td>
                                    <td>${log.kategori}</td>
                                    <td>${log.qty} ${log.satuan}</td>
                                    <td class="text-center">
                                         <a href="${pageContext.request.contextPath}/logistik?menu=riwayat&id=${log.id}" class="btn btn-secondary btn-sm">Riwayat</a>
    <a href="${pageContext.request.contextPath}/logistik?menu=edit&id=${log.id}" class="btn btn-warning btn-sm">Edit</a>
    <a href="${pageContext.request.contextPath}/logistik?menu=delete&id=${log.id}" class="btn btn-danger btn-sm" onclick="return confirm('Yakin ingin hapus?');">Hapus</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty logistikList}">
                                <tr><td colspan="5" class="text-center text-muted">Belum ada data logistik.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer bg-white">
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left-circle"></i> Kembali ke Dasbor
                </a>
            </div>
        </div>
    </div>
</body>
</html>