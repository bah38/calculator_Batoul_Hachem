"""Basic and extended calculator operations for Lab 6."""

import math


def add(x, y):
    """Return the sum of two numbers."""
    return x + y

def subtract(x, y):
    """Return x minus y."""
    return x - y

def multiply(x, y):
    """Return the product of two numbers."""
    return x * y

def divide(x, y):
    """Return x divided by y; reject a zero divisor."""
    if y == 0:
        raise ValueError("Cannot divide by zero.")
    return x / y


def modulus(x, y):
    """Return the remainder using Python's modulo convention."""
    if y == 0:
        raise ValueError("Cannot calculate modulus with zero divisor.")
    return x % y


def power(x, y):
    """Return x raised to the power y."""
    return x ** y


def square_root(x):
    """Return the nonnegative real square root; reject negative inputs."""
    if x < 0:
        raise ValueError("Cannot calculate square root of a negative number.")
    return math.sqrt(x)
