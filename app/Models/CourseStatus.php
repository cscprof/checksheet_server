<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CourseStatus extends Model
{
    protected $table = 'course_statuses';

    protected $primaryKey = 'course_status_id';

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'course_status',
    ];
}
