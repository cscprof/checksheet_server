<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Major extends Model
{

     protected $table = 'majors';

     protected $primaryKey = 'major_id';

     /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'major_name',
        'major_abberviation',
    ];

    public function courses(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {
        return $this->belongsToMany(
            Course::class,
            'course_majors',
            'major_id',
            'course_id',
            null,
            'course_id'
        );
    }


}
