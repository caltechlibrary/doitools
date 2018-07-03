package doitools

import (
	"testing"
)

func TestNormalizeDOI(t *testing.T) {
	expected := "10.1021/acsami.7b15651"
	for _, s := range []string{"http://dx.doi.org/10.1021/acsami.7b15651", "https://doi.org/10.1021/acsami.7b15651", "10.1021/acsami.7b15651"} {
		result, err := NormalizeDOI(s)
		if err != nil {
			t.Error(err)
			t.FailNow()
		}
		if expected != result {
			t.Errorf("expected %q, got %q for %q", expected, result, s)
		}
	}
}
