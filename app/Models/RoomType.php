<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RoomType extends Model
{
    use HasFactory;
    protected $table = 'type_rooms';
    protected $fillable = [
        'name',
        'foto',
        'price',
        'facilities',
        'information'
    ];

    public function rooms()
    {
        return $this->hasMany(Room::class, 'type_id');
    }

    public function availableRoomsCount()
    {
        return $this->rooms()->where('status', 'a')->count();
    }
}
