<%-- index.jsp (Final Disempurnakan) --%>
<%@ page import="models.Dasbor" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    // Logic di JSP sekarang sangat bersih, hanya membuat objek Dasbor.
    // Objek ini sudah berisi semua data dan statistik yang kita butuhkan.
    Dasbor dasbor = new Dasbor();
    request.setAttribute("dasbor", dasbor);
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Dasbor Analisis - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body { background-color: #f4f7f6; }
        .stat-card { border-left: 5px solid; transition: transform 0.2s ease-in-out; }
        .stat-card:hover { transform: translateY(-5px); }
        .stat-card h2, .stat-card h4 { font-weight: 600; }
        .card-link { color: inherit; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="text-center mb-5">
            <h1 class="display-5 fw-bold">Dasbor Simpasca</h1>
            <p class="lead text-muted">Sistem Manajemen Pasca Bencana</p>
        </div>

        <div class="row g-4">
            <div class="col-lg-3 col-md-6">
                <a href="${pageContext.request.contextPath}/bencana?menu=view" class="card-link">
                    <div class="card shadow-sm stat-card" style="border-left-color: #fd7e14;">
                        <div class="card-body"><h6 class="card-subtitle mb-2 text-muted">Total Bencana Tercatat</h6><h2 class="card-title">${dasbor.totalBencana}</h2></div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6">
                 <div class="card shadow-sm stat-card" style="border-left-color: #dc3545;">
                    <div class="card-body"><h6 class="card-subtitle mb-2 text-muted">Total Korban Terdampak</h6><h2 class="card-title">${dasbor.totalKorban}</h2></div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <a href="${pageContext.request.contextPath}/kas?menu=view" class="card-link">
                    <div class="card shadow-sm stat-card" style="border-left-color: #198754;">
                        <div class="card-body"><h6 class="card-subtitle mb-2 text-muted">Total Kas Masuk</h6><h4 class="card-title"><fmt:formatNumber value="${dasbor.totalKasMasuk}" type="currency" currencyCode="IDR" maxFractionDigits="0"/></h4></div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6">
                 <a href="${pageContext.request.contextPath}/kas?menu=view" class="card-link">
                    <div class="card shadow-sm stat-card" style="border-left-color: #ffc107;">
                        <div class="card-body"><h6 class="card-subtitle mb-2 text-muted">Total Kas Keluar</h6><h4 class="card-title"><fmt:formatNumber value="${dasbor.totalKasKeluar}" type="currency" currencyCode="IDR" maxFractionDigits="0"/></h4></div>
                    </div>
                </a>
            </div>
        </div>

        <div class="row g-4 mt-4">
            <div class="col-md-8">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Daftar Bencana Terbaru</h5><a href="${pageContext.request.contextPath}/bencana?menu=view" class="btn btn-sm btn-outline-primary">Lihat Semua</a>
                    </div>
                    <div class="card-body p-0"><div class="table-responsive"><table class="table table-hover mb-0">
                        <thead><tr><th>Tipe</th><th>Lokasi</th><th>Tanggal</th><th>Aksi</th></tr></thead>
                        <tbody>
                            <c:forEach var="bencana" items="${dasbor.getBencanaTerbaru(5)}">
                                <tr><td>${bencana.tipe}</td><td>${bencana.lokasi}</td><td><fmt:formatDate value="${bencana.tanggal}" pattern="dd MMM yy" /></td><td><a href="${pageContext.request.contextPath}/bencana?menu=detail&id=${bencana.id}" class="btn btn-sm btn-info text-white">Detail</a></td></tr>
                            </c:forEach>
                            <c:if test="${empty dasbor.getBencanaTerbaru(5)}"><tr><td colspan="4" class="text-center text-muted p-3">Tidak ada data bencana.</td></tr></c:if>
                        </tbody>
                    </table></div></div>
                </div>
                <div class="card shadow-sm">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Transaksi Kas Terbaru</h5><a href="${pageContext.request.contextPath}/kas?menu=view" class="btn btn-sm btn-outline-primary">Lihat Semua</a>
                    </div>
                     <div class="card-body p-0"><div class="table-responsive"><table class="table table-hover mb-0">
                        <thead><tr><th>Tanggal</th><th>Keterangan</th><th class="text-end">Nominal</th></tr></thead>
                        <tbody>
                             <c:forEach var="kas" items="${dasbor.getKasTerbaru(5)}">
                                <tr><td><fmt:formatDate value="${kas.tanggal}" pattern="dd MMM yy"/></td><td>${kas.keterangan}</td><td class="text-end fw-bold ${kas.tipe == 'Masuk' ? 'text-success' : 'text-danger'}"><fmt:formatNumber value="${kas.nominal}" type="currency" currencyCode="IDR" maxFractionDigits="0"/></td></tr>
                             </c:forEach>
                            <c:if test="${empty dasbor.getKasTerbaru(5)}"><tr><td colspan="3" class="text-center text-muted p-3">Tidak ada transaksi kas.</td></tr></c:if>
                        </tbody>
                    </table></div></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-white"><h5 class="mb-0">Menu Utama</h5></div>
                    <div class="card-body"><div class="d-grid gap-3">
                        <a href="${pageContext.request.contextPath}/bencana?menu=view" class="btn btn-danger"><i class="bi bi-cloud-haze2-fill"></i> Kelola Bencana</a>
                        <a href="${pageContext.request.contextPath}/logistik?menu=view" class="btn btn-info text-white"><i class="bi bi-box-seam"></i> Kelola Logistik</a>
                        <a href="${pageContext.request.contextPath}/kas?menu=view" class="btn btn-success"><i class="bi bi-cash-stack"></i> Kelola Alur Kas</a>
                    </div></div>
                </div>
                <div class="card shadow-sm border-danger">
                     <div class="card-header bg-danger text-white"><h5 class="mb-0">Logistik Stok Kritis!</h5></div>
                     <ul class="list-group list-group-flush">
                        <c:forEach var="log" items="${dasbor.getLogistikKritis(10)}">
                            <li class="list-group-item d-flex justify-content-between align-items-center">${log.nama}<span class="badge bg-danger rounded-pill">${log.qty}</span></li>
                        </c:forEach>
                         <c:if test="${empty dasbor.getLogistikKritis(10)}"><li class="list-group-item text-muted text-center">Tidak ada stok kritis.</li></c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>