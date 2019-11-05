function e = ErodeList(Ig, s)
e.eroded_co41 = imerode(Ig,s.co41);
e.eroded_co42 = imerode(e.eroded_co41,s.co42);