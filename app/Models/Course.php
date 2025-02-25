<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Course extends Model
{

     protected $table = 'courses';

     /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'course_code',
        'course_name',
        'credits',
        'minimum_credits',
        'semester_id',
    ];


}
