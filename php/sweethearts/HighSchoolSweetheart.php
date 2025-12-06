<?php

class HighSchoolSweetheart
{
    public function firstLetter(string $name): string
    {
        return mb_trim($name)[0];
    }

    public function initial(string $name): string
    {
        return $this->firstLetter(mb_strtoupper($name)) . ".";
    }

    public function initials(string $name): string
    {
        $name_parts = explode(" ", $name);
        $first_name = $name_parts[0];
        $last_name = $name_parts[count($name_parts)-1];

        return $this->initial($first_name) . " " . $this->initial($last_name);
    }

    public function pair(string $sweetheart_a, string $sweetheart_b): string
    {
        $a_initials = $this->initials($sweetheart_a);
        $b_initials = $this->initials($sweetheart_b);

        return <<<HEART
                 ******       ******
               **      **   **      **
             **         ** **         **
            **            *            **
            **                         **
            **     $a_initials  +  $b_initials     **
             **                       **
               **                   **
                 **               **
                   **           **
                     **       **
                       **   **
                         ***
                          *
            HEART;
    }
}
