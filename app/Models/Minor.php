<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Minor extends Model
{

     protected $table = 'minors';

     protected $primaryKey = 'minor_id';

     /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'minor_name',
        'minor_abberviation',
    ];

    public function courses(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {
        return $this->belongsToMany(
            Course::class,
            'course_minors',
            'minor_id',
            'course_id',
            null,
            'course_id'
        );
    }
}
