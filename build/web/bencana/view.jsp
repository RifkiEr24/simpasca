<%-- /bencana/view.jsp (Diperbaiki) --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Data Bencana - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style> body { background-color: #f4f7f6; } </style>
</head>
<body class="py-5">
    <div class="container">
         <div class="card shadow-sm border-0 rounded-4">
            <div class="card-header bg-white p-3 d-flex justify-content-between align-items-center">
                <h4 class="mb-0"><i class="bi bi-cloud-haze2-fill text-danger"></i> Data Kejadian Bencana</h4>
                <a href="${pageContext.request.contextPath}/bencana?menu=add" class="btn btn-primary">
                    <i class="bi bi-plus-circle-fill"></i> Catat Bencana Baru
                </a>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Tipe Bencana</th>
                                <th>Lokasi</th>
                                <th>Level</th>
                                <th>Tanggal & Waktu</th>
                                <th class="text-center">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="bencana" items="${bencanaList}">
                                <tr>
                                    <td>${bencana.id}</td>
                                    <td>${bencana.tipe}</td>
                                    <td>${bencana.lokasi}</td>
                                    <td><span class="badge bg-warning text-dark">${bencana.level}</span></td>
                                    <td>
                                        <%-- PERBAIKAN ADA DI BARIS INI --%>
                                        <fmt:formatDate value="${bencana.tanggal}" pattern="dd MMMM yyyy, HH:mm" />
                                    </td>
                                   <%-- /bencana/view.jsp --%>
<td class="text-center">
    <%-- Tombol baru ditambahkan di sini --%>
    <a href="${pageContext.request.contextPath}/bencana?menu=detail&id=${bencana.id}" class="btn btn-info btn-sm text-white">
        <i class="bi bi-eye-fill"></i> Kelola
    </a>
    <a href="${pageContext.request.contextPath}/bencana?menu=edit&id=${bencana.id}" class="btn btn-warning btn-sm">
        <i class="bi bi-pencil-fill"></i> Edit
    </a>
    <a href="${pageContext.request.contextPath}/bencana?menu=delete&id=${bencana.id}" class="btn btn-danger btn-sm" onclick="return confirm('Yakin ingin hapus?');">
        <i class="bi bi-trash-fill"></i> Hapus
    </a>
</td>

                                </tr>
                            </c:forEach>
                            <c:if test="${empty bencanaList}">
                                <tr><td colspan="6" class="text-center text-muted">Belum ada data bencana yang tercatat.</td></tr>
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