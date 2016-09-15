# dromedary's 'steps'

## build

The steps we present here represent a continuous delivery (CD) pipeline to an acceptance environment. In general terms this would be called a 'build' pipeline. This repository represents a _framework_ for providing classes and methods specific to your organization's canonical build pipeline. (None of these steps is intended to be an exhaustive qualification of a VCS revision's readiness for deployment to a production-like environment!)



### commit phase
- scm-polling *
- static-analysis *
- unit-testing

### accept phase
- environment-configuration *
- environment-creation *
- automated-testing *
