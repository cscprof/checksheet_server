<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Major extends Model
{

     protected $table = 'majors';

     /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'major_name',
        'major_abberviation',
    ];


}
