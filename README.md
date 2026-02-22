# action-target-list

This Action allows to obtain a list of targets available for a
given Gluon release.

The target-list is returned as a JSON, so it can be used with
a matrix-strategy for building multiple concurrent targets
in a CI.


## Inputs

### gluon-path
Path to a checked-out Gluon repository.

### site-path
Path to Gluon site-directory

#### Default
`docs/site-example`

### allowlist
Space-separated list of targets which are allowed in the output list.

Any target not present in this list won't occur in the output list.

### denylist
Space-separated list of targets which are not allowed in the output list.

Any target present in this list won't occur in the output list.

### broken
Whether or not to include targets marked as `BROKEN` in the output list.


## Outputs

### targets
JSON list containing all valid targets
