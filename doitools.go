package doitools

import (
	"fmt"
	"net/url"
	"strings"
)

const (
	Version = `v0.0.2`
)

// NormaliseDOI can take a URL to a DOI and returns just the DOI
// portion or an error message.
func NormalizeDOI(s string) (string, error) {
	if strings.HasPrefix(s, "http://") || strings.HasPrefix(s, "https://") {
		u, err := url.Parse(s)
		if err != nil {
			return "", err
		}
		if strings.HasSuffix(u.Host, "doi.org") == false {
			return u.Path[1:], fmt.Errorf("Missing doi.org from URL")
		}
		return u.Path[1:], nil
	}
	return s, nil
}
