import 'package:go_router/go_router.dart';
import 'package:jawara_pintar/screens/bottom_nav_menu.dart';
import 'package:jawara_pintar/screens/dashboard/dashboard_menu.dart';
import 'package:jawara_pintar/screens/dashboard/section/dashboard_kegiatan_section.dart';
import 'package:jawara_pintar/screens/dashboard/section/dashboard_kependudukan_section.dart';
import 'package:jawara_pintar/screens/dashboard/section/dashboard_keuangan_section.dart';
import 'package:jawara_pintar/screens/kegiatan/kegiatan_menu.dart';
import 'package:jawara_pintar/screens/kegiatan/section/broadcast_daftar_section.dart';
import 'package:jawara_pintar/screens/kegiatan/section/kegiatan_daftar_section.dart';
import 'package:jawara_pintar/screens/kegiatan/section/pesan_warga_section.dart';
import 'package:jawara_pintar/screens/kegiatan/section/tambah/broadcast_tambah.dart';
import 'package:jawara_pintar/screens/kegiatan/section/tambah/kegiatan_tambah.dart';
import 'package:jawara_pintar/screens/keuangan/keuangan_tab/laporan_section/cetak_laporan_section.dart';
import 'package:jawara_pintar/screens/keuangan/keuangan_tab/laporan_section/laporan_pemasukan_section.dart';
import 'package:jawara_pintar/screens/keuangan/keuangan_tab/laporan_section/laporan_pengeluaran_section.dart';
import 'package:jawara_pintar/screens/keuangan/keuangan_tab/laporan_tab.dart';
import 'package:jawara_pintar/screens/keuangan/keuangan_tab/pemasukan_section/kategori_iuran_section.dart';
import 'package:jawara_pintar/screens/keuangan/keuangan_tab/pemasukan_section/pemasukan_lain_section.dart';
import 'package:jawara_pintar/screens/keuangan/keuangan_tab/pemasukan_section/pemasukan_tagihan_section.dart';
import 'package:jawara_pintar/screens/keuangan/keuangan_tab/pemasukan_tab.dart';
import 'package:jawara_pintar/screens/keuangan/keuangan_tab/pengeluaran_section/pengeluaran_daftar_section.dart';
import 'package:jawara_pintar/screens/keuangan/keuangan_tab/pengeluaran_tab.dart';
import 'package:jawara_pintar/screens/keuangan/tab_bar_keuangan.dart';
import 'package:jawara_pintar/screens/lainnya/lainnya_menu.dart';
import 'package:jawara_pintar/screens/lainnya/section/channel_transfer_section.dart';
import 'package:jawara_pintar/screens/lainnya/section/log_aktivitas_section.dart';
import 'package:jawara_pintar/screens/lainnya/section/manajemen_pengguna_section.dart';
import 'package:jawara_pintar/screens/lainnya/section/tambah_pengguna_section.dart';
import 'package:jawara_pintar/screens/login_screen.dart';
import 'package:jawara_pintar/screens/register_screen.dart';
import 'package:jawara_pintar/screens/warga/section/keluarga_section.dart';
import 'package:jawara_pintar/screens/warga/section/mutasi_keluarga_section.dart';
import 'package:jawara_pintar/screens/warga/section/penerimaan_warga_section.dart';
import 'package:jawara_pintar/screens/warga/section/rumah_section.dart';
import 'package:jawara_pintar/screens/warga/section/tambah/keluarga_tambah.dart';
import 'package:jawara_pintar/screens/warga/section/tambah/mutasi_keluarga_tambah.dart';
import 'package:jawara_pintar/screens/warga/section/tambah/penerimaan_warga_tambah.dart';
import 'package:jawara_pintar/screens/warga/section/tambah/rumah_tambah.dart';
import 'package:jawara_pintar/screens/warga/section/tambah/warga_tambah.dart';
import 'package:jawara_pintar/screens/warga/section/warga_section.dart';
import 'package:jawara_pintar/screens/warga/warga_menu.dart';

