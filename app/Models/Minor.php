<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Minor extends Model
{

     protected $table = 'minors';

     /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'minor_name',
        'minor_abberviation',
    ];


}
