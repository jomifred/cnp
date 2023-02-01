!register.
+!register <- .df_register("participant").

// receives the announce of a new CNP in namespace CNPId from A
+CNPId::cfp(Task)[source(A)]
      : true // decides whether to participate
    <-  //.include("$cnp/agt/participant.asl",CNPId); // load plans participate into namespace CNPId
        .include("jar:file:/Users/jomi/tmp/cnp/build/libs/cnp-1.0.0.jar!/agt/participant.asl",CNPId);

        // the following plans customise the participation in the CNP
        // (they are used by participant.asl and so placed in CNPId namespace

        // TODO: should as a usual plan (no .addpaln)
        .add_plan({ // plan to define  price for Task
          +!CNPId::price(P) <- .print(aqui3); P = (10*math.random)+100
        });
        .add_plan({ // plan to perform the contracted task
          +!CNPId::do <- .print("Doing my task.....")
        });

        !CNPId::participate(A,Task); // start participation
    .
