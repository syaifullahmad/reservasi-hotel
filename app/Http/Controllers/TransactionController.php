<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use App\Models\Log;
use App\Models\Payment;
use App\Models\Room;
use App\Models\RoomType;
use App\Models\Transaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TransactionController extends Controller
{
    public function index()
    {
        $userId = Auth::user()->id;
        $datas = Transaction::where('user_id', $userId)->get();
        $pay = Transaction::where('status', 'waiting for payment')->count();

        return view('transaction.index', compact('datas', 'pay'));
    }

    public function store(Request $request)
    {
        if (!Auth::check()) {
            return redirect()->route('login');
        }

        $dataType = RoomType::find($request->type_id);
        $check_in = Carbon::parse($request->check_in);
        $check_out = Carbon::parse($request->check_out);
        $totalMalam = $check_in->diffInDays($check_out);

        $jumlahPesanan = $request->jumlah ?? 1;

        if ($jumlahPesanan > $request->stok) {
            return redirect()->back()->with('error', 'Kamar melebihi batas!');
        }

        $dataKamar = Room::where('type_id', $request->type_id)
                         ->where('status', 'v')
                         ->take($jumlahPesanan)
                         ->get();

        $dtkmr = [];
        $nomorKamar = [];

        foreach ($dataKamar as $val) {
            $dtkmr[] = $val->id;
            $nomorKamar[] = $val->number;
            $val->update(['status' => 'r']);
        }

        $idKamar = implode(', ', $dtkmr);
        $nomorKamar = implode(', ', $nomorKamar);

        $totalHarga = $dataType->price * $totalMalam * $jumlahPesanan + random_int(100, 999);

        $transaction = Transaction::create([
            'user_id' => Auth::user()->id,
            'room_id' => $idKamar,
            'many_room' => $jumlahPesanan,
            'check_in' => $request->check_in,
            'check_out' => $request->check_out,
        ]);

        Payment::create([
            'user_id' => Auth::user()->id,
            'transaction_id' => $transaction->id,
            'price' => $totalHarga,
        ]);

        Log::create([
            'transaction_id' => $transaction->id,
            'log' => now()->format('YmdHis') . '_customer_order',
            'executor_id' => Auth::user()->id,
        ]);

        return redirect()->route('customer.pay');
    }

    public function transactionCancel($id)
    {
        $data = Transaction::find($id);
        $data->update(['status' => 'canceled']);

        $idKamar = explode(', ', $data->room_id);
        Room::whereIn('id', $idKamar)->update(['status' => 'a']);

        Log::create([
            'transaction_id' => $data->id,
            'log' => now()->format('YmdHis') . '_customer_cancel_order',
            'executor_id' => Auth::user()->id,
        ]);

        return redirect()->route('customer.transactions');
    }

    public function transactionPay(Request $request, $id)
    {
        $transaction = Transaction::find($id);
        $pay = Payment::where('transaction_id', $transaction->id)->first();

        if (!$pay) {
            return redirect()->back()->with('error', 'Payment record not found.');
        }

        $totalHarga = Payment::where('transaction_id', $transaction->id)->sum('price');

        $pay->url = match($request->pay_type) {
            'dana' => 'https://link.dana.id',
            'ovo' => 'https://ovo.id',
            'gopay' => 'https://www.gojek.com/gopay/',
            'mandiriva' => 'https://ibank.bankmandiri.co.id',
            'briva' => 'https://bri.co.id',
            'bcava' => 'https://bca.co.id',
            default => 'error'
        };

        $pay->type = match($request->pay_type) {
            'dana' => 'Dana',
            'ovo' => 'OVO',
            'gopay' => 'Gopay',
            'mandiriva' => 'Mandiri VA',
            'briva' => 'BRI VA',
            'bcava' => 'BCA VA',
            default => 'error'
        };

        $pay->nomor = match($request->pay_type) {
            'dana' => '089501157954',
            'ovo' => '089501157954',
            'gopay' => '089501157954',
            'mandiriva' => '8895089501157954',
            'briva' => '8895089501157954',
            'bcava' => '8895089501157954',
            default => 'error'
        };

        return view('payment.invoice', compact('totalHarga', 'pay', 'pay->id'));
    }

    public function reservations()
    {
        $datas = Transaction::orderBy('created_at', 'desc')->get();
        return view('receptionis.reservations', compact('datas'));
    }

    public function toProcessTransaction($id)
    {
        $data = Transaction::find($id);
        $data->update(['status' => 'process']);

        Log::create([
            'transaction_id' => $data->id,
            'log' => now()->format('YmdHis') . '_customer_pay_transaction',
            'executor_id' => Auth::user()->id,
        ]);

        Log::create([
            'transaction_id' => $data->id,
            'log' => now()->format('YmdHis') . '_receptionist_toProcess_order',
            'executor_id' => Auth::user()->id,
        ]);

        return redirect()->route('receptionis.reservations');
    }

    public function toVerifiedTransaction($id)
    {
        $data = Transaction::find($id);
        $data->update(['status' => 'verified']);

        Log::create([
            'transaction_id' => $data->id,
            'log' => now()->format('YmdHis') . '_receptionist_toVerified_order',
            'executor_id' => Auth::user()->id,
        ]);

        return redirect()->route('receptionis.reservations');
    }

    public function toFailedTransaction($id)
    {
        $data = Transaction::find($id);
        $data->update(['status' => 'failed']);

        Log::create([
            'transaction_id' => $data->id,
            'log' => now()->format('YmdHis') . '_receptionist_toFailed_order',
            'executor_id' => Auth::user()->id,
        ]);

        return redirect()->route('receptionis.reservations');
    }

    public function toRejectedTransaction($id)
    {
        $data = Transaction::find($id);
        $data->update(['status' => 'rejected']);

        Log::create([
            'transaction_id' => $data->id,
            'log' => now()->format('YmdHis') . '_receptionist_rejected_order',
            'executor_id' => Auth::user()->id,
        ]);

        return redirect()->route('receptionis.reservations');
    }

    public function transactionProof($id)
    {
        $data = Transaction::find($id);
        $roomId = explode(', ', $data->room_id);

        $kamar = Room::whereIn('id', $roomId)->get();
        $dataType = RoomType::find($kamar->first()->type_id);
        $nomorKamar = $kamar->pluck('number')->implode(', ');
        $data->nomorKamar = $nomorKamar;

        return view('bukti', compact('data'));
    }

    public function checkIn()
    {
        $transactions = Transaction::where('status', 'verified')->get();
        $datas = Transaction::where('status', 'checked in')->get();

        return view('receptionis.checkin', compact('transactions', 'datas'));
    }

    public function checkInPersonalData()
    {
        $transactions = Transaction::where('status', 'verified')->get();
        $datas = Transaction::where('status', 'checked in')->get();

        return view('receptionis.checkin-pdata', compact('transactions', 'datas'));
    }

    public function checkInPost(Request $request)
    {
        $data = Transaction::where('id', $request->transaction_id)
                            ->where('status', 'verified')
                            ->first();

        if (!$data) {
            return redirect()->back()->with('error', 'Transaction ID is not Valid');
        }

        $data->update(['status' => 'checked in']);
        $idKamar = explode(', ', $data->room_id);
        Room::whereIn('id', $idKamar)->update(['status' => 'o']);

        Log::create([
            'transaction_id' => $data->id,
            'log' => now()->format('YmdHis') . '_receptionist_customer_checkin',
            'executor_id' => Auth::user()->id,
        ]);

        return redirect()->route('receptionis.checkin')->with('status', 'Success Checked In');
    }

    public function checkInPersonalDataPost(Request $request)
    {
        $data = Transaction::where('id', $request->transaction_id)
                            ->where('status', 'verified')
                            ->first();

        if (!$data) {
            return redirect()->back()->with('error', 'Transaction ID is not Valid');
        }

        $data->update(['status' => 'checked in']);
        $idKamar = explode(', ', $data->room_id);
        Room::whereIn('id', $idKamar)->update(['status' => 'o']);

        Customer::create([
            'name' => $request->name,
            'address' => $request->address,
            'gender' => $request->gender,
            'job' => $request->job,
            'birthdate' => $request->birthdate,
            'transaction_id' => $data->id,
            'user_id' => $data->user_id,
        ]);

        Log::create([
            'transaction_id' => $data->id,
            'log' => now()->format('YmdHis') . '_receptionist_customer_checkin',
            'executor_id' => Auth::user()->id,
        ]);

        return redirect()->route('receptionis.checkin.pdata')->with('status', 'Success Checked In');
    }

    public function checkOut($id)
    {
        $data = Transaction::find($id);
        $data->update(['status' => 'checked out']);
        $idKamar = explode(', ', $data->room_id);
        Room::whereIn('id', $idKamar)->update(['status' => 'a']);

        Log::create([
            'transaction_id' => $data->id,
            'log' => now()->format('YmdHis') . '_receptionist_customer_checkout',
            'executor_id' => Auth::user()->id,
        ]);

        return redirect()->route('receptionis.checkin')->with('status', 'Success Checked Out');
    }

    public function checkPersonalDataOut($id)
    {
        $data = Transaction::find($id);
        $data->update(['status' => 'checked out']);
        $idKamar = explode(', ', $data->room_id);
        Room::whereIn('id', $idKamar)->update(['status' => 'a']);

        Log::create([
            'transaction_id' => $data->id,
            'log' => now()->format('YmdHis') . '_receptionist_customer_checkout',
            'executor_id' => Auth::user()->id,
        ]);

        return redirect()->route('receptionis.checkin.pdata')->with('status', 'Success Checked Out');
    }

    public function logs()
    {
        $datas = Log::orderBy('created_at', 'desc')->get();
        return view('app.log', compact('datas'));
    }
}
