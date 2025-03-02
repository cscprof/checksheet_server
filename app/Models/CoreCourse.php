<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CoreCourse extends Model
{
    protected $table = 'core_theme_courses';

    protected $primaryKey = 'course_theme_id';

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'theme_id',
        'transferable',

    ];

    public function theme()
    {
        return $this->belongsTo(CoreTheme::class, 'theme_id', 'core_theme_id');
    }

    public function course()
    {
        return $this->belongsTo(Course::class, 'course_id', 'course_id');
    }


}
