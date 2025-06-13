<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Detail Pasca Bencana - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style> body { background-color: #f4f7f6; } </style>
</head>
<body class="py-5">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="mb-0">Manajemen Pasca Bencana</h2>
                <p class="text-muted">Detail untuk bencana: ${bencana.tipe} di ${bencana.lokasi}</p>
            </div>
            <a href="${pageContext.request.contextPath}/bencana?menu=view" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left-circle"></i> Kembali
            </a>
        </div>

        <div class="row g-4">
            <div class="col-md-5">
                <div class="card shadow-sm mb-4">
                    <div class="card-header"><h4><i class="bi bi-info-circle-fill"></i> Informasi Kejadian</h4></div>
                    <div class="card-body">
                         <dl class="row"><dt class="col-sm-4">Tipe</dt><dd class="col-sm-8">${bencana.tipe}</dd><dt class="col-sm-4">Lokasi</dt><dd class="col-sm-8">${bencana.lokasi}</dd><dt class="col-sm-4">Level</dt><dd class="col-sm-8"><span class="badge bg-warning text-dark">${bencana.level}</span></dd><dt class="col-sm-4">Tanggal</dt><dd class="col-sm-8"><fmt:formatDate value="${bencana.tanggal}" pattern="dd MMM YYYY, HH:mm" /></dd></dl>
                    </div>
                </div>

                <div class="card shadow-sm">
                    <div class="card-header"><h4><i class="bi bi-people-fill"></i> Data Terdampak</h4></div>
                    <div class="card-body">
                        <%-- Formulir ini sekarang berfungsi --%>
                        <form action="${pageContext.request.contextPath}/bencana" method="post">
                            <input type="hidden" name="action" value="update_detail">
                            <input type="hidden" name="id" value="${bencana.id}">
                            <div class="mb-3">
                                <label class="form-label">Jumlah Korban</label>
                                <input type="number" name="jumlah_korban" class="form-control" value="${dataPascaBencana.jumlahKorban}">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Catatan Penting</label>
                                <textarea name="catatan" class="form-control" rows="4">${dataPascaBencana.catatan}</textarea>
                            </div>
                            <button type="submit" class="btn btn-warning w-100">Update Data Terdampak</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-7">
                <div class="card shadow-sm">
                    <div class="card-header"><h4><i class="bi bi-box-seam"></i> Logistik Terdistribusi</h4></div>
                    <div class="card-body">
                         <table class="table table-striped">
                            <thead><tr><th>Nama Logistik</th><th>Jumlah</th></tr></thead>
                            <tbody>
                                <c:forEach var="log" items="${logistikDistribusi}">
                                    <tr><td>${log.nama}</td><td>${log.qty} ${log.satuan}</td></tr>
                                </c:forEach>
                                <c:if test="${empty logistikDistribusi}">
                                    <tr><td colspan="2" class="text-center text-muted">Belum ada logistik yang didistribusikan.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer bg-light">
                         <h5 class="mb-3">Tambah Distribusi Logistik</h5>
                         <%-- Formulir ini sekarang berfungsi --%>
                         <form action="${pageContext.request.contextPath}/bencana" method="post" class="row g-2 align-items-end">
                             <input type="hidden" name="action" value="add_logistik_distribusi">
                             <input type="hidden" name="id" value="${bencana.id}">
                             <div class="col-sm-7">
                                 <label for="logistik_id" class="form-label">Pilih Logistik</label>
                                 <select name="logistik_id" id="logistik_id" class="form-select" required>
                                     <option value="">-- Pilih --</option>
                                     <c:forEach var="log" items="${semuaLogistik}">
                                        <option value="${log.id}">${log.nama} (Stok: ${log.qty})</option>
                                     </c:forEach>
                                 </select>
                             </div>
                             <div class="col-sm-3">
                                 <label for="jumlah_keluar" class="form-label">Jumlah</label>
                                 <input type="number" name="jumlah_keluar" id="jumlah_keluar" class="form-control" required>
                             </div>
                             <div class="col-sm-2">
                                 <button type="submit" class="btn btn-success w-100">Add</button>
                             </div>
                         </form>
                    </div>
                   <div class="card shadow-sm mt-4">
    <div class="card-header bg-info text-white">
        <h4><i class="bi bi-calculator-fill"></i> Rekomendasi & Status Pemenuhan Logistik</h4>
    </div>
    <div class="card-body">
        <p class="text-muted">Berdasarkan data **${dataPascaBencana.jumlahKorban} korban terdampak**, berikut adalah status pemenuhan kebutuhan logistik saat ini:</p>
        <div class="table-responsive">
            <table class="table table-sm table-bordered">
                <thead class="table-light">
                    <tr>
                        <th>Nama Logistik</th>
                        <th class="text-center">Kebutuhan Min.</th>
                        <th class="text-center">Telah Didistribusikan</th>
                        <th class="text-center">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="log" items="${semuaLogistik}">
                        <%-- Tampilkan hanya logistik yang punya rasio --%>
                        <c:if test="${log.rasioPerKorban > 0}">
                            
                            <%-- 1. Hitung kebutuhan minimal (dibulatkan ke atas) --%>
                            <c:set var="kebutuhan" value="${dataPascaBencana.jumlahKorban * log.rasioPerKorban}" />
                            <fmt:formatNumber value="${kebutuhan}" maxFractionDigits="0" var="kebutuhanBulat" />

                            <%-- 2. Cari berapa banyak item ini yang sudah didistribusikan --%>
                            <c:set var="jumlahTerdistribusi" value="0" />
                            <c:forEach var="dist" items="${logistikDistribusi}">
                                <c:if test="${log.nama == dist.nama}">
                                    <c:set var="jumlahTerdistribusi" value="${dist.qty}" />
                                </c:if>
                            </c:forEach>
                            
                            <tr>
                                <td>${log.nama}</td>
                                <td class="text-center">${kebutuhanBulat} <small class="text-muted">${log.unitRasio}</small></td>
                                <td class="text-center">${jumlahTerdistribusi} <small class="text-muted">${log.satuan}</small></td>
                                <td class="text-center">
                                    <%-- 3. Bandingkan dan tampilkan status --%>
                                    <c:choose>
                                        <c:when test="${jumlahTerdistribusi >= kebutuhanBulat}">
                                            <span class="badge bg-success"><i class="bi bi-check-circle-fill"></i> Terpenuhi</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning text-dark"><i class="bi bi-exclamation-triangle-fill"></i> Kurang</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>