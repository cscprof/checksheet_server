<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Course extends Model
{

     protected $table = 'courses';

     protected $primaryKey = 'course_id';

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

    public function prereqsOf(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {

        return $this->belongsToMany(
            Course::class,
            'prerequisites',
            'prereq_course_id',
            'course_id'
        );
    }

    public function prereqs(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {

        return $this->belongsToMany(
            Course::class,
            'prerequisites',
            'course_id',
            'prereq_course_id'
        );
    }

}
