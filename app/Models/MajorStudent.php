<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MajorStudent extends Model
{
    public $timestamps = false;

    protected $table = 'major_students';

    protected $primaryKey = 'major_student_id';


}
