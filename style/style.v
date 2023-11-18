module style

@[inline]
pub fn mark(s string, ts ...TextStyle) string {
	return tag(s.to_upper(), ...ts)
}

@[inline]
pub fn tag(s string, ts ...TextStyle) string {
	return tint(' ${s} ', ...ts)
}

@[inline]
pub fn tint(s string, ts ...TextStyle) string {
	mut res := s
	for m in ts {
		res = m.style(res)
	}
	return res
}
