
# doitools

**doitools** is a Go package for working with DOI. E.g. It is used by other Caltech Library Go based projects.

```go
    doi, err := doitools.NormalizeDOI("https://dx.doi.org/10.1021/acsami.7b15651")
    if err != nil {
        // handle error
    }
    // this should print out "10.1021/acsami.7b15651"
    fmt.Printf("DOI is %q", doi)
```