final GoRouter mainRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BottomNavMenu(state: state, child: child);
      },
      routes: [
        GoRoute(
          name: 'dashboard',
          path: '/dashboard',
          builder: (context, state) => const DashboardMenu(),
        ),
        GoRoute(
          name: 'warga',
          path: '/warga',
          builder: (context, state) => const WargaMenu(),
        ),
        ShellRoute(
          builder: (context, state, child) =>
              TabBarKeuangan(state: state, child: child),
          routes: [
            GoRoute(
              name: 'pemasukan',
              path: '/keuangan/pemasukan',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const PemasukanTab(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
            ),
            GoRoute(
              name: 'pengeluaran',
              path: '/keuangan/pengeluaran',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const PengeluaranTab(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
            ),
            GoRoute(
              name: 'laporan',
              path: '/keuangan/laporan',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const LaporanTab(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
            ),
          ],
        ),
        GoRoute(
          name: 'kegiatan',
          path: '/kegiatan',
          builder: (context, state) => const KegiatanMenu(),
        ),
        GoRoute(
          name: 'lainnya',
          path: '/lainnya',
          builder: (context, state) => const LainnyaMenu(),
        ),
      ],
    ),

    // --------------- PUSH TERPISAH DARI SHELL ROUTE ---------------
    // Push dari Menu Dashboard
    GoRoute(
      name: 'dashboard_kegiatan',
      path: '/dashboard_kegiatan',
      builder: (context, state) => const DashboardKegiatanSection(),
    ),
    GoRoute(
      name: 'dashboard_kependudukan',
      path: '/dashboard_kependudukan',
      builder: (context, state) => const DashboardKependudukanSection(),
    ),
    GoRoute(
      name: 'dashboard_keuangan',
      path: '/dashboard_keuangan',
      builder: (context, state) => const DashboardKeuanganSection(),
    ),

    // Push dari Menu Warga
    GoRoute(
      name: 'keluarga',
      path: '/keluarga',
      builder: (context, state) => const KeluargaSection(),
      routes: [
        GoRoute(
          name: 'keluarga_tambah',
          path: 'keluarga_tambah',
          builder: (context, state) => const KeluargaTambah(),
        ),
      ],
    ),
    GoRoute(
      name: 'mutasi_keluarga',
      path: '/mutasi_keluarga',
      builder: (context, state) => const MutasiKeluargaSection(),
      routes: [
        GoRoute(
          name: 'mutasi_keluarga_tambah',
          path: 'mutasi_keluarga_tambah',
          builder: (context, state) => const MutasiKeluargaTambah(),
        ),
      ],
    ),
    GoRoute(
      name: 'penerimaan_warga',
      path: '/penerimaan_warga',
      builder: (context, state) => const PenerimaanWargaSection(),
      routes: [
        GoRoute(
          name: 'penerimaan_warga_tambah',
          path: 'penerimaan_warga_tambah',
          builder: (context, state) => const PenerimaanWargaTambah(),
        ),
      ],
    ),
    GoRoute(
      name: 'rumah',
      path: '/rumah',
      builder: (context, state) => const RumahSection(),
      routes: [
        GoRoute(
          name: 'rumah_tambah',
          path: 'rumah_tambah',
          builder: (context, state) => const RumahTambah(),
        ),
      ],
    ),
    GoRoute(
      name: 'warga_section',
      path: '/warga_section',
      builder: (context, state) => const WargaSection(),
      routes: [
        GoRoute(
          name: 'warga_tambah',
          path: 'warga_tambah',
          builder: (context, state) => const WargaTambah(),
        ),
      ],
    ),

    // Push dari Menu Keuangan
    //// Keuangan - Laporan
    GoRoute(
      name: 'cetak_laporan',
      path: '/keuangan/laporan/cetak_laporan',
      builder: (context, state) => const CetakLaporanSection(),
    ),
    GoRoute(
      name: 'laporan_Pemasukan',
      path: '/keuangan/laporan/laporan_Pemasukan',
      builder: (context, state) => const LaporanPemasukanSection(),
    ),
    GoRoute(
      name: 'laporan_pengeluaran',
      path: '/keuangan/laporan/laporan_pengeluaran',
      builder: (context, state) => const LaporanPengeluaranSection(),
    ),
    //// Keuangan - Pemasukan
    GoRoute(
      name: 'kategori_iuran',
      path: '/keuangan/pemasukan/kategori_iuran',
      builder: (context, state) => KategoriIuranSection(),
    ),
    GoRoute(
      name: 'pemasukan_tagihan',
      path: '/keuangan/pemasukan/pemasukan_tagihan',
      builder: (context, state) => PemasukanTagihanSection(),
    ),
    GoRoute(
      name: 'pemasukan_lain',
      path: '/keuangan/pemasukan/pemasukan_lain',
      builder: (context, state) => const PemasukanLainSection(),
    ),
    //// Keuangan - Pengeluaran
    GoRoute(
      name: 'pengeluaran_daftar',
      path: '/keuangan/pengeluaran/pengeluaran_daftar',
      builder: (context, state) => const PengeluaranDaftarSection(),
    ),

    // Push dari Menu Kegiatan
    GoRoute(
        name: 'broadcast_daftar',
        path: '/broadcast_daftar',
        builder: (context, state) => const BroadcastDaftarSection(),
        routes: [
          GoRoute(
            name: 'broadcast_tambah',
            path: 'broadcast_tambah',
            builder: (context, state) => const BroadcastTambah(),
          )
        ]),
    GoRoute(
        name: 'kegiatan_daftar',
        path: '/kegiatan_daftar',
        builder: (context, state) => const KegiatanDaftarSection(),
        routes: [
          GoRoute(
            name: 'kegiatan_tambah',
            path: 'kegiatan_tambah',
            builder: (context, state) => const KegiatanTambah(),
          )
        ]),
    GoRoute(
      name: 'pesan_warga',
      path: '/pesan_warga',
      builder: (context, state) => const PesanWargaSection(),
    ),

    // Push dari Menu Lainnya
    GoRoute(
      name: 'channel_transfer',
      path: '/channel_transfer',
      builder: (context, state) => const ChannelTransferSection(),
    ),
    GoRoute(
      name: 'log_aktivitas',
      path: '/log_aktivitas',
      builder: (context, state) => const LogAktivitasSection(),
    ),
    GoRoute(
      name: 'manajemen_pengguna',
      path: '/manajemen_pengguna',
      builder: (context, state) => const ManajemenPenggunaSection(),
    ),
    GoRoute(
      name: 'tambah_pengguna',
      path: '/tambah_pengguna',
      builder: (context, state) => const TambahPenggunaSection(),
    ),
  ],
);
