@extends('layouts.adminlte')

@section('content')
<div class="card">
    <div class="card-header">
      <h3 class="card-title">HOTEL FACILITY LIST</h3>
      <div class="card-tools">
        <a href="{{ route('hotelfacility.create') }}" class="btn btn-success btn-sm rounded-pill shadow-sm">
            <i class="fas fa-plus-circle"></i> Add Facility
        </a>        
      </div>
    </div>
    <div class="card-body">
        @php
            // Debug: Menampilkan isi variabel $datas
            // dd($datas);
            // dump($datas);
        @endphp

        <table id="facilityList" class="table table-bordered">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Facility Name</th>
                    <th>Facility Description</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($datas as $dt)
                    <tr>
                        <td>{{ $loop->iteration }}</td>
                        <td>{{ $dt->facility_name }}</td>
                        <td>{{ $dt->detail }}</td>
                        <td>
                            <div class="btn-group">
                                <a href="{{ route('hotelfacility.edit', $dt->id) }}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="{{ route('hotelfacility.delete', $dt->id) }}" onclick="return confirm('Yakin?')" class="btn btn-sm btn-danger">Delete</a>
                            </div>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
</div>

@section('js')
<script>
    $(function() {
        $("#facilityList").DataTable({
            "responsive": true,
            "paging" : false,
            "buttons": ["copy", "csv", "excel", "pdf", "print"]
        }).buttons().container().appendTo('#facilityList_wrapper .col-md-6:eq(0)');
    });
</script>
@endsection
@endsection
