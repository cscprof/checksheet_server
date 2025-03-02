<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Psy\Output\Theme;

class CoreTheme extends Model
{
    protected $table = 'core_themes';

    protected $primaryKey = 'core_theme_id';

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'min_credits',
        'max_credits',
    ];

}
