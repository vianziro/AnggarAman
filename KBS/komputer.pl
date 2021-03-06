:- dynamic explanation/1.
explanation([]).

	tambah_explanation(New) :- explanation(L1), append(L1, New, L2), retractall(explanation(L1)), asserta(explanation(L2)).
	hapusex :- retractall(explanation(_)), asserta(explanation([])).
	
% penggunaan komputer oleh masing-masing pengguna

	programming(programmer).
	
	baca_email(X) :- m_baca_email(X), atomics_to_string([X, "membutuhkan aktivitas membaca email"], ' ', Explanation), tambah_explanation([Explanation]).
	m_baca_email(anggota_dpr).
	m_baca_email(pelajar_smp).
	m_baca_email(pelajar_sma).
	m_baca_email(mahasiswa).
	m_baca_email(programmer).
	
	internet(X) :- m_internet(X), atomics_to_string([X, "membutuhkan aktivitas internet"], ' ', Explanation), tambah_explanation([Explanation]).
	m_internet(anggota_dpr).
	m_internet(pelajar_smp).
	m_internet(pelajar_sma).
	m_internet(mahasiswa).
	m_internet(programmer).
	
	grafis(X) :- m_grafis(X), atomics_to_string([X, "membutuhkan aktivitas editing grafis"], ' ', Explanation), tambah_explanation([Explanation]).
	m_grafis(programmer).
	m_grafis(editor_video).
	m_grafis(desainer).
	m_grafis(pelajar_sma).
	
	video(X) :- m_video(X), atomics_to_string([X, "membutuhkan aktivitas editing video"], ' ', Explanation), tambah_explanation([Explanation]).
	m_video(editor_video).
	
	mengetik_dokumen(X) :- m_mengetik_dokumen(X), atomics_to_string([X, "membutuhkan aktivitas mengetik dokumen"], ' ', Explanation), tambah_explanation([Explanation]).
	m_mengetik_dokumen(sekertaris).
	m_mengetik_dokumen(mahasiswa).
	m_mengetik_dokumen(pelajar_smp).
	m_mengetik_dokumen(pelajar_sma).
	m_mengetik_dokumen(pelajar_sd).
	m_mengetik_dokumen(anggota_dpr).

% kebutuhan komputasi berdasarkan kegiatan

	komputasi(X,Z) :- programming(X), Z = 300, tambah_explanation(["Penggunaan untuk programming membutuhkan komputasi sebesar 300"]).
	komputasi(X,Z) :- baca_email(X), Z = 100, tambah_explanation(["Penggunaan untuk membaca email membutuhkan komputasi sebesar 100"]).
	komputasi(X,Z) :- internet(X), Z = 150, tambah_explanation(["Penggunaan untuk aktivitas intertet membutuhkan komputasi sebesar 150"]).
	komputasi(X,Z) :- grafis(X), Z = 500, tambah_explanation(["Penggunaan untuk grafis membutuhkan komputasi sebesar 500"]).
	komputasi(X,Z) :- video(X), Z = 500, tambah_explanation(["Penggunaan untuk video editing membutuhkan komputasi sebesar 500"]).
	komputasi(X,Z) :- mengetik_dokumen(X), Z = 10, tambah_explanation(["Penggunaan untuk mengetik dokumen membutuhkan komputasi sebesar 10"]).
	
% Kelas Komputer

	kelas(1,X) :- hapusex, aggregate(sum(P), komputasi(X,P), Total), Total >= 1000, !, tambah_explanation(["Kelas 1 dipilih karena komputasi komputer lebih besar dari 1000"]).
	kelas(2,X) :- hapusex, aggregate(sum(P), komputasi(X,P), Total), Total < 1000, Total >= 500, !, tambah_explanation(["Kelas 2 dipilih karena komputasi komputer diantara 500 sampai 1000"]).
	kelas(3,X) :- hapusex, aggregate(sum(P), komputasi(X,P), Total), Total < 500, Total >= 200, !, tambah_explanation(["Kelas 3 dipilih karena komputasi komputer diantara 200 sampai 500"]).
	kelas(4,X) :- hapusex, aggregate(sum(P), komputasi(X,P), Total), Total < 200, !, tambah_explanation(["Kelas 4 dipilih karena komputasi komputer lebih kecil dari 200"]).
	