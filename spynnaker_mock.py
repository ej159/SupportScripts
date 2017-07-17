population_count = 0
projection_count = 0
is_setup = False


class Population(object):

    def __init__(self):
        global population_count, projection_count, is_setup
        if not is_setup:
            raise Exception("not setup")
        population_count += 1
        self.id = population_count
        print "created ", self

    def __str__(self):
        return "Population:{}".format(self.id)


class Projection(object):
    def __init__(self):
        global population_count, projection_count, is_setup
        if not is_setup:
            raise Exception("not setup")
        projection_count += 1
        self.id = projection_count
        print "created ", self

    def __str__(self):
        return "Projection:{}".format(self.id)


def setup():
    global population_count, projection_count, is_setup
    if is_setup:
        raise Exception("already setup")
    population_count = 0
    projection_count = 0
    is_setup = True
    print "setup successful"


def population():
    return Population()


def projection():
    return Projection()


def run():
    global population_count, projection_count, is_setup
    if not is_setup:
        raise Exception("not setup")
    print "population:", population_count, " projection", projection_count


def end():
    global population_count, projection_count, \
        is_setup
    if not is_setup:
        raise Exception("not setup")
    is_setup = False
    print "end successful"
