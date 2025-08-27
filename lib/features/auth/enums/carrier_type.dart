enum CarrierType {
  SKT('SKT', 0),
  KT('KT', 1),
  LGU('LGU+', 2),
  SKTM('SKT알뜰폰', 3),
  KTM('KT알뜰폰', 4),
  LGUM('LGU+알뜰폰', 5);

  const CarrierType(this.toLabel, this.toKey);

  final String toLabel;
  final int toKey;
}
