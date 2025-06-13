<%-- /bencana/add.jsp --%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Catat Bencana Baru - Simpasca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style> body { background-color: #f4f7f6; } </style>
</head>
<body class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white p-3"><h4 class="mb-0">Formulir Pencatatan Bencana</h4></div>
                    <div class="card-body p-4">
                        <%-- Form action mengarah ke Controller --%>
                        <form action="${pageContext.request.contextPath}/bencana" method="post">
                            <%-- Hidden input untuk memberitahu controller aksi apa yang harus dilakukan --%>
                            <input type="hidden" name="action" value="add">
                            
                            <div class="mb-3">
                                <label for="tipe" class="form-label">Tipe Bencana</label>
                                <input type="text" name="tipe" class="form-control" id="tipe" placeholder="cth: Banjir, Gempa Bumi" required>
                            </div>
                            <div class="mb-3">
                                <label for="lokasi" class="form-label">Lokasi Kejadian</label>
                                <input type="text" name="lokasi" class="form-control" id="lokasi" placeholder="cth: Jakarta Selatan" required>
                            </div>
                            <div class="mb-3">
                                <label for="level" class="form-label">Level Bencana</label>
                                <select name="level" id="level" class="form-select" required>
                                    <option value="">-- Pilih Level --</option>
                                    <option value="Rendah">Rendah</option>
                                    <option value="Sedang">Sedang</option>
                                    <option value="Tinggi">Tinggi</option>
                                    <option value="Kritis">Kritis</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="tanggal" class="form-label">Tanggal & Waktu Kejadian</label>
                                <input type="datetime-local" name="tanggal" class="form-control" id="tanggal" required>
                            </div>
                            <div class="d-flex justify-content-between mt-4">
                                <a href="${pageContext.request.contextPath}/bencana?menu=view" class="btn btn-secondary"><i class="bi bi-x-circle"></i> Batal</a>
                                <button type="submit" class="btn btn-primary"><i class="bi bi-save-fill"></i> Simpan Data</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>