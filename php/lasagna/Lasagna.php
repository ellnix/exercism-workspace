<?php

class Lasagna
{
    // A lasagna takes 40 minutes to prep
    public function expectedCookTime()
    {
        return 40;
    }

    // @param int $elapsed_minutes The amount of time the lasagna has spent in the oven
    // @return int The remaining time left to finish cooking
    public function remainingCookTime(int $elapsed_minutes): int
    {
        return $this->expectedCookTime() - $elapsed_minutes;
    }

    // A lasagna's layers take 2 minutes to prep, each
    //
    // @param int $layers_to_prep The number of layers in the lasagna
    // @return int The number of minutes of prep
    public function totalPreparationTime(int $layers_to_prep): int
    {
        return $layers_to_prep * 2;
    }

    // The total time that has been spent on a lasangna that is in the oven
    //
    // @param int $layers_to_prep The number of layers in the lasagna that have been prepped\
    // @param int $elapsed_minutes The amount of time the lasagna has spent in the oven
    //
    // @return int The total amount of time spent in the lasagna (in minutes)
    public function totalElapsedTime(int $layers_to_prep, int $elapsed_minutes): int
    {
        return $this->totalPreparationTime($layers_to_prep) + $elapsed_minutes;
    }

    // @return 'Ding!'
    public function alarm(): string
    {
        return 'Ding!';
    }
}
