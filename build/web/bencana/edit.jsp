<%-- /bencana/edit.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Edit Bencana - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style> body { background-color: #f4f7f6; } </style>
</head>
<body class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white p-3"><h4 class="mb-0">Formulir Edit Bencana</h4></div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/bencana" method="post">
                            <%-- Hidden input untuk memberitahu controller ini adalah aksi 'edit' --%>
                            <input type="hidden" name="action" value="edit">
                            <%-- Hidden input untuk mengirim ID bencana yang diedit --%>
                            <input type="hidden" name="id" value="${bencana.id}">
                            
                            <div class="mb-3">
                                <label for="tipe" class="form-label">Tipe Bencana</label>
                                <%-- Mengisi value input dengan data dari controller --%>
                                <input type="text" name="tipe" class="form-control" id="tipe" value="${bencana.tipe}" required>
                            </div>
                            <div class="mb-3">
                                <label for="lokasi" class="form-label">Lokasi Kejadian</label>
                                <input type="text" name="lokasi" class="form-control" id="lokasi" value="${bencana.lokasi}" required>
                            </div>
                            <div class="mb-3">
                                <label for="level" class="form-label">Level Bencana</label>
                                <select name="level" id="level" class="form-select" required>
                                    <%-- Logic untuk memilih option yang sesuai dengan data --%>
                                    <option value="Rendah" ${bencana.level == 'Rendah' ? 'selected' : ''}>Rendah</option>
                                    <option value="Sedang" ${bencana.level == 'Sedang' ? 'selected' : ''}>Sedang</option>
                                    <option value="Tinggi" ${bencana.level == 'Tinggi' ? 'selected' : ''}>Tinggi</option>
                                    <option value="Kritis" ${bencana.level == 'Kritis' ? 'selected' : ''}>Kritis</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="tanggal" class="form-label">Tanggal & Waktu Kejadian</label>
                                <%-- Memformat tanggal dari controller agar bisa dibaca input datetime-local --%>
                                <fmt:formatDate value="${bencana.tanggal}" pattern="yyyy-MM-dd'T'HH:mm" var="formattedDate" />
                                <input type="datetime-local" name="tanggal" class="form-control" id="tanggal" value="${formattedDate}" required>
                            </div>
                            <div class="d-flex justify-content-between mt-4">
                                <a href="${pageContext.request.contextPath}/bencana?menu=view" class="btn btn-secondary"><i class="bi bi-x-circle"></i> Batal</a>
                                <button type="submit" class="btn btn-warning"><i class="bi bi-arrow-repeat"></i> Update Data</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>