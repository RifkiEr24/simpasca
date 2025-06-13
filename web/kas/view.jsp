<%-- /kas/view.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Data Alur Kas - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style> 
        body { background-color: #f4f7f6; }
        .text-masuk { color: #198754; font-weight: bold; }
        .text-keluar { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body class="py-5">
    <div class="container">
         <div class="card shadow-sm border-0 rounded-4">
            <div class="card-header bg-white p-3 d-flex justify-content-between align-items-center">
                <h4 class="mb-0"><i class="bi bi-wallet2 text-success"></i> Data Alur Kas Keuangan</h4>
                <a href="${pageContext.request.contextPath}/kas?menu=add" class="btn btn-primary">
                    <i class="bi bi-plus-circle-fill"></i> Catat Transaksi
                </a>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Tanggal</th>
                                <th>Keterangan</th>
                                <th>Tipe</th>
                                <th class="text-end">Nominal</th>
                                <th class="text-center">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="kas" items="${kasList}">
                                <tr>
                                    <td>${kas.id}</td>
                                    <td><fmt:formatDate value="${kas.tanggal}" pattern="dd MMM yyyy" /></td>
                                    <td>${kas.keterangan}</td>
                                    <td>
                                        <c:if test="${kas.tipe == 'Masuk'}">
                                            <span class="badge bg-success-subtle text-success-emphasis rounded-pill">Masuk</span>
                                        </c:if>
                                        <c:if test="${kas.tipe == 'Keluar'}">
                                            <span class="badge bg-danger-subtle text-danger-emphasis rounded-pill">Keluar</span>
                                        </c:if>
                                    </td>
                                    <td class="text-end">
                                        <span class="${kas.tipe == 'Masuk' ? 'text-masuk' : 'text-keluar'}">
                                            <fmt:formatNumber value="${kas.nominal}" type="currency" currencyCode="IDR" maxFractionDigits="0"/>
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/kas?menu=edit&id=${kas.id}" class="btn btn-warning btn-sm">Edit</a>
                                        <a href="${pageContext.request.contextPath}/kas?menu=delete&id=${kas.id}" class="btn btn-danger btn-sm" onclick="return confirm('Yakin ingin hapus transaksi ini?');">Hapus</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty kasList}">
                                <tr><td colspan="6" class="text-center text-muted">Belum ada data transaksi.</td></tr>
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