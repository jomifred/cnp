!register.
+!register <- .df_register("participant").

// receives the announce of a new CNP in namespace CNPId from A
+CNPId::cfp(Task)[source(A)]
      : true // decides whether to participate
    <-  //.include("$cnp/agt/participant.asl",CNPId); // load plans participate into namespace CNPId
        .include("jar:file:/Users/jomi/tmp/cnp/build/libs/cnp-1.0.0.jar!/agt/participant.asl",CNPId);

        +CNPId::price((10*math.random)+100); // TODO: remove

        !CNPId::participate(A,Task). // start participation

// the following plans customise the participation in the CNP
// (they are used by participant.asl and so placed in CNPId namespace

// plan to compute the price for Task
+!CNPId::price(Task,P) <- .print(aqui3); P = (10*math.random)+100.

// plan to perform the contracted Task (here just print to illustrate)
+!CNPId::do <- .print("Doing my task for ",CNPId," .....").
