<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    protected $table = 'students';

    protected $primaryKey = 'student_id';


     /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'firstname',
        'lastname',
        'preferred_name',
        'email',
        'math_proficient',
        'reading_proficient',
        'foreign_language',
        'is_active',
    ];

        /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'account_guid',
    ];

    public function majors(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {
        $x = $this->belongsToMany(
            Major::class,
            'major_students',
            'student_id',
            'major_id',
            null,
            'major_id'
        );

        return $x;
    }

}
