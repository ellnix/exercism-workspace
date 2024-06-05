EXPECTED_BAKE_TIME = 40

LAYER_PREPARATION_TIME = 2

def bake_time_remaining(elapsed_bake_time):
    """Calculate the bake time remaining.

    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - remaining bake time (in minutes) derived from 'EXPECTED_BAKE_TIME'.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """

    return EXPECTED_BAKE_TIME - elapsed_bake_time

def preparation_time_in_minutes(layers):
    """Calculate the required time to bake a lasagna with a given number of layers.

    :param layers: int - the number of layers in lasagna
    :return: int - time required to prepare lasagna
    """

    return layers * LAYER_PREPARATION_TIME

def elapsed_time_in_minutes(layers, elapsed_baking_time):
    """Calculate the total elapsed time of a lasagna that is baking.

    :param layers: int - the number of layers in lasagna
    :param elapsed_baking_time: int - the number of minutes the lasagna has spent baking
    :return: int - total elapsed time in preparation and baking of lasagna
    """

    return preparation_time_in_minutes(layers) + elapsed_baking_time
