<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MyUser extends Model
{
    public $timestamps = false;

    protected $table = 'users';

    protected $primaryKey = 'user_guid';

    protected $keyType = 'string';

     /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'firstname',
        'lastname',
        'auth_token',
        'token_expire',
        'email_address',
        'username',
        'password',
    ];

        /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];


}
