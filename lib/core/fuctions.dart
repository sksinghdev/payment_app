abstract class Function2<I1, I2, O> {
  O call(I1 i1, I2 i2);
}

abstract class Function1<I1, O> {
  O call(I1 i1);
}
