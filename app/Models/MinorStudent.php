<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MinorStudent extends Model
{
    public $timestamps = false;

    protected $table = 'minor_students';

    protected $primaryKey = 'minor_student_id';
}
