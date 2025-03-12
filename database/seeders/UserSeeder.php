<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::insert([
            [
                'name' => 'Karo Lalayan',
                'email' => 'karolalayan@gmail.com',
                'password' => Hash::make('123456'),
            ],
        ]);
    }
}

