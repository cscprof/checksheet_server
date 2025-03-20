<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CourseStudent extends Model
{
    protected $table = 'course_students';

    protected $primaryKey = 'course_student_id';

    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'course_id',
        'student_id',
        'grade',
        'course_status_id',
        'semester_id',
        'year',
    ];

    public function student(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(
            Student::class,
            'student_id',
            'student_id',
        );
    }

    public function course(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(
            Course::class,
            'course_id',
            'course_id',
        );
    }

    public function courseStatus(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(
            CourseStatus::class,
            'course_status_id',
            'course_status_id',
        );
    }

    public function semester(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(
            Semester::class,
            'semester_id',
            'semester_id',
        );
    }

}
